import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class AttendanceActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const AttendanceActionButtons({
    super.key,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _CancelButton(onTap: onCancel)),
        SizedBox(width: ScreenSize.width * 0.03),
        Expanded(child: _ConfirmButton(onTap: onConfirm)),
      ],
    );
  }
}

class _CancelButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CancelButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.016),
        decoration: BoxDecoration(
          color: context.glassFill,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: context.glassBorder),
        ),
        child: Text(
          'Cancel',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.onSurfaceMuted,
            fontSize: ScreenSize.height * 0.016,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  final VoidCallback onTap;
  const _ConfirmButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final accent = context.accent;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.016),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent, accent.withValues(alpha: 0.75)],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          'Confirm',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black87,
            fontSize: ScreenSize.height * 0.016,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
