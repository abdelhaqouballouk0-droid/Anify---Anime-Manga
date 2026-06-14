import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Étoiles de note sur 5 (la note Media est sur 10).
class RatingStars extends StatelessWidget {
  final double rating; // 0..10
  final double size;

  const RatingStars({super.key, required this.rating, this.size = 12});

  @override
  Widget build(BuildContext context) {
    final r5 = rating / 2;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final fill = (r5 - i).clamp(0.0, 1.0);
        return Padding(
          padding: const EdgeInsets.only(right: 1.5),
          child: Stack(
            children: [
              Icon(Icons.star_rounded, size: size, color: const Color(0xFF3A3A44)),
              ClipRect(
                clipper: _FractionClipper(fill),
                child: Icon(Icons.star_rounded, size: size, color: AppColors.star),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _FractionClipper extends CustomClipper<Rect> {
  final double fraction;
  _FractionClipper(this.fraction);

  @override
  Rect getClip(Size size) => Rect.fromLTWH(0, 0, size.width * fraction, size.height);

  @override
  bool shouldReclip(covariant _FractionClipper old) => old.fraction != fraction;
}
