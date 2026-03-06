import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/authentication/presentation/widgets/custom_button.dart';
import 'package:ebn_el_hytham/features/authentication/presentation/widgets/custom_check_box.dart';
import 'package:ebn_el_hytham/features/authentication/presentation/widgets/custom_fields.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/pages/instructor_home_view.dart';
import 'package:ebn_el_hytham/features/students/presentation/pages/student_home_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static const String routeName = "LoginView";
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool instructorChercker = false;
  bool studenChecker = false;

  bool passwordSecuired = true;

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      // [scaffoldBackgroundColor] — deep charcoal replaces old light grey
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Top branding band — [surfaceColor] card header ──────────
            Container(
              width: double.infinity,
              height: ScreenSize.height * 0.35,
              decoration: BoxDecoration(
                // [surfaceColor] replaces the old PNG header image
                color: ColorGuid.surfaceColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Amber logo icon ring
                  Container(
                    width: ScreenSize.width * 0.22,
                    height: ScreenSize.width * 0.22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorGuid.amberSubtle,
                      border: Border.all(color: ColorGuid.amber, width: 2),
                    ),
                    child: Icon(
                      Icons.school_rounded,
                      color: ColorGuid.amber, // [amber] brand icon
                      size: ScreenSize.width * 0.12,
                    ),
                  ),
                  SizedBox(height: ScreenSize.height * 0.018),
                  // App name in white
                  Text(
                    'ابن الهيثم',
                    style: TextStyle(
                      color: ColorGuid.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: ScreenSize.height * 0.032,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: ScreenSize.height * 0.006),
                  Text(
                    'Faculty of Engineering Portal',
                    style: TextStyle(
                      color: ColorGuid.textSecondary, // subtle subheading
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenSize.height * 0.017,
                    ),
                  ),
                ],
              ),
            ),

            // ── Login form card ───────────────────────────────────────────
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
                // [surfaceColor] card — dark glass feel
                borderRadius: BorderRadius.circular(ScreenSize.height * 0.025),
                color: ColorGuid.surfaceColor,
                border: Border.all(color: ColorGuid.glassBorder, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                spacing: ScreenSize.height * 0.03,
                children: [
                  // Section label with [amber] left bar
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 18,
                        decoration: BoxDecoration(
                          color: ColorGuid.amber, // [amber] accent bar
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Sign In',
                        style: TextStyle(
                          color: ColorGuid.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenSize.height * 0.022,
                        ),
                      ),
                    ],
                  ),

                  // Email field
                  CustomFields(
                    textEditingController: emailController,
                    fieldKey: emailKey,
                    label: "Email",
                    hint: "Enter your Email",
                    iconData: Icons.email_outlined,
                    textInputType: TextInputType.emailAddress,
                    isPassword: false,
                    fieldValidator: (value) {
                      if (value!.isEmpty) {
                        return "fill your email";
                      } else if (!value.contains('@')) {
                        return "please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                  ),

                  // Password field
                  CustomFields(
                    textEditingController: passwordController,
                    isPassword: true,
                    fieldKey: passwordKey,
                    label: "Password",
                    hint: "Enter Your Password",
                    iconData: Icons.lock_outline,
                    textInputType: TextInputType.number,
                    fieldValidator: (value) {
                      if (value!.isEmpty) return "enter your password";
                      return null;
                    },
                    isObsecure: passwordSecuired,
                    onTap: () {
                      setState(() {
                        passwordSecuired = !passwordSecuired;
                      });
                    },
                  ),

                  // Role selector row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomCheckBox(
                        value: instructorChercker,
                        txt: "Instructor",
                        onChanged: (checked) {
                          if (checked!) {
                            instructorChercker = true;
                            studenChecker = false;
                            setState(() {});
                          }
                        },
                      ),
                      CustomCheckBox(
                        value: studenChecker,
                        txt: "Student",
                        onChanged: (checked) {
                          if (checked!) {
                            studenChecker = true;
                            instructorChercker = false;
                          }
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  // Login button
                  CustomButton(
                    onTap: () {
                      if (emailKey.currentState!.validate() ||
                          passwordKey.currentState!.validate()) {}
                      if (emailKey.currentState!.validate() &&
                          passwordKey.currentState!.validate()) {
                        if (studenChecker || instructorChercker) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                instructorChercker
                                    ? "Welcome Instructor"
                                    : "Welcome Student",
                                style: TextStyle(
                                  // Dark text on amber snackbar
                                  color: Color(0xFF161B22),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // [amber] snackbar background
                              backgroundColor: ColorGuid.amber,
                            ),
                          );
                          Navigator.pushReplacementNamed(
                            context,
                            studenChecker
                                ? StudentHomeView.routeName
                                : InstructorHomeView.routeName,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Select The Account Type"),
                              // [error] red for validation failure
                              backgroundColor: ColorGuid.error,
                            ),
                          );
                        }
                      }
                    },
                    txt: 'LogIn',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
