import 'package:ebn_el_hytham/core/cubit/voice_helper_cubit.dart';
import 'package:ebn_el_hytham/core/services/voice_service.dart';
import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/laiha/data/models/final_layha_model.dart';
import 'package:ebn_el_hytham/features/laiha/data/models/material_layha_model.dart';
import 'package:ebn_el_hytham/features/laiha/presentation/cubit/layha_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class LayhaView extends StatefulWidget {
  const LayhaView({super.key});
  static const String routename = 'LayhaView';

  // ── Narration builder ────────────────────────────────────────────────────
  static String buildNarration(FinalLayhaModel model) {
    final buffer = StringBuffer();
    buffer.write('اللايحة. ');
    buffer.write('القسم: ${model.department}. ');

    for (final level in model.levels) {
      // "Level_0" → "المستوى الأول"
      final levelNum =
          int.tryParse(level.level.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      buffer.write('${_levelArabic(levelNum)}. ');

      for (final mat in level.materials) {
        buffer.write('${mat.materialName}. ');
        buffer.write('الكود: ${mat.materialCode.split('').join(' ')}. ');
        buffer.write('الحالة: ${_statusArabic(mat.status)}. ');

        if (mat.requires.isNotEmpty) {
          buffer.write('المتطلبات السابقة: ');
          for (final req in mat.requires) {
            buffer.write('${req.name}. ');
          }
        }
      }
    }
    return buffer.toString();
  }

  static String _levelArabic(int n) {
    const map = {
      0: 'المستوى الأول',
      1: 'المستوى الثاني',
      2: 'المستوى الثالث',
      3: 'المستوى الرابع',
      4: 'المستوى الخامس',
      5: 'المستوى السادس',
    };
    return map[n] ?? 'المستوى ${n + 1}';
  }

  static String _statusArabic(String status) {
    switch (status.toLowerCase()) {
      case 'passed':
      case 'success':
        return 'ناجح';
      case 'failed':
        return 'راسب';
      case 'enrolled':
        return 'مسجّل';
      case 'not enrolled':
      default:
        return 'غير مسجّل';
    }
  }

  @override
  State<LayhaView> createState() => _LayhaViewState();
}

class _LayhaViewState extends State<LayhaView> {
  int selectedLevelIndex = 0;

  // ── Voice ────────────────────────────────────────────────────────────────
  late VoiceService _voiceService;
  bool _didScheduleVoice = false;
  bool _isListeningForBack = false;

  bool _isBackCommand(String text) {
    final lower = text.toLowerCase().trim();
    return lower.contains('back') ||
        lower.contains('رجوع') ||
        lower.contains('ارجع');
  }

  Future<void> _startBackListening() async {
    if (_isListeningForBack) return;
    _isListeningForBack = true;

    await _voiceService.init((status) async {
      if (status == 'done' && _isListeningForBack && mounted) {
        await _voiceService.startListening(_onBackResult);
      }
    });
    await _voiceService.startListening(_onBackResult);
  }

  Future<void> _onBackResult(String text) async {
    if (!mounted || !_isListeningForBack) return;
    if (!_isBackCommand(text)) return;
    _isListeningForBack = false;
    await VoiceService.speak('رجوع');
    if (mounted) Navigator.pop(context);
  }

  Future<void> _runVoiceFlow(FinalLayhaModel model) async {
    await VoiceService.speak(LayhaView.buildNarration(model));
    if (!mounted) return;
    await _startBackListening();
  }

  // ── Voice: trigger only when args say so AND data is ready ───────────────
  void _maybeScheduleVoice(LayhaState state) {
    if (_didScheduleVoice) return;
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != true) return; // caller must pass `arguments: true`
    if (state is! LayhaSuccess) return;

