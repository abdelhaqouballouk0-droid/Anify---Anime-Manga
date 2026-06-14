import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool withBackground;

  const AppLogo({super.key, this.size = 34, this.withBackground = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _AppLogoPainter(withBackground: withBackground),
      ),
    );
  }
}

class _AppLogoPainter extends CustomPainter {
  final bool withBackground;

  _AppLogoPainter({required this.withBackground});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;

    if (withBackground) {
      paint.color = Colors.black;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(size.width * 0.225),
        ),
        paint,
      );
    }

    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;

    final apexY   = h * 0.11;
    final bottomY = h * 0.88;
    final lOuterX = w * 0.05;
    final lInnerX = w * 0.28;
    final cbTopY  = h * 0.52;
    final cbBotY  = h * 0.66;

    // x of the left inner diagonal at a given y
    double lDiag(double y) =>
        cx + (y - apexY) / (bottomY - apexY) * (lInnerX - cx);

    // Left stroke: triangle — apex → outer foot → inner foot
    canvas.drawPath(
      Path()
        ..moveTo(cx, apexY)
        ..lineTo(lOuterX, bottomY)
        ..lineTo(lInnerX, bottomY)
        ..close(),
      paint,
    );

    // Right stroke: mirror of left
    canvas.drawPath(
      Path()
        ..moveTo(cx, apexY)
        ..lineTo(w - lOuterX, bottomY)
        ..lineTo(w - lInnerX, bottomY)
        ..close(),
      paint,
    );

    // Crossbar: trapezoid whose edges follow the inner diagonals
    canvas.drawPath(
      Path()
        ..moveTo(lDiag(cbTopY), cbTopY)
        ..lineTo(w - lDiag(cbTopY), cbTopY)
        ..lineTo(w - lDiag(cbBotY), cbBotY)
        ..lineTo(lDiag(cbBotY), cbBotY)
        ..close(),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _AppLogoPainter oldDelegate) =>
      oldDelegate.withBackground != withBackground;
}
