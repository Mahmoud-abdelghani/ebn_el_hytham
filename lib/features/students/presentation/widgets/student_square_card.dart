import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class StudentSquareCard extends StatefulWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const StudentSquareCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
  });

  @override
  State<StudentSquareCard> createState() => _StudentSquareCardState();
}

class _StudentSquareCardState extends State<StudentSquareCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 120),
  );
  late final Animation<double> _scale =
      Tween(begin: 1.0, end: 0.92).animate(
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
          height: ScreenSize.height * 0.12,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withOpacity(0.12),
              width: 1.1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: ScreenSize.width * 0.1,
                height: ScreenSize.width * 0.1,
                decoration: BoxDecoration(
                  color: ColorGuid.amber.withOpacity(0.14),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorGuid.amber.withOpacity(0.4),
                    width: 1.2,
                  ),
                ),
                padding: const EdgeInsets.all(9),
                child: Image.asset(
                  widget.iconPath,
                  fit: BoxFit.contain,
                  color: ColorGuid.amber,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
              SizedBox(height: ScreenSize.height * 0.008),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.88),
                  fontSize: ScreenSize.height * 0.014,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}