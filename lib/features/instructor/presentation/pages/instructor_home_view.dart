// lib/features/instructor/presentation/pages/instructor_home_view.dart

import 'package:ebn_el_hytham/features/fees/presentation/pages/instructor_salary_screen.dart';
import 'package:ebn_el_hytham/features/instructor/data/models/instructor_model.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/cubit/instructor_profile_cubit.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/pages/instructor_settings_screen.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/widgets/custom_alert_dialog.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/widgets/success_header.dart';
import 'package:ebn_el_hytham/features/materials/presentation/cubit/instructor_materials_cubit.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/instructor_materials_screen.dart';
import 'package:ebn_el_hytham/features/profile/presentation/pages/instructor_profile_screen.dart';
import 'package:ebn_el_hytham/features/results/presentation/pages/instructor_result_screen.dart';
import 'package:ebn_el_hytham/features/timetable/presentation/cubit/instructor_timetable_cubit.dart';
import 'package:ebn_el_hytham/features/timetable/presentation/pages/instructor_timetable_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';

// ════════════════════════════════════════════════════════
//  INSTRUCTOR HOME VIEW
// ════════════════════════════════════════════════════════
class InstructorHomeView extends StatefulWidget {
  const InstructorHomeView({super.key});
  static const String routeName = 'InstructorHomeView';

  @override
  State<InstructorHomeView> createState() => _InstructorHomeViewState();
}

