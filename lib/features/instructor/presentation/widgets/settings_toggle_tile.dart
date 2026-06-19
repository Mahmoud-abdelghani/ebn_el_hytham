import 'package:flutter/material.dart';
import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';

class SettingsToggleTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? accentColor;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showDivider;

  const SettingsToggleTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.accentColor,
    required this.value,
    required this.onChanged,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final accent = accentColor ?? context.accent;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: ScreenSize.height * 0.014,
            horizontal: ScreenSize.width * 0.04,
          ),
          child: Row(
            children: [
              // Icon box
              Container(
                width: ScreenSize.width * 0.1,
                height: ScreenSize.width * 0.1,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: accent.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Icon(icon, color: accent, size: 18),
              ),
              SizedBox(width: ScreenSize.width * 0.04),

              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: context.onBackground,
                        fontSize: ScreenSize.height * 0.016,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          color: context.textMuted,
                          fontSize: ScreenSize.height * 0.012,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Toggle
              Transform.scale(
                scale: 0.85,
                child: Switch(
                  value: value,
                  onChanged: onChanged,
                  activeColor: accent,
                  activeTrackColor: accent.withValues(alpha: 0.3),
                  inactiveThumbColor: context.onSurfaceMuted,
                  inactiveTrackColor: context.divider,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 0.5,
            indent: ScreenSize.width * 0.18,
            endIndent: ScreenSize.width * 0.04,
            color: context.cardBorder,
          ),
      ],
    );
  }
}
