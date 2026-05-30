import 'dart:ui';

import 'package:flutter/material.dart';

class CustomDottedBorder extends StatelessWidget {
  final Widget? child;
  final double width;
  final double height;
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern; // [dashWidth, dashSpace]
  final bool isHorizontal;
  final EdgeInsets padding;
  final BorderRadius? borderRadius;

  const CustomDottedBorder({
    super.key,
    this.child,
    this.width = double.infinity,
    this.height = double.infinity,
    this.color = Colors.black,
    this.strokeWidth = 2,
    this.dashPattern = const [4, 6], // Default: 4px dash, 6px space
    this.isHorizontal = true,
    this.padding = EdgeInsets.zero,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      child: CustomPaint(
        painter: _DottedBorderPainter(
          color: color,
          strokeWidth: strokeWidth,
          dashPattern: dashPattern,
          isHorizontal: isHorizontal,
          borderRadius: borderRadius,
        ),
        child: child,
      ),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;
  final bool isHorizontal;
  final BorderRadius? borderRadius;

  _DottedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashPattern,
    required this.isHorizontal,
    this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    if (borderRadius != null) {
      // Draw dotted border around the entire container
      _drawDottedRect(canvas, size, paint);
    } else {
      // Draw simple horizontal or vertical line
      _drawDottedLine(canvas, size, paint);
    }
  }

  void _drawDottedLine(Canvas canvas, Size size, Paint paint) {
    if (isHorizontal) {
      // Horizontal dotted line
      double startX = 0;
      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, size.height / 2),
          Offset(startX + dashPattern[0], size.height / 2),
          paint,
        );
        startX += dashPattern[0] + dashPattern[1];
      }
    } else {
      // Vertical dotted line
      double startY = 0;
      while (startY < size.height) {
        canvas.drawLine(
          Offset(size.width / 2, startY),
          Offset(size.width / 2, startY + dashPattern[0]),
          paint,
        );
        startY += dashPattern[0] + dashPattern[1];
      }
    }
  }

  void _drawDottedRect(Canvas canvas, Size size, Paint paint) {
    final rect = Offset.zero & size;
    final path = Path()..addRRect(borderRadius!.toRRect(rect));

    // Extract path metrics for dotted effect
    final metrics = path.computeMetrics().toList();

    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final Tangent? tangent = metric.getTangentForOffset(distance);
        if (tangent != null) {
          final double segmentLength = dashPattern[0];
          final double endDistance = (distance + segmentLength).clamp(
            0,
            metric.length,
          );

          final Tangent? endTangent = metric.getTangentForOffset(endDistance);
          if (endTangent != null) {
            canvas.drawLine(tangent.position, endTangent.position, paint);
          }
        }
        distance += dashPattern[0] + dashPattern[1];
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DottedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashPattern != dashPattern ||
        oldDelegate.isHorizontal != isHorizontal ||
        oldDelegate.borderRadius != borderRadius;
  }
}
