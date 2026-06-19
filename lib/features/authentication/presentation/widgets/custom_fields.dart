import 'package:ebn_el_hytham/core/utils/app_theme.dart';
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
        style: TextStyle(color: context.onBackground),
        decoration: InputDecoration(
          prefixIcon: Icon(iconData, color: context.accent),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: onTap,
                  icon: Icon(
                    isObsecure! ? Icons.visibility : Icons.visibility_off,
                    color: context.onSurfaceMuted,
                  ),
                )
              : null,
          filled: true,
          fillColor: context.surface,
          labelText: label,
          labelStyle: TextStyle(color: context.onSurfaceMuted),
          hintText: hint,
          hintStyle: TextStyle(color: context.textMuted),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.012),
            borderSide: BorderSide(color: context.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.012),
            borderSide: BorderSide(color: context.accent, width: 1.6),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.012),
            borderSide: BorderSide(color: context.cs.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.012),
            borderSide: BorderSide(color: context.cs.error),
          ),
          errorStyle: TextStyle(color: context.cs.error),
        ),
      ),
    );
  }
}
