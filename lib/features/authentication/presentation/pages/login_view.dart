import 'package:ebn_el_hytham/core/cubit/voice_helper_cubit.dart';
import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:ebn_el_hytham/features/authentication/presentation/widgets/custom_check_box.dart';
import 'package:ebn_el_hytham/features/authentication/presentation/widgets/custom_fields.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/cubit/instructor_profile_cubit.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/pages/instructor_home_view.dart';
import 'package:ebn_el_hytham/features/students/presentation/cubit/profile_cubit.dart';
import 'package:ebn_el_hytham/features/students/presentation/pages/student_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static const String routeName = "LoginView";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool instructorChecker = false;
  bool studentChecker = false;
  bool passwordSecured = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ── Validates both forms and role, then calls login ──────────────────
  void _handleLogin(BuildContext context) {
    final emailValid = emailKey.currentState?.validate() ?? false;
    final passwordValid = passwordKey.currentState?.validate() ?? false;

    if (!emailValid || !passwordValid) return;

    if (!studentChecker && !instructorChecker) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Select The Account Type",
            style: TextStyle(
              color: context.cs.onError,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: context.cs.error,
        ),
      );
      return;
    }

    // ✅ Only the login call — navigation/snackbar handled by BlocListener
    context.read<AuthCubit>().login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return Scaffold(
      backgroundColor: context.scaffold,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  instructorChecker ? "Welcome Instructor" : "Welcome Student",
                  style: TextStyle(
                    color: context.cs.onSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor: context.accent,
              ),
            );
            instructorChecker
                ? context.read<InstructorProfileCubit>().getProfileData(
                    token: emailController.text.trim(),
                  )
                : context.read<ProfileCubit>().getProfileData(
                    token: state.token,
                  );
            await context.read<VoiceHelperCubit>().setStudentSession(
              studentChecker,
            );
            Navigator.pushReplacementNamed(
              context,
              studentChecker
                  ? StudentHomeView.routeName
                  : InstructorHomeView.routeName,
              arguments: emailController.text.trim(),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: TextStyle(
                    color: context.cs.onError,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor: context.cs.error,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ── Top branding band ───────────────────────────────────
              Container(
                width: double.infinity,
                height: ScreenSize.height * 0.35,
                decoration: BoxDecoration(
                  color: context.surface,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: context.shadowColor,
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: ScreenSize.width * 0.22,
                      height: ScreenSize.width * 0.22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.accentSubtle,
                        border: Border.all(color: context.accent, width: 2),
                      ),
                      child: Icon(
                        Icons.school_rounded,
                        color: context.accent,
                        size: ScreenSize.width * 0.12,
                      ),
                    ),
                    SizedBox(height: ScreenSize.height * 0.018),
                    Text(
                      'ابن الهيثم',
                      style: TextStyle(
                        color: context.onBackground,
                        fontWeight: FontWeight.w700,
                        fontSize: ScreenSize.height * 0.032,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: ScreenSize.height * 0.006),
                    Text(
                      'Faculty of Engineering Portal',
                      style: TextStyle(
                        color: context.onSurfaceMuted,
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenSize.height * 0.017,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Login form card ──────────────────────────────────────
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenSize.width * 0.05,
                  vertical: ScreenSize.height * 0.035,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: ScreenSize.height * 0.035,
                  horizontal: ScreenSize.width * 0.05,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    ScreenSize.height * 0.025,
                  ),
                  color: context.surface,
                  border: Border.all(color: context.glassBorder, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: context.shadowColor,
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  spacing: ScreenSize.height * 0.03,
                  children: [
                    // Section label
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 18,
                          decoration: BoxDecoration(
                            color: context.accent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Sign In',
                          style: TextStyle(
                            color: context.onBackground,
                            fontWeight: FontWeight.w700,
                            fontSize: ScreenSize.height * 0.022,
                          ),
                        ),
                      ],
                    ),

                    // ── Student/University ID field ──────────────────
                    CustomFields(
                      textEditingController: emailController,
                      fieldKey: emailKey,
                      label: "University ID",
                      hint: "Enter your University ID",
                      iconData: Icons.badge_outlined,
                      textInputType: TextInputType.number,
                      isPassword: false,
                      fieldValidator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your University ID";
                        }
                        if (!RegExp(r'^\d+$').hasMatch(value)) {
                          return "University ID must contain numbers only";
                        }
                        if (value.length < 6) {
                          return "University ID must be at least 6 digits";
                        }
                        return null;
                      },
                    ),

                    // ── National ID (password) field ─────────────────
                    CustomFields(
                      textEditingController: passwordController,
                      isPassword: true,
                      fieldKey: passwordKey,
                      label: "National ID",
                      hint: "Enter your National ID",
                      iconData: Icons.credit_card_outlined,
                      textInputType: TextInputType.number,
                      fieldValidator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your National ID";
                        }
                        if (!RegExp(r'^\d+$').hasMatch(value)) {
                          return "National ID must contain numbers only";
                        }

                        return null;
                      },
                      isObsecure: passwordSecured,
                      onTap: () {
                        setState(() => passwordSecured = !passwordSecured);
                      },
                    ),

                    // ── Role selector ────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomCheckBox(
                          value: instructorChecker,
                          txt: "Instructor",
                          onChanged: (checked) {
                            if (checked == true) {
                              setState(() {
                                instructorChecker = true;
                                studentChecker = false;
                              });
                            }
                          },
                        ),
                        CustomCheckBox(
                          value: studentChecker,
                          txt: "Student",
                          onChanged: (checked) {
                            if (checked == true) {
                              setState(() {
                                studentChecker = true;
                                instructorChecker = false;
                              });
                            }
                          },
                        ),
                      ],
                    ),

                    // ── Login button with loading state ──────────────
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        final isLoading = state is AuthLoading;
                        return SizedBox(
                          width: double.infinity,
                          height: ScreenSize.height * 0.062,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () => _handleLogin(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.accent,
                              disabledBackgroundColor: context.accent
                                  .withValues(alpha: 0.6),
                              foregroundColor: context.cs.onSecondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  ScreenSize.height * 0.016,
                                ),
                              ),
                              elevation: isLoading ? 0 : 4,
                            ),
                            child: isLoading
                                ? SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        context.cs.onSecondary,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Login',
                                    style: TextStyle(
                                      color: context.cs.onSecondary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: ScreenSize.height * 0.02,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
