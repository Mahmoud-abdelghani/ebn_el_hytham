import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class InfoPill extends StatelessWidget {
  const InfoPill(
      {required this.icon, required this.label, required this.amber});
  final IconData icon;
  final String label;
  final Color amber;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: amber, size: 13),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white38,
                fontSize: ScreenSize.height * 0.013),
          ),
        ),
      ],
    );
  }
}