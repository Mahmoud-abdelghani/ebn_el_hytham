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
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/Rectangle 6540.png',
              width: ScreenSize.width,
              height: ScreenSize.height * 0.35,
              fit: BoxFit.fill,
            ),
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
                borderRadius: BorderRadius.circular(ScreenSize.height * 0.02),
                color: Colors.white,
              ),
              child: Column(
                spacing: ScreenSize.height * 0.03,
                children: [
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
                  CustomFields(
                    textEditingController: passwordController,
                    isPassword: true,
                    fieldKey: passwordKey,
                    label: "Password",
                    hint: "Enter Your Password",
                    iconData: Icons.lock_outline,
                    textInputType: TextInputType.number,
                    fieldValidator: (value) {
                      if (value!.isEmpty) {
                        return "enter your password";
                      } else {
                        return null;
                      }
                    },
                    isObsecure: passwordSecuired,
                    onTap: () {
                      setState(() {
                        passwordSecuired = !passwordSecuired;
                      });
                    },
                  ),
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
                        txt: "Strudent",
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
                  CustomButton(
                    onTap: () {
                      if (emailKey.currentState!.validate() ||
                          passwordKey.currentState!.validate()) {}
                      if (emailKey.currentState!.validate() &&
                          passwordKey.currentState!.validate()) {
                        if (studenChecker || instructorChercker) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: instructorChercker
                                  ? Text(
                                      "Welcome Instructor",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : Text(
                                      "Welcome Student",
                                      style: TextStyle(color: Colors.white),
                                    ),
                              backgroundColor: ColorGuid.mainColor,
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
                              backgroundColor: Colors.red,
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
