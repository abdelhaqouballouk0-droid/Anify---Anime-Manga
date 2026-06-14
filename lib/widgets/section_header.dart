import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// En-tête de section : sous-titre optionnel + titre + action.
class SectionHeader extends StatelessWidget {
  final String title;
  final String? overline;
  final Color? overlineColor;
  final String action;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.overline,
    this.overlineColor,
    this.action = 'See all',
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (overline != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text(
                      overline!.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                        color: overlineColor ?? AppColors.accent300,
                      ),
                    ),
                  ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                    color: AppColors.text1,
                  ),
                ),
              ],
            ),
          ),
          if (onAction != null)
            GestureDetector(
              onTap: onAction,
              child: Text(
                action,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text2,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
