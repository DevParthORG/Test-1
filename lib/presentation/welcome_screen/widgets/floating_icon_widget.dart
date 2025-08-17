import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class FloatingIconWidget extends StatefulWidget {
  final String iconName;
  final Color backgroundColor;
  final double size;
  final Duration animationDuration;
  final Offset startOffset;
  final Offset endOffset;

  const FloatingIconWidget({
    Key? key,
    required this.iconName,
    required this.backgroundColor,
    this.size = 60.0,
    this.animationDuration = const Duration(seconds: 3),
    required this.startOffset,
    required this.endOffset,
  }) : super(key: key);

  @override
  State<FloatingIconWidget> createState() => _FloatingIconWidgetState();
}

class _FloatingIconWidgetState extends State<FloatingIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: widget.startOffset,
      end: widget.endOffset,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offsetAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: _offsetAnimation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: widget.backgroundColor.withValues(alpha: 0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: widget.iconName,
                color: AppTheme.pureWhiteText,
                size: widget.size * 0.4,
              ),
            ),
          ),
        );
      },
    );
  }
}