class _InstructorHomeViewState extends State<InstructorHomeView> {
  InstructorModel? _profile;

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)!.settings.arguments as String;
    ScreenSize.init(context);

    return Scaffold(
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      body: Column(
        children: [
          // ── Header ───────────────────────────────────────────────
          BlocBuilder<InstructorProfileCubit, InstructorProfileState>(
            builder: (context, state) {
              if (state is InstructorProfileLoading ||
                  state is InstructorProfileInitial) {
                return _ShimmerHeader();
              }
              if (state is InstructorProfileError) {
                return _ErrorHeader(
                  message: state.message,
                  onRetry: () => context
                      .read<InstructorProfileCubit>()
                      .getProfileData(token: id),
                );
              }
              if (state is InstructorProfileSuccess) {
                _profile = state.profile;
                return _InstructorHeader(profile: state.profile);
              }
              return const SizedBox.shrink();
            },
          ),

          // ── Feature grid ─────────────────────────────────────────
          Expanded(
            child: _FeatureGrid(
              profile: _profile,
              id: id,
              onTapAttendance: () {
                if (_profile == null) return;
                showDialog(
                  context: context,
                  builder: (_) => CustomAlertDialog(
                    assignedMaterials: _profile!.assignedMaterials,
                  ),
                );
              },
              onTapMaterials: () {
                if (_profile == null) return;
                context
                    .read<InstructorMaterialsCubit>()
                    .fetchInstructorMaterials(instructorId: _profile!.id);
                Navigator.pushNamed(
                  context,
                  InstructorMaterialsScreen.routeName,
                );
              },
              onTapTimetable: () {
                context.read<InstructorTimetableCubit>().fetchTable(id: id);
                Navigator.pushNamed(
                  context,
                  InstructorTimetableScreen.routeName,
                );
              },
              onTapProfile: () => Navigator.pushNamed(
                context,
                InstructorProfileScreen.routeName,
                arguments: id,
              ),
              onTapSalary: () => Navigator.pushNamed(
                context,
                InstructorSalaryScreen.routeName,
              ),
              onTapResults: () => Navigator.pushNamed(
                context,
                InstructorResultScreen.routeName,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
//  HEADER — Success state
// ════════════════════════════════════════════════════════
class _InstructorHeader extends StatelessWidget {
  final InstructorModel profile;
  const _InstructorHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorGuid.surfaceColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorGuid.amber.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + ScreenSize.height * 0.018,
        left: ScreenSize.width * 0.05,
        right: ScreenSize.width * 0.05,
        bottom: ScreenSize.height * 0.028,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Avatar
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorGuid.amber, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: ColorGuid.amber.withOpacity(0.25),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: ScreenSize.height * 0.032,
                  backgroundColor: ColorGuid.scaffoldBackgroundColor,
                  backgroundImage: profile.photo.isNotEmpty
                      ? NetworkImage(profile.photo)
                      : null,
                  child: profile.photo.isEmpty
                      ? Icon(
                          Icons.person,
                          color: ColorGuid.amber,
                          size: ScreenSize.height * 0.032,
                        )
                      : null,
                ),
              ),

              // Department badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: ColorGuid.amber.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ColorGuid.amber.withOpacity(0.35)),
                ),
                child: Text(
                  profile.department.length > 22
                      ? '${profile.department.substring(0, 22)}…'
                      : profile.department,
                  style: TextStyle(
                    color: ColorGuid.amber,
                    fontSize: ScreenSize.height * 0.013,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ),

              // Bell
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: ColorGuid.textSecondary,
                      size: ScreenSize.height * 0.031,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: ColorGuid.amber,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: ScreenSize.height * 0.02),

          Text(
            'Welcome back 👋',
            style: TextStyle(
              color: ColorGuid.textSecondary,
              fontSize: ScreenSize.height * 0.015,
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.004),
          Text(
            profile.name,
            style: TextStyle(
              color: ColorGuid.textPrimary,
              fontSize: ScreenSize.height * 0.025,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.008),

          // ID + email row
          Row(
            children: [
              _InfoPill(
                icon: Icons.badge_outlined,
                label: profile.id.toString(),
              ),
              SizedBox(width: ScreenSize.width * 0.03),
              Expanded(
                child: _InfoPill(
                  icon: Icons.email_outlined,
                  label: profile.email,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: ColorGuid.amber, size: 13),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: ColorGuid.textMuted,
              fontSize: ScreenSize.height * 0.013,
            ),
          ),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════
//  HEADER — Shimmer
// ════════════════════════════════════════════════════════
class _ShimmerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorGuid.surfaceColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + ScreenSize.height * 0.018,
        left: ScreenSize.width * 0.05,
        right: ScreenSize.width * 0.05,
        bottom: ScreenSize.height * 0.028,
      ),
      child: Shimmer.fromColors(
        baseColor: ColorGuid.surfaceColor,
        highlightColor: ColorGuid.amber.withOpacity(0.15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SBox(
                  w: ScreenSize.height * 0.064,
                  h: ScreenSize.height * 0.064,
                  r: 999,
                ),
                _SBox(w: ScreenSize.width * 0.42, h: 30, r: 20),
                _SBox(w: 36, h: 36, r: 8),
              ],
            ),
            SizedBox(height: ScreenSize.height * 0.02),
            _SBox(w: ScreenSize.width * 0.28, h: 14, r: 6),
            SizedBox(height: ScreenSize.height * 0.01),
            _SBox(w: ScreenSize.width * 0.52, h: 22, r: 6),
            SizedBox(height: ScreenSize.height * 0.012),
            Row(
              children: [
                _SBox(w: ScreenSize.width * 0.22, h: 14, r: 6),
                SizedBox(width: ScreenSize.width * 0.03),
                _SBox(w: ScreenSize.width * 0.44, h: 14, r: 6),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
//  HEADER — Error
// ════════════════════════════════════════════════════════
class _ErrorHeader extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorHeader({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + ScreenSize.height * 0.018,
        left: ScreenSize.width * 0.05,
        right: ScreenSize.width * 0.05,
        bottom: ScreenSize.height * 0.028,
      ),
      decoration: BoxDecoration(
        color: ColorGuid.surfaceColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.redAccent, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.redAccent, fontSize: 13),
            ),
          ),
          TextButton(
            onPressed: onRetry,
            child: Text('Retry', style: TextStyle(color: ColorGuid.amber)),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
//  FEATURE GRID  — الـ redesign الأساسي
// ════════════════════════════════════════════════════════
class _FeatureGrid extends StatelessWidget {
  final InstructorModel? profile;
  final String id;
  final VoidCallback onTapAttendance;
  final VoidCallback onTapMaterials;
  final VoidCallback onTapTimetable;
  final VoidCallback onTapProfile;
  final VoidCallback onTapSalary;
  final VoidCallback onTapResults;

  const _FeatureGrid({
    required this.profile,
    required this.id,
    required this.onTapAttendance,
    required this.onTapMaterials,
    required this.onTapTimetable,
    required this.onTapProfile,
    required this.onTapSalary,
    required this.onTapResults,
  });

  @override
  Widget build(BuildContext context) {
    final p = ScreenSize.width * 0.04;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(p, p * 0.8, p, p),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section label ────────────────────────────────────
          Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: ColorGuid.amber,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Quick Access',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: ScreenSize.height * 0.018,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenSize.height * 0.018),

          // ══ ROW 1 — 2 featured (wide) cards ════════════════
          Row(
            children: [
              Expanded(
                child: _WideCard(
                  iconPath: 'assets/atten.png',
                  title: 'Attendance',
                  subtitle: 'Mark & track',
                  accentColor: const Color(0xFF4E6AF3),
                  onTap: onTapAttendance,
                ),
              ),
              SizedBox(width: ScreenSize.width * 0.03),
              Expanded(
                child: _WideCard(
                  iconPath: 'assets/timetable.png',
                  title: 'Time Table',
                  subtitle: 'Weekly schedule',
                  accentColor: const Color(0xFF2ECC71),
                  onTap: onTapTimetable,
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenSize.width * 0.03),

          // ══ ROW 2 — 3 compact square cards ═════════════════
          Row(
            children: [
              Expanded(
                child: _SquareCard(
                  iconPath: 'assets/sylle.png',
                  title: 'Materials',
                  onTap: onTapMaterials,
                ),
              ),
              SizedBox(width: ScreenSize.width * 0.03),
              Expanded(
                child: _SquareCard(
                  iconPath: 'assets/Faculties.png',
                  title: 'Profile',
                  onTap: onTapProfile,
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenSize.width * 0.03),

          // ══ ROW 3 — wide single card (Today's Lecture) ═════
          _BannerCard(
            iconPath: 'assets/Group.png',
            title: "Today's Lecture",
            subtitle: 'View your lectures for today',
            accentColor: const Color(0xFFE67E22),
            onTap: () {},
          ),
          SizedBox(height: ScreenSize.width * 0.03),

          // ══ ROW 4 — 2 compact cards ═════════════════════════
          Row(
            children: [
              SizedBox(width: ScreenSize.width * 0.03),
              Expanded(
                child: _SquareCard(
                  iconPath: 'assets/Swap.png',
                  title: 'Settings',

                  onTap: () {
                    if (profile == null) return;
                    Navigator.of(context).pushNamed(
                      InstructorSettingsScreen.routeName,
                      arguments: profile,
                    );
                  },
                ),
              ),
              // keep 3-col symmetry
              SizedBox(width: ScreenSize.width * 0.03),
              Expanded(child: const SizedBox.shrink()),
            ],
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
//  WIDE CARD  (featured — half width, taller)
// ════════════════════════════════════════════════════════
class _WideCard extends StatefulWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final Color accentColor;
  final VoidCallback onTap;

  const _WideCard({
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<_WideCard> createState() => _WideCardState();
}

class _WideCardState extends State<_WideCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 120),
  );
  late final Animation<double> _scale = Tween(
    begin: 1.0,
    end: 0.94,
  ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: Container(
          height: ScreenSize.height * 0.16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.accentColor.withOpacity(0.22),
                widget.accentColor.withOpacity(0.08),
              ],
            ),
            border: Border.all(
              color: widget.accentColor.withOpacity(0.4),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.accentColor.withOpacity(0.12),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: EdgeInsets.all(ScreenSize.width * 0.045),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon circle
              Container(
                width: ScreenSize.width * 0.11,
                height: ScreenSize.width * 0.11,
                decoration: BoxDecoration(
                  color: widget.accentColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.accentColor.withOpacity(0.5),
                    width: 1.2,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  widget.iconPath,
                  fit: BoxFit.contain,
                  color: widget.accentColor,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
              // Text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenSize.height * 0.017,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: ScreenSize.height * 0.013,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
//  SQUARE CARD  (compact — 1/3 width)
// ════════════════════════════════════════════════════════
class _SquareCard extends StatefulWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const _SquareCard({
    required this.iconPath,
    required this.title,
    required this.onTap,
  });

  @override
  State<_SquareCard> createState() => _SquareCardState();
}

class _SquareCardState extends State<_SquareCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 120),
  );
  late final Animation<double> _scale = Tween(
    begin: 1.0,
    end: 0.92,
  ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: Container(
          height: ScreenSize.height * 0.12,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withOpacity(0.12),
              width: 1.1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: ScreenSize.width * 0.1,
                height: ScreenSize.width * 0.1,
                decoration: BoxDecoration(
                  color: ColorGuid.amber.withOpacity(0.14),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorGuid.amber.withOpacity(0.4),
                    width: 1.2,
                  ),
                ),
                padding: const EdgeInsets.all(9),
                child: Image.asset(
                  widget.iconPath,
                  fit: BoxFit.contain,
                  color: ColorGuid.amber,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
              SizedBox(height: ScreenSize.height * 0.008),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.88),
                  fontSize: ScreenSize.height * 0.014,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
//  BANNER CARD  (full width — Today's Lecture)
// ════════════════════════════════════════════════════════
class _BannerCard extends StatefulWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final Color accentColor;
  final VoidCallback onTap;

  const _BannerCard({
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<_BannerCard> createState() => _BannerCardState();
}

class _BannerCardState extends State<_BannerCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 120),
  );
  late final Animation<double> _scale = Tween(
    begin: 1.0,
    end: 0.97,
  ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSize.width * 0.05,
            vertical: ScreenSize.height * 0.022,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                widget.accentColor.withOpacity(0.25),
                widget.accentColor.withOpacity(0.08),
              ],
            ),
            border: Border.all(
              color: widget.accentColor.withOpacity(0.45),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.accentColor.withOpacity(0.1),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: ScreenSize.width * 0.13,
                height: ScreenSize.width * 0.13,
                decoration: BoxDecoration(
                  color: widget.accentColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.accentColor.withOpacity(0.5),
                    width: 1.2,
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  widget.iconPath,
                  fit: BoxFit.contain,
                  color: widget.accentColor,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
              SizedBox(width: ScreenSize.width * 0.04),
              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenSize.height * 0.018,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: ScreenSize.height * 0.013,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: widget.accentColor.withOpacity(0.7),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
//  Shimmer Box helper
// ════════════════════════════════════════════════════════
class _SBox extends StatelessWidget {
  final double w, h, r;
  const _SBox({required this.w, required this.h, required this.r});

  @override
  Widget build(BuildContext context) => Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.08),
      borderRadius: BorderRadius.circular(r),
    ),
  );
}