    _didScheduleVoice = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await _runVoiceFlow(state.finalLayhaModel);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _voiceService = context.read<VoiceHelperCubit>().voiceService;
  }

  @override
  void dispose() {
    _isListeningForBack = false;
    super.dispose();
  }

  // ── Status helpers ────────────────────────────────────────────────────────

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'passed':
      case 'success':
        return const Color(0xFF4CAF50);
      case 'failed':
        return const Color(0xFFE53935);
      case 'enrolled':
        return const Color(0xFF2196F3);
      case 'not enrolled':
      default:
        return const Color(0xFF757575);
    }
  }

  Color _statusBg(String status) => _statusColor(status).withOpacity(0.13);

  IconData _statusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'passed':
      case 'success':
        return Icons.check_circle_rounded;
      case 'failed':
        return Icons.cancel_rounded;
      case 'enrolled':
        return Icons.school_rounded;
      case 'not enrolled':
      default:
        return Icons.radio_button_unchecked_rounded;
    }
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: buildDarkAppBar('اللايحة'),
      body: BlocBuilder<LayhaCubit, LayhaState>(
        builder: (context, state) {
          // Try to trigger voice once data arrives
          _maybeScheduleVoice(state);

          if (state is LayhaLoading || state is LayhaInitial) {
            return _buildShimmer();
          } else if (state is LayhaError) {
            return _buildError(state.message);
          } else if (state is LayhaSuccess) {
            return _buildContent(state.finalLayhaModel);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  // ── Shimmer ───────────────────────────────────────────────────────────────

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: ColorGuid.surfaceColor,
      highlightColor: ColorGuid.surfaceColor.withOpacity(0.4),
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: ScreenSize.height * 0.025),
          ),
          SliverToBoxAdapter(child: _shimmerCard(height: 52)),
          SliverToBoxAdapter(
            child: SizedBox(height: ScreenSize.height * 0.018),
          ),
          SliverToBoxAdapter(child: _shimmerCard(height: 44)),
          SliverToBoxAdapter(
            child: SizedBox(height: ScreenSize.height * 0.022),
          ),
          SliverList.separated(
            itemCount: 6,
            separatorBuilder: (_, __) =>
                SizedBox(height: ScreenSize.height * 0.012),
            itemBuilder: (_, __) => _shimmerCard(height: 72),
          ),
        ],
      ),
    );
  }

  Widget _shimmerCard({required double height}) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.045),
      decoration: BoxDecoration(
        color: ColorGuid.surfaceColor,
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }

  // ── Error ─────────────────────────────────────────────────────────────────

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.08),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              color: ColorGuid.textSecondary,
              size: ScreenSize.height * 0.07,
            ),
            SizedBox(height: ScreenSize.height * 0.02),
            Text(
              'حدث خطأ',
              style: TextStyle(
                color: ColorGuid.textPrimary,
                fontSize: ScreenSize.height * 0.024,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.01),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorGuid.textSecondary,
                fontSize: ScreenSize.height * 0.017,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Main Content ──────────────────────────────────────────────────────────

  Widget _buildContent(FinalLayhaModel model) {
    final levels = model.levels;
    final currentLevel = levels[selectedLevelIndex];
    final materials = currentLevel.materials;

    final passed = materials
        .where((m) => m.status.toLowerCase() == 'passed')
        .length;
    final enrolled = materials
        .where((m) => m.status.toLowerCase() == 'enrolled')
        .length;
    final failed = materials
        .where((m) => m.status.toLowerCase() == 'failed')
        .length;
    final notEnrolled = materials
        .where((m) => m.status.toLowerCase() == 'not enrolled')
        .length;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: ScreenSize.height * 0.025)),

        SliverToBoxAdapter(
          child: _DepartmentBanner(department: model.department),
        ),

        SliverToBoxAdapter(child: SizedBox(height: ScreenSize.height * 0.018)),

        if (levels.length > 1)
          SliverToBoxAdapter(
            child: _LevelTabBar(
              levels: levels,
              selectedIndex: selectedLevelIndex,
              onTap: (i) => setState(() => selectedLevelIndex = i),
            ),
          ),

        if (levels.length > 1)
          SliverToBoxAdapter(
            child: SizedBox(height: ScreenSize.height * 0.018),
          ),

        SliverToBoxAdapter(
          child: _StatsRow(
            passed: passed,
            enrolled: enrolled,
            failed: failed,
            notEnrolled: notEnrolled,
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: ScreenSize.height * 0.02)),

        SliverList.separated(
          itemCount: materials.length,
          separatorBuilder: (_, __) =>
              SizedBox(height: ScreenSize.height * 0.012),
          itemBuilder: (context, index) => _MaterialCard(
            material: materials[index],
            statusColor: _statusColor(materials[index].status),
            statusBg: _statusBg(materials[index].status),
            statusIcon: _statusIcon(materials[index].status),
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: ScreenSize.height * 0.03)),
      ],
    );
  }
}

// ── Department Banner ──────────────────────────────────────────────────────────

