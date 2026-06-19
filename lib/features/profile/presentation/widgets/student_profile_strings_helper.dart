import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Key-value info row used in profile and material detail screens.
/// [textSecondary] label + [textPrimary] value on dark background.
class StudentProfileStringsHelper extends StatelessWidget {
  const StudentProfileStringsHelper({
    super.key,
    required this.firstTxt,
    this.secondTxt,
  });
  final String firstTxt;
  final String? secondTxt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.004),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            firstTxt,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              // [textSecondary] for label — visible but not dominant
              color: context.onSurfaceMuted,
              fontWeight: FontWeight.w400,
              fontSize: ScreenSize.height * 0.015,
            ),
          ),
          secondTxt != null
              ? Text(
                  secondTxt!,
                  style: TextStyle(
                    // [amber] for value — draws attention to key data
                    color: context.accent,
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenSize.height * 0.015,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
