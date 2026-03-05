import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
/// Dark-themed text form field with amber focus ring and [surfaceColor] fill
class CustomFields extends StatelessWidget {
  const CustomFields({
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
  final bool? isObsecure;
  final bool isPassword;
  final VoidCallback? onTap;
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
        // Input text in primary white on dark background
        style: TextStyle(color: ColorGuid.textPrimary),
        decoration: InputDecoration(
          prefixIcon: Icon(iconData, color: ColorGuid.amber), // [amber] icons
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: onTap,
                  icon: Icon(
                    isObsecure! ? Icons.visibility : Icons.visibility_off,
                    color: ColorGuid.textSecondary, // muted visibility toggle
                  ),
                )
              : null,
          filled: true,
          // [surfaceColor] dark fill — matches the overall card surface
          fillColor: ColorGuid.surfaceColor,
          labelText: label,
          labelStyle: TextStyle(color: ColorGuid.textSecondary),
          hintText: hint,
          hintStyle: TextStyle(color: ColorGuid.textMuted),
          // Idle border — subtle dark border
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.012),
            borderSide: BorderSide(color: ColorGuid.boardersColor),
          ),
          // Focused border — amber accent ring
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.012),
            borderSide: BorderSide(color: ColorGuid.amber, width: 1.6),
          ),
          // Error borders — [error] red
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.012),
            borderSide: BorderSide(color: ColorGuid.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.012),
            borderSide: BorderSide(color: ColorGuid.error),
          ),
          errorStyle: TextStyle(color: ColorGuid.error),
        ),
      ),
    );
  }
}
