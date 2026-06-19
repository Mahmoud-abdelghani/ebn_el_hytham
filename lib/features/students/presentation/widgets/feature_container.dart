import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class FeatureContainer extends StatefulWidget {
  const FeatureContainer({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
  });
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  @override
  State<FeatureContainer> createState() => _FeatureContainerState();
}

class _FeatureContainerState extends State<FeatureContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 130),
      lowerBound: 0.0,
      upperBound: 0.06,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _controller.forward();
  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
    widget.onTap();
  }
  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            decoration: BoxDecoration(
              color: context.glassFill,
              borderRadius: BorderRadius.circular(ScreenSize.height * 0.022),
              border: Border.all(
                color: context.glassBorder,
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: context.shadowColor,
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: ScreenSize.width * 0.13,
                  height: ScreenSize.width * 0.13,
                  decoration: BoxDecoration(
                    color: context.accentSubtle,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.accentBorder,
                      width: 1.4,
                    ),
                  ),
                  padding: const EdgeInsets.all(11),
                  child: Image.asset(
                    widget.iconPath,
                    fit: BoxFit.contain,
                    color: context.accent,
                    colorBlendMode: BlendMode.srcIn,
                  ),
                ),
                SizedBox(height: ScreenSize.height * 0.009),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: context.onBackground,
                    fontSize: ScreenSize.height * 0.015,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
