import 'package:flutter/material.dart';
import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';

/// Pure UI tile for the Voice Assistant row.
/// All voice logic (start/stop, session checks) is handled by the
/// parent screen — this widget only renders state and forwards taps.
class StudentSettingsVoiceTile extends StatelessWidget {
  final bool isOn;
  final VoidCallback onToggle;
  final bool showDivider;

  const StudentSettingsVoiceTile({
    super.key,
    required this.isOn,
    required this.onToggle,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
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
                  color: context.accentSubtle,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: context.accentBorder,
                    width: 1,
                  ),
                ),
                child: Icon(Icons.mic_rounded, color: context.accent, size: 18),
              ),
              SizedBox(width: ScreenSize.width * 0.04),

              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Voice Assistant',
                      style: TextStyle(
                        color: context.onBackground,
                        fontSize: ScreenSize.height * 0.016,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Enable or disable Voice Assistant',
                      style: TextStyle(
                        color: context.textMuted,
                        fontSize: ScreenSize.height * 0.012,
                      ),
                    ),
                  ],
                ),
              ),

              // Mic toggle button
              IconButton(
                onPressed: onToggle,
                icon: Icon(
                  isOn ? Icons.mic_off_outlined : Icons.mic_none_rounded,
                  color: isOn ? context.accentBorder : context.accent,
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
            color: context.divider,
          ),
      ],
    );
  }
}
