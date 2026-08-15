import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Barre de progression fine avec lueur.
class AnifyProgressBar extends StatelessWidget {
  final double value; // 0..1
  final Color color;
  final double height;

  const AnifyProgressBar({
    super.key,
    required this.value,
    this.color = AppColors.accent,
    this.height = 3,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: height,
        color: const Color(0x29FFFFFF),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: value.clamp(0, 1),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(color: color.withOpacity(0.55), blurRadius: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
