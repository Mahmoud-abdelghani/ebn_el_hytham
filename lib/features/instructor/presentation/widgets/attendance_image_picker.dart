import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class AttendanceImagePicker extends StatelessWidget {
  final File? pickedImage;
  final VoidCallback onTap;

  const AttendanceImagePicker({
    super.key,
    required this.pickedImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: pickedImage == null ? _EmptyPicker() : _ImagePreview(pickedImage!),
    );
  }
}

class _EmptyPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accent = context.accent;

    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: const Radius.circular(16),
        color: accent.withValues(alpha: 0.5),
        strokeWidth: 1.5,
      ),
      child: Container(
        width: double.infinity,
        height: ScreenSize.height * 0.18,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: ScreenSize.width * 0.13,
              height: ScreenSize.width * 0.13,
              decoration: BoxDecoration(
                color: context.accentSubtle,
                shape: BoxShape.circle,
                border: Border.all(
                  color: accent.withValues(alpha: 0.4),
                  width: 1.2,
                ),
              ),
              child: Icon(
                Icons.add_photo_alternate_outlined,
                color: accent,
                size: ScreenSize.height * 0.028,
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.012),
            Text(
              'Upload attendance image',
              style: TextStyle(
                color: context.onSurfaceMuted,
                fontSize: ScreenSize.height * 0.015,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.004),
            Text(
              'Tap to select from gallery',
              style: TextStyle(
                color: context.textMuted,
                fontSize: ScreenSize.height * 0.012,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  final File image;
  const _ImagePreview(this.image);

  @override
  Widget build(BuildContext context) {
    final accent = context.accent;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            image,
            width: double.infinity,
            height: ScreenSize.height * 0.18,
            fit: BoxFit.cover,
          ),
        ),
        // Change image overlay
        Positioned(
          bottom: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: accent.withValues(alpha: 0.4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.edit_outlined,
                  color: accent,
                  size: ScreenSize.height * 0.015,
                ),
                const SizedBox(width: 4),
                Text(
                  'Change',
                  style: TextStyle(
                    color: accent,
                    fontSize: ScreenSize.height * 0.013,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
