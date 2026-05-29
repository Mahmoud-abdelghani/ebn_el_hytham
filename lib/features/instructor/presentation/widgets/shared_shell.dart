import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class HeaderShell extends StatelessWidget {
  const HeaderShell({required this.bgCard, required this.child});
  final Color bgCard;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgCard,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + ScreenSize.height * 0.02,
        left: ScreenSize.width * 0.05,
        right: ScreenSize.width * 0.05,
        bottom: ScreenSize.height * 0.03,
      ),
      child: child,
    );
  }
}
