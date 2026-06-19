import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Material list row item — dark surface card with amber chevron.
/// Used in Materials list screens and Results screen.
class CustomMaterialContainer extends StatelessWidget {
  const CustomMaterialContainer({
    super.key,
    required this.txt1,
    this.txt2,
    this.ontap,
  });
  final String txt1;
  final String? txt2;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ScreenSize.width * 0.04,
          vertical: ScreenSize.height * 0.004,
        ),
        padding: EdgeInsets.symmetric(
          vertical: ScreenSize.height * 0.018,
          horizontal: ScreenSize.width * 0.05,
        ),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.glassBorder, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: context.shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: ScreenSize.width * 0.6,
              child: Text(
                txt1,
                style: TextStyle(
                  color: context.onBackground,
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenSize.height * 0.019,
                ),
              ),
            ),
            Text(
              txt2 ?? "Show",
              style: TextStyle(
                color: context.accent,
                fontWeight: FontWeight.w600,
                fontSize: ScreenSize.height * 0.018,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
