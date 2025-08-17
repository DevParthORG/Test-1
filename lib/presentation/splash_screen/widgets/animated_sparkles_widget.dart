import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import './sparkle_painter.dart';

class AnimatedSparklesWidget extends StatefulWidget {
  const AnimatedSparklesWidget({super.key});

  @override
  State<AnimatedSparklesWidget> createState() => _AnimatedSparklesWidgetState();
}

class _AnimatedSparklesWidgetState extends State<AnimatedSparklesWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<SparkleParticle> _particles;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _generateParticles();
    _animationController.repeat();
  }

  void _generateParticles() {
    final random = math.Random();
    _particles = List.generate(15, (index) {
      return SparkleParticle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: 3.0 + random.nextDouble() * 5.0,
        color: [
          AppTheme.interactivePurple,
          AppTheme.footballOrange,
          AppTheme.successGreen,
          AppTheme.lightPurpleContainer,
          AppTheme.pureWhiteText,
        ][random.nextInt(5)],
        phase: random.nextDouble() * 2 * math.pi,
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: SparklePainter(
          animation: _animationController,
          particles: _particles,
        ),
      ),
    );
  }
}
