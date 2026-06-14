import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../utils/poster_palette.dart';

/// Dessine le motif décoratif "anime" par-dessus le gradient (équivalent du SVG
/// `posterMotif` du mockup). Léger, peint en quelques traits.
class PosterMotifPainter extends CustomPainter {
  final PosterMotif motif;
  final Color glow;

  PosterMotifPainter(this.motif, this.glow);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final white = Colors.white.withOpacity(0.16);
    final g = glow;

    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final fill = Paint()..style = PaintingStyle.fill;

    // Coordonnées relatives à une "toile de référence" 300x360 comme le SVG.
    double sx(double x) => x / 300 * w;
    double sy(double y) => y / 360 * h;
    Offset p(double x, double y) => Offset(sx(x), sy(y));

    switch (motif) {
      case PosterMotif.rings:
        stroke
          ..color = white
          ..strokeWidth = 2;
        canvas.drawCircle(p(150, 70), sx(60), stroke);
        canvas.drawCircle(p(150, 70), sx(96), stroke..strokeWidth = 1.5);
        canvas.drawCircle(p(40, 250), sx(52), stroke..color = g.withOpacity(0.5)..strokeWidth = 2);
        break;
      case PosterMotif.blade:
        fill.color = g.withOpacity(0.22);
        canvas.drawPath(
          Path()
            ..moveTo(sx(-10), sy(250))
            ..lineTo(sx(160), sy(40))
            ..lineTo(sx(185), sy(60))
            ..lineTo(sx(25), sy(270))
            ..close(),
          fill,
        );
        canvas.drawLine(p(120, -10), p(210, 120), stroke..color = Colors.white.withOpacity(0.18)..strokeWidth = 2);
        break;
      case PosterMotif.shards:
        fill.color = g.withOpacity(0.2);
        canvas.drawPath(
          Path()..moveTo(sx(20), sy(280))..lineTo(sx(80), sy(120))..lineTo(sx(120), sy(300))..close(),
          fill,
        );
        fill.color = Colors.white.withOpacity(0.08);
        canvas.drawPath(
          Path()..moveTo(sx(140), sy(-20))..lineTo(sx(210), sy(150))..lineTo(sx(120), sy(90))..close(),
          fill,
        );
        break;
      case PosterMotif.leaf:
        stroke..color = g.withOpacity(0.45)..strokeWidth = 2.5;
        final path = Path()
          ..moveTo(sx(40), sy(300))
          ..cubicTo(sx(120), sy(200), sx(120), sy(120), sx(60), sy(40))
          ..moveTo(sx(60), sy(40))
          ..cubicTo(sx(160), sy(90), sx(200), sy(200), sx(120), sy(300));
        canvas.drawPath(path, stroke);
        break;
      case PosterMotif.flame:
        fill.color = g.withOpacity(0.22);
        canvas.drawPath(
          Path()
            ..moveTo(sx(110), sy(300))
            ..cubicTo(sx(60), sy(240), sx(150), sy(200), sx(100), sy(120))
            ..cubicTo(sx(170), sy(160), sx(180), sy(250), sx(130), sy(300))
            ..close(),
          fill,
        );
        break;
      case PosterMotif.saw:
        stroke..color = g.withOpacity(0.55)..strokeWidth = 3;
        canvas.drawCircle(p(150, 90), sx(44), stroke);
        for (var i = 0; i < 8; i++) {
          final ang = i * math.pi / 4;
          final c = p(150, 90);
          final r1 = sx(50), r2 = sx(62);
          canvas.drawLine(
            c + Offset(math.cos(ang) * r1, math.sin(ang) * r1),
            c + Offset(math.cos(ang) * r2, math.sin(ang) * r2),
            stroke,
          );
        }
        break;
      case PosterMotif.wave:
        stroke..color = g.withOpacity(0.4)..strokeWidth = 2.5;
        canvas.drawPath(
          Path()
            ..moveTo(sx(-20), sy(210))
            ..cubicTo(sx(50), sy(170), sx(90), sy(250), sx(160), sy(210))
            ..cubicTo(sx(220), sy(178), sx(250), sy(230), sx(320), sy(200)),
          stroke,
        );
        canvas.drawPath(
          Path()
            ..moveTo(sx(-20), sy(255))
            ..cubicTo(sx(50), sy(215), sx(90), sy(295), sx(160), sy(255)),
          stroke..color = Colors.white.withOpacity(0.12)..strokeWidth = 2,
        );
        break;
      case PosterMotif.slash:
        canvas.drawLine(p(-10, 60), p(260, 250), stroke..color = g.withOpacity(0.4)..strokeWidth = 3);
        canvas.drawLine(p(-10, 110), p(210, 290), stroke..color = Colors.white.withOpacity(0.1)..strokeWidth = 2);
        break;
      case PosterMotif.stars:
        fill.color = g.withOpacity(0.6);
        _star(canvas, p(60, 60), sx(14), fill);
        _star(canvas, p(210, 120), sx(10), fill);
        _star(canvas, p(120, 240), sx(12), fill);
        break;
      case PosterMotif.petal:
        stroke..color = g.withOpacity(0.4)..strokeWidth = 2;
        for (final rot in [0.43, -0.61]) {
          canvas.save();
          canvas.translate(sx(150), sy(90));
          canvas.rotate(rot);
          canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: sx(40), height: sy(104)), stroke);
          canvas.restore();
        }
        break;
    }
  }

  void _star(Canvas canvas, Offset c, double r, Paint paint) {
    final path = Path();
    for (var i = 0; i < 10; i++) {
      final rr = i.isEven ? r : r * 0.42;
      final ang = -math.pi / 2 + i * math.pi / 5;
      final pt = c + Offset(math.cos(ang) * rr, math.sin(ang) * rr);
      i == 0 ? path.moveTo(pt.dx, pt.dy) : path.lineTo(pt.dx, pt.dy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant PosterMotifPainter old) =>
      old.motif != motif || old.glow != glow;
}
