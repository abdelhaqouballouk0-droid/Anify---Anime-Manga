import 'dart:ui';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum PillTone { glass, accent, teal, solid, neo }

/// Badge / pill compact, fond translucide flouté, texte coloré.
class Pill extends StatelessWidget {
  final String text;
  final PillTone tone;
  final Widget? icon;

  const Pill(this.text, {super.key, this.tone = PillTone.glass, this.icon});

  @override
  Widget build(BuildContext context) {
    late Color bg, fg, border;
    Gradient? gradient;
    switch (tone) {
      case PillTone.glass:
        bg = const Color(0x9E08080C);
        fg = Colors.white;
        border = const Color(0x24FFFFFF);
        break;
      case PillTone.accent:
        bg = const Color(0x2E7C5CFC);
        fg = AppColors.accent300;
        border = const Color(0x667C5CFC);
        break;
      case PillTone.teal:
        bg = const Color(0x291DB8A0);
        fg = AppColors.teal300;
        border = const Color(0x661DB8A0);
        break;
      case PillTone.solid:
        bg = AppColors.accent;
        fg = Colors.white;
        border = Colors.transparent;
        break;
      case PillTone.neo:
        bg = Colors.transparent;
        fg = Colors.white;
        border = Colors.transparent;
        gradient = const LinearGradient(
          colors: [AppColors.newGradStart, AppColors.newGradEnd],
        );
        break;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: gradient == null ? bg : null,
            gradient: gradient,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: border, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                IconTheme(data: IconThemeData(color: fg, size: 12), child: icon!),
                const SizedBox(width: 4),
              ],
              Text(
                text,
                style: TextStyle(
                  color: fg,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
