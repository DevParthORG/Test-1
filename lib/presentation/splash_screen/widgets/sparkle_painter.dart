import 'package:flutter/material.dart';
import 'dart:math' as math;

class SparklePainter extends CustomPainter {
  final Animation<double> animation;
  final List<SparkleParticle> particles;

  SparklePainter({
    required this.animation,
    required this.particles,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    for (final particle in particles) {
      final opacity =
          (math.sin(animation.value * 2 * math.pi + particle.phase) + 1) / 2;
      paint.color = particle.color.withValues(alpha: opacity * 0.8);

      final x = particle.x * size.width;
      final y = particle.y * size.height;
      final currentSize = particle.size * (0.5 + opacity * 0.5);

      // Draw sparkle as a star shape
      _drawStar(canvas, paint, Offset(x, y), currentSize);
    }
  }

  void _drawStar(Canvas canvas, Paint paint, Offset center, double size) {
    final path = Path();
    const int points = 4;
    const double outerRadius = 1.0;
    const double innerRadius = 0.4;

    for (int i = 0; i < points * 2; i++) {
      final angle = (i * math.pi) / points;
      final radius = i.isEven ? outerRadius : innerRadius;
      final x = center.dx + math.cos(angle) * radius * size;
      final y = center.dy + math.sin(angle) * radius * size;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class SparkleParticle {
  final double x;
  final double y;
  final double size;
  final Color color;
  final double phase;

  SparkleParticle({
    required this.x,
    required this.y,
    required this.size,
    required this.color,
    required this.phase,
  });
}
