import 'package:flutter/material.dart';
import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';

class SettingsTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? accentColor;
  final VoidCallback onTap;
  final bool showDivider;
  final Widget? trailing;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.accentColor,
    required this.onTap,
    this.showDivider = true,
    this.trailing,
  });

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final accent = widget.accentColor ?? context.accent;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedOpacity(
        opacity: _pressed ? 0.6 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Column(
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
                    child: Icon(widget.icon, color: accent, size: 18),
                  ),
                  SizedBox(width: ScreenSize.width * 0.04),

                  // Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: context.onBackground,
                            fontSize: ScreenSize.height * 0.016,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (widget.subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            widget.subtitle!,
                            style: TextStyle(
                              color: context.textMuted,
                              fontSize: ScreenSize.height * 0.012,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Trailing
                  widget.trailing ??
                      Icon(
                        Icons.chevron_right_rounded,
                        color: context.chevronMuted,
                        size: 18,
                      ),
                ],
              ),
            ),
            if (widget.showDivider)
              Divider(
                height: 1,
                thickness: 0.5,
                indent: ScreenSize.width * 0.18,
                endIndent: ScreenSize.width * 0.04,
                color: context.cardBorder,
              ),
          ],
        ),
      ),
    );
  }
}
