import 'package:flutter/material.dart';

import '../utils/poster_palette.dart';
import 'poster_motif_painter.dart';

/// Poster génératif : gradient duotone + motif peint + vignette.
/// Aucune image sous copyright. Pose des overlays par-dessus via [children].
class PosterArt extends StatelessWidget {
  final String paletteKey;
  final double radius;
  final bool showMotif;
  final List<Widget> children;

  const PosterArt({
    super.key,
    required this.paletteKey,
    this.radius = 16,
    this.showMotif = true,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    final p = paletteFor(paletteKey);
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // base linéaire a -> b
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(-0.7, -1),
                end: const Alignment(0.7, 1),
                colors: [p.a, p.b],
              ),
            ),
          ),
          // lueur radiale haut-gauche
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.65, -0.85),
                radius: 0.95,
                colors: [p.glow.withOpacity(0.55), Colors.transparent],
                stops: const [0, 0.85],
              ),
            ),
          ),
          if (showMotif)
            CustomPaint(
              painter: PosterMotifPainter(p.motif, p.glow),
              child: const SizedBox.expand(),
            ),
          // vignette
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, -1),
                radius: 1.2,
                colors: [Colors.transparent, Color(0x59000000)],
                stops: [0.4, 1],
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
