import 'package:flutter/material.dart';
import 'dart:math' as math;

class SparklePainter extends CustomPainter {
  final Animation<double> animation;
  final List<SparkleParticle> particles;

  SparklePainter({required this.animation, required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;

    for (final particle in particles) {
      final opacity =
          (math.sin(animation.value * 2 * math.pi + particle.phase) + 1) / 2;
      paint.color = Colors.white.withValues(alpha: opacity * 0.8);

      canvas.save();
      canvas.translate(particle.x * size.width, particle.y * size.height);
      canvas.rotate(animation.value * 2 * math.pi + particle.rotation);

      // Draw star shape
      final path = Path();
      const numPoints = 4;
      const outerRadius = 3.0;
      const innerRadius = 1.5;

      for (int i = 0; i < numPoints * 2; i++) {
        final angle = (i * math.pi) / numPoints;
        final radius = i.isEven ? outerRadius : innerRadius;
        final x = math.cos(angle) * radius;
        final y = math.sin(angle) * radius;

        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();

      canvas.drawPath(path, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class SparkleParticle {
  final double x;
  final double y;
  final double phase;
  final double rotation;

  SparkleParticle({
    required this.x,
    required this.y,
    required this.phase,
    required this.rotation,
  });
}
