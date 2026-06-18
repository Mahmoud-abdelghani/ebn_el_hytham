import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class StudentWideCard extends StatefulWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final Color accentColor;
  final VoidCallback onTap;

  const StudentWideCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<StudentWideCard> createState() => _StudentWideCardState();
}

class _StudentWideCardState extends State<StudentWideCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 120),
  );
  late final Animation<double> _scale =
      Tween(begin: 1.0, end: 0.94).animate(
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
          height: ScreenSize.height * 0.16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.accentColor.withOpacity(0.22),
                widget.accentColor.withOpacity(0.07),
              ],
            ),
            border: Border.all(
              color: widget.accentColor.withOpacity(0.4),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.accentColor.withOpacity(0.12),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: EdgeInsets.all(ScreenSize.width * 0.045),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: ScreenSize.width * 0.11,
                height: ScreenSize.width * 0.11,
                decoration: BoxDecoration(
                  color: widget.accentColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.accentColor.withOpacity(0.5),
                    width: 1.2,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  widget.iconPath,
                  fit: BoxFit.contain,
                  color: widget.accentColor,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenSize.height * 0.017,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: ScreenSize.height * 0.013,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}