class _DepartmentBanner extends StatelessWidget {
  final String department;
  const _DepartmentBanner({required this.department});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.045),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.05,
        vertical: ScreenSize.height * 0.016,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorGuid.amber.withOpacity(0.18), ColorGuid.surfaceColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: ColorGuid.amber.withOpacity(0.35),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorGuid.amber.withOpacity(0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.account_balance_rounded,
              color: ColorGuid.amber,
              size: ScreenSize.height * 0.028,
            ),
          ),
          SizedBox(width: ScreenSize.width * 0.035),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'القسم',
                  style: TextStyle(
                    color: ColorGuid.textSecondary,
                    fontSize: ScreenSize.height * 0.014,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  department,
                  style: TextStyle(
                    color: ColorGuid.textPrimary,
                    fontSize: ScreenSize.height * 0.019,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Level Tab Bar ──────────────────────────────────────────────────────────────

class _LevelTabBar extends StatelessWidget {
  final List<LevelModel> levels;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _LevelTabBar({
    required this.levels,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSize.height * 0.052,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.045),
        itemCount: levels.length,
        separatorBuilder: (_, __) => SizedBox(width: ScreenSize.width * 0.025),
        itemBuilder: (context, i) {
          final isSelected = i == selectedIndex;
          final levelNum =
              int.tryParse(levels[i].level.replaceAll(RegExp(r'[^0-9]'), '')) ??
              i;
          final label = 'Level ${levelNum}';
          return GestureDetector(
            onTap: () => onTap(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.width * 0.055,
              ),
              decoration: BoxDecoration(
                color: isSelected ? ColorGuid.amber : ColorGuid.surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? ColorGuid.amber : ColorGuid.glassBorder,
                  width: 1.2,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.black : ColorGuid.textSecondary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: ScreenSize.height * 0.016,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Stats Row ──────────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  final int passed, enrolled, failed, notEnrolled;
  const _StatsRow({
    required this.passed,
    required this.enrolled,
    required this.failed,
    required this.notEnrolled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.045),
      child: Row(
        children: [
          _StatChip(
            label: 'ناجح',
            count: passed,
            color: const Color(0xFF4CAF50),
          ),
          SizedBox(width: ScreenSize.width * 0.02),
          _StatChip(
            label: 'مسجّل',
            count: enrolled,
            color: const Color(0xFF2196F3),
          ),
          SizedBox(width: ScreenSize.width * 0.02),
          _StatChip(
            label: 'راسب',
            count: failed,
            color: const Color(0xFFE53935),
          ),
          SizedBox(width: ScreenSize.width * 0.02),
          _StatChip(
            label: 'غير مسجّل',
            count: notEnrolled,
            color: const Color(0xFF757575),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  const _StatChip({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.011),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          children: [
            Text(
              '$count',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w800,
                fontSize: ScreenSize.height * 0.02,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: color.withOpacity(0.8),
                fontSize: ScreenSize.height * 0.012,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Material Card ──────────────────────────────────────────────────────────────

class _MaterialCard extends StatelessWidget {
  final MaterialLayhaModel material;
  final Color statusColor;
  final Color statusBg;
  final IconData statusIcon;

  const _MaterialCard({
    required this.material,
    required this.statusColor,
    required this.statusBg,
    required this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    final hasRequirements = material.requires.isNotEmpty;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.045),
      decoration: BoxDecoration(
        color: ColorGuid.surfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorGuid.glassBorder, width: 1.2),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(
            horizontal: ScreenSize.width * 0.045,
            vertical: ScreenSize.height * 0.004,
          ),
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          shape: const Border(),
          collapsedShape: const Border(),
          enabled: hasRequirements,
          iconColor: hasRequirements ? ColorGuid.amber : Colors.transparent,
          collapsedIconColor: hasRequirements
              ? ColorGuid.textSecondary
              : Colors.transparent,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.width * 0.025,
                  vertical: ScreenSize.height * 0.005,
                ),
                decoration: BoxDecoration(
                  color: ColorGuid.amber.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: ColorGuid.amber.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  material.materialCode,
                  style: TextStyle(
                    color: ColorGuid.amber,
                    fontSize: ScreenSize.height * 0.013,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              SizedBox(width: ScreenSize.width * 0.03),
              Expanded(
                child: Text(
                  material.materialName,
                  style: TextStyle(
                    color: ColorGuid.textPrimary,
                    fontSize: ScreenSize.height * 0.017,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: ScreenSize.height * 0.007),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.width * 0.028,
                    vertical: ScreenSize.height * 0.005,
                  ),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: statusColor.withOpacity(0.35),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        statusIcon,
                        color: statusColor,
                        size: ScreenSize.height * 0.015,
                      ),
                      SizedBox(width: ScreenSize.width * 0.015),
                      Text(
                        material.status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: ScreenSize.height * 0.013,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (hasRequirements) ...[
                  SizedBox(width: ScreenSize.width * 0.02),
                  Text(
                    '${material.requires.length} متطلب',
                    style: TextStyle(
                      color: ColorGuid.textSecondary,
                      fontSize: ScreenSize.height * 0.013,
                    ),
                  ),
                ],
              ],
            ),
          ),
          children: hasRequirements
              ? [
                  Divider(
                    color: ColorGuid.glassBorder,
                    height: 1,
                    thickness: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize.width * 0.045,
                      vertical: ScreenSize.height * 0.012,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'المتطلبات السابقة',
                          style: TextStyle(
                            color: ColorGuid.textSecondary,
                            fontSize: ScreenSize.height * 0.014,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4,
                          ),
                        ),
                        SizedBox(height: ScreenSize.height * 0.01),
                        ...material.requires.map(
                          (req) => Padding(
                            padding: EdgeInsets.only(
                              bottom: ScreenSize.height * 0.008,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: ColorGuid.amber,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: ScreenSize.width * 0.03),
                                Text(
                                  req.code,
                                  style: TextStyle(
                                    color: ColorGuid.amber,
                                    fontSize: ScreenSize.height * 0.014,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: ScreenSize.width * 0.025),
                                Expanded(
                                  child: Text(
                                    req.name,
                                    style: TextStyle(
                                      color: ColorGuid.textPrimary.withOpacity(
                                        0.8,
                                      ),
                                      fontSize: ScreenSize.height * 0.015,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              : [],
        ),
      ),
    );
  }
}
