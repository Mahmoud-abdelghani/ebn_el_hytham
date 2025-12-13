import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFields extends StatelessWidget {
  CustomFields({
    super.key,
    required this.fieldKey,
    required this.textEditingController,
    required this.label,
    required this.hint,
    required this.iconData,
    required this.textInputType,
    this.isObsecure,
    required this.isPassword,
    this.onTap,
    this.fieldValidator,
  });
  final GlobalKey<FormState> fieldKey;
  final TextEditingController textEditingController;
  final String label;
  final String hint;
  final IconData iconData;
  final TextInputType textInputType;
  bool? isObsecure = false;
  final bool isPassword;
  VoidCallback? onTap;
  final FormFieldValidator<String>? fieldValidator;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: fieldKey,
      child: TextFormField(
        controller: textEditingController,
        obscureText: isObsecure ?? false,
        keyboardType: textInputType,
        validator: fieldValidator,
        decoration: InputDecoration(
          prefixIcon: Icon(iconData),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: onTap,
                  icon: Icon(
                    isObsecure! ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,

          label: Text(label),
          hint: Text(hint, style: TextStyle(color: ColorGuid.mainColor)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.005),
            borderSide: BorderSide(color: ColorGuid.boardersColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.005),
            borderSide: BorderSide(color: ColorGuid.mainColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.005),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.005),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
