import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class StudentBannerCard extends StatefulWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final Color accentColor;
  final VoidCallback onTap;

  const StudentBannerCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<StudentBannerCard> createState() => _StudentBannerCardState();
}

class _StudentBannerCardState extends State<StudentBannerCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 120),
  );
  late final Animation<double> _scale =
      Tween(begin: 1.0, end: 0.97).animate(
          CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSize.width * 0.05,
            vertical: ScreenSize.height * 0.022,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                widget.accentColor.withOpacity(0.25),
                widget.accentColor.withOpacity(0.08),
              ],
            ),
            border: Border.all(
              color: widget.accentColor.withOpacity(0.45),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.accentColor.withOpacity(0.1),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: ScreenSize.width * 0.13,
                height: ScreenSize.width * 0.13,
                decoration: BoxDecoration(
                  color: widget.accentColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.accentColor.withOpacity(0.5),
                    width: 1.2,
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  widget.iconPath,
                  fit: BoxFit.contain,
                  color: widget.accentColor,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
              SizedBox(width: ScreenSize.width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: context.onBackground,
                        fontSize: ScreenSize.height * 0.018,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        color: context.onSurfaceMuted,
                        fontSize: ScreenSize.height * 0.013,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: widget.accentColor.withOpacity(0.7),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}