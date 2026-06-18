import 'package:ebn_el_hytham/core/utils/color_guid.dart';
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
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.12)),
        ),
        child: Text(
          'Cancel',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white60,
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.016),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorGuid.amber, ColorGuid.amber.withOpacity(0.75)],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: ColorGuid.amber.withOpacity(0.35),
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
