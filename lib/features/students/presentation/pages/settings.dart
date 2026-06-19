import 'package:ebn_el_hytham/core/cubit/theme_cubit.dart';
import 'package:ebn_el_hytham/core/cubit/voice_helper_cubit.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/authentication/presentation/pages/login_view.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/widgets/settings_section_header.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/widgets/settings_tile.dart';
import 'package:ebn_el_hytham/features/students/data/models/profile_model.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/student_settings_profile_card.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/student_settings_voice_tile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentSettingsScreen extends StatefulWidget {
  const StudentSettingsScreen({super.key});
  static const String routeName = 'StudentSettingsScreen';

  @override
  State<StudentSettingsScreen> createState() => _StudentSettingsScreenState();
}

class _StudentSettingsScreenState extends State<StudentSettingsScreen> {
  // ── Toggle states (non-voice) ─────────────────────────────────
  bool _notificationsEnabled = true;

  // ── Voice assistant logic (kept here, away from the UI widget) ─
  Future<void> _handleVoiceToggle() async {
    final cubit = context.read<VoiceHelperCubit>();
    if (cubit.isOn) {
      await cubit.stop();
    } else {
      await cubit.start();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final p = ScreenSize.width * 0.045;
    final isStudentSession = context.watch<VoiceHelperCubit>().isStudentSession;
    final isVoiceOn = context.watch<VoiceHelperCubit>().isOn;
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark;
    final theme = Theme.of(context);
    final ProfileModel profile =
        ModalRoute.of(context)?.settings.arguments as ProfileModel;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // ── Top bar ───────────────────────────────────────────
          _SettingsTopBar(),

          // ── Content ───────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(p, p * 0.6, p, p * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Profile card ────────────────────────────
                  StudentSettingsProfileCard(
                    name: profile.name,
                    email: profile.email,
                    level: "Level ${profile.level}",
                    photoUrl: '',
                    onTap: () {},
                  ),
                  SizedBox(height: ScreenSize.height * 0.032),

                  // ══ ACCOUNT section ═════════════════════════
                  SettingsSectionHeader(title: 'Account'),
                  _SectionCard(
                    children: [
                      SettingsTile(
                        icon: Icons.person_outline_rounded,
                        title: 'Edit Profile',
                        subtitle: 'Update your personal info',
                        onTap: () {},
                      ),
                      SettingsTile(
                        icon: Icons.lock_outline_rounded,
                        title: 'Change Password',
                        subtitle: 'Keep your account secure',
                        onTap: () {},
                      ),
                      SettingsTile(
                        icon: Icons.school_outlined,
                        title: 'Academic Info',
                        subtitle: 'Level & enrolled courses',
                        onTap: () {},
                        showDivider: false,
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenSize.height * 0.028),

                  // ══ ASSISTANT section (voice tile lives here) ═
                  if (isStudentSession) ...[
                    SettingsSectionHeader(title: 'Assistant'),
                    _SectionCard(
                      children: [
                        StudentSettingsVoiceTile(
                          isOn: isVoiceOn,
                          onToggle: _handleVoiceToggle,
                          showDivider: false,
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenSize.height * 0.028),
                  ],

                  // ══ NOTIFICATIONS section ════════════════════
                  SettingsSectionHeader(title: 'Notifications'),
                  _SectionCard(
                    children: [
                      SettingsTile(
                        icon: Icons.notifications_outlined,
                        title: 'Push Notifications',
                        subtitle: 'Alerts for new events',
                        trailing: Transform.scale(
                          scale: 0.85,
                          child: Switch(
                            value: _notificationsEnabled,
                            onChanged: (v) =>
                                setState(() => _notificationsEnabled = v),
                          ),
                        ),
                        onTap: () => setState(
                          () => _notificationsEnabled = !_notificationsEnabled,
                        ),
                      ),
                      SettingsTile(
                        icon: Icons.dark_mode_outlined,
                        title: 'Dark Mode',
                        trailing: Transform.scale(
                          scale: 0.85,
                          child: Switch(
                            value: isDarkMode,
                            onChanged: (_) =>
                                context.read<ThemeCubit>().toggle(),
                          ),
                        ),
                        onTap: () => context.read<ThemeCubit>().toggle(),
                        showDivider: false,
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenSize.height * 0.028),

                  // ══ SUPPORT section ══════════════════════════
                  SettingsSectionHeader(title: 'Support'),
                  _SectionCard(
                    children: [
                      SettingsTile(
                        icon: Icons.help_outline_rounded,
                        title: 'Help Center',
                        onTap: () {},
                      ),
                      SettingsTile(
                        icon: Icons.info_outline_rounded,
                        title: 'About App',
                        subtitle: 'Version 1.0.0',
                        onTap: () {},
                        showDivider: false,
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenSize.height * 0.028),

                  // ══ Logout button ════════════════════════════
                  _LogoutButton(onTap: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
//  TOP BAR
// ════════════════════════════════════════════════════════
class _SettingsTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final cs = Theme.of(context).colorScheme;
    final accent = cs.secondary;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + ScreenSize.height * 0.012,
        left: ScreenSize.width * 0.02,
        right: ScreenSize.width * 0.05,
        bottom: ScreenSize.height * 0.018,
      ),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: accent,
              size: 20,
            ),
          ),
          SizedBox(width: ScreenSize.width * 0.01),
          Text(
            'Settings',
            style: TextStyle(
              color: cs.onSurface,
              fontSize: ScreenSize.height * 0.022,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: accent.withValues(alpha: 0.25)),
            ),
            child: Text(
              'v1.0.0',
              style: TextStyle(
                color: accent,
                fontSize: ScreenSize.height * 0.012,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
//  SECTION CARD WRAPPER
// ════════════════════════════════════════════════════════
class _SectionCard extends StatelessWidget {
  final List<Widget> children;
  const _SectionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.07)
              : cs.outlineVariant,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.15 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

// ════════════════════════════════════════════════════════
//  LOGOUT BUTTON
// ════════════════════════════════════════════════════════
class _LogoutButton extends StatefulWidget {
  final VoidCallback onTap;
  const _LogoutButton({required this.onTap});

  @override
  State<_LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<_LogoutButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    const logoutRed = Color(0xFFE74C3C);
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, LoginView.routeName);
      },
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedOpacity(
        opacity: _pressed ? 0.7 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.018),
          decoration: BoxDecoration(
            color: logoutRed.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: logoutRed.withValues(alpha: 0.4), width: 1.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.logout_rounded, color: logoutRed, size: 20),
              const SizedBox(width: 10),
              Text(
                'Log Out',
                style: TextStyle(
                  color: logoutRed,
                  fontSize: ScreenSize.height * 0.017,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
