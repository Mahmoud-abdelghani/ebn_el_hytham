import 'package:ebn_el_hytham/core/cubit/voice_helper_cubit.dart';
import 'package:ebn_el_hytham/core/services/voice_service.dart';
import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/profile/presentation/widgets/student_profile_strings_helper.dart';
import 'package:ebn_el_hytham/features/students/data/models/profile_model.dart';
import 'package:ebn_el_hytham/features/students/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentProfileView extends StatefulWidget {
  const StudentProfileView({super.key});
  static const String routeName = 'StudentProfileView';
  static const bool readScreenAloud = true;

  /// Dynamic narration built from real profile data
  static String buildNarration(ProfileModel p) =>
      'Profile. '
      '${p.name}. '
      'ID ${p.id}. '
      '${p.department}. '
      'Email ${p.email.replaceAll('@', ' at ').replaceAll('.', ' dot ')}. '
      'C G P A ${p.cgpa}. '
      'Level ${p.level}. '
      'Date of birth ${p.dateOfBirth}. '
      'Accepting date ${p.acceptanceDate}. '
      'National ID ${p.nationalId.split('').join(' ')}. '
      'Phone ${p.phone.split('').join(' ')}. '
      'Gender ${p.gender}. '
      'Nationality ${p.nationality}. '
      'Address: ${p.address}. '
      'Status: لا يوجد اى انذارات اكاديمية.';

  @override
  State<StudentProfileView> createState() => _StudentProfileViewState();
}

class _StudentProfileViewState extends State<StudentProfileView> {
  // Use the shared VoiceService from VoiceHelperCubit — NOT a new instance.
  // Two stt.SpeechToText instances conflict on Android/iOS.
  late VoiceService _voiceService;
  bool _scheduledVoiceRead = false;
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

    // Re-init with our status callback so 'done' triggers the next session
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
    await VoiceService.speak('back');
    if (mounted) Navigator.pop(context);
  }

  Future<void> _runProfileVoiceFlow(ProfileModel profile) async {
    await VoiceService.speak(StudentProfileView.buildNarration(profile));
    if (!mounted) return;
    await _startBackListening();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Grab the shared instance before the first voice read
    _voiceService = context.read<VoiceHelperCubit>().voiceService;

    if (_scheduledVoiceRead) return;
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != StudentProfileView.readScreenAloud) return;
    _scheduledVoiceRead = true;
    final profile = context.read<ProfileCubit>().profileModel;
    if (profile == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _runProfileVoiceFlow(profile);
    });
  }

  @override
  void dispose() {
    _isListeningForBack = false;
    // Don't stop the shared service — just clear our flag
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileCubit>().profileModel;
    if (profile == null) return const SizedBox.shrink();

    return Scaffold(
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: buildDarkAppBar('Profile'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenSize.width * 0.05,
          vertical: ScreenSize.height * 0.03,
        ),
        child: Column(
          children: [
            // ── Avatar card ───────────────────────────────────────
            Center(
              child: Container(
                width: ScreenSize.width * 0.55,
                height: ScreenSize.height * 0.27,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(ScreenSize.height * 0.04),
                  border: Border.all(color: ColorGuid.amber, width: 2.5),
                  image: DecorationImage(
                    image: NetworkImage(profile.photo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.02),

            // ── Name ──────────────────────────────────────────────
            Text(
              profile.name,
              style: TextStyle(
                color: ColorGuid.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: ScreenSize.height * 0.03,
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.005),
            Text(
              "ID: ${profile.id}",
              style: TextStyle(
                color: ColorGuid.amber,
                fontWeight: FontWeight.w600,
                fontSize: ScreenSize.height * 0.022,
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.004),
            Text(
              profile.department,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorGuid.textSecondary,
                fontWeight: FontWeight.w400,
                fontSize: ScreenSize.height * 0.018,
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.004),
            Text(
              profile.email,
              style: TextStyle(
                color: ColorGuid.textMuted,
                fontWeight: FontWeight.w300,
                fontSize: ScreenSize.height * 0.015,
              ),
            ),

            // ── Divider ───────────────────────────────────────────
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: ScreenSize.height * 0.02),
              child: Divider(color: ColorGuid.boardersColor),
            ),

            // ── Academic info card ────────────────────────────────
            _SectionCard(
              title: 'Academic Info',
              icon: Icons.school_outlined,
              children: [
                StudentProfileStringsHelper(
                  firstTxt: 'CGPA',
                  secondTxt: profile.cgpa,
                ),
                StudentProfileStringsHelper(
                  firstTxt: 'Level',
                  secondTxt: profile.level,
                ),
                StudentProfileStringsHelper(
                  firstTxt: 'Date of Birth',
                  secondTxt: profile.dateOfBirth,
                ),
                StudentProfileStringsHelper(
                  firstTxt: 'Accepting Date',
                  secondTxt: profile.acceptanceDate,
                ),
              ],
            ),

            SizedBox(height: ScreenSize.height * 0.018),

            // ── Personal info card ────────────────────────────────
            _SectionCard(
              title: 'Personal Info',
              icon: Icons.person_outline,
              children: [
                StudentProfileStringsHelper(
                  firstTxt: 'Gender',
                  secondTxt: profile.gender,
                ),
                StudentProfileStringsHelper(
                  firstTxt: 'Nationality',
                  secondTxt: profile.nationality,
                ),
                StudentProfileStringsHelper(
                  firstTxt: 'Phone',
                  secondTxt: profile.phone,
                ),
                StudentProfileStringsHelper(
                  firstTxt: 'National ID',
                  secondTxt: profile.nationalId,
                ),
              ],
            ),

            SizedBox(height: ScreenSize.height * 0.018),

            // ── Address card ──────────────────────────────────────
            _SectionCard(
              title: 'Address',
              icon: Icons.location_on_outlined,
              children: [
                StudentProfileStringsHelper(
                  firstTxt: profile.address,
                ),
              ],
            ),

            SizedBox(height: ScreenSize.height * 0.02),

            // ── Status badge ──────────────────────────────────────
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: ColorGuid.success.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(color: ColorGuid.success.withOpacity(0.5)),
              ),
              child: Text(
                "✓  لا يوجد اى انذارات اكاديمية",
                style: TextStyle(
                  color: ColorGuid.success,
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenSize.height * 0.018,
                ),
              ),
            ),

            SizedBox(height: ScreenSize.height * 0.02),
          ],
        ),
      ),
    );
  }
}

// ── Reusable section card with amber header bar ───────────────────────────
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorGuid.surfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorGuid.glassBorder, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.width * 0.045,
              vertical: ScreenSize.height * 0.014,
            ),
            decoration: BoxDecoration(
              color: ColorGuid.amberSubtle,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
              border: Border(
                bottom: BorderSide(color: ColorGuid.amberBorder),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: ColorGuid.amber, size: 17),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: ColorGuid.amber,
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenSize.height * 0.016,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
          // Section rows
          Padding(
            padding: EdgeInsets.all(ScreenSize.width * 0.045),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}
