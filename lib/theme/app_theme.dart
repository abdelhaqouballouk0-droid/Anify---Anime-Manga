import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// ThemeData Material 3 sombre + typographie Plus Jakarta Sans.
class AppTheme {
  AppTheme._();

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    final textTheme =
        GoogleFonts.plusJakartaSansTextTheme(base.textTheme).apply(
      bodyColor: AppColors.text1,
      displayColor: AppColors.text1,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.bg,
      canvasColor: AppColors.bg,
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: AppColors.accent,
        onPrimary: Colors.white,
        secondary: AppColors.teal,
        onSecondary: Color(0xFF04231D),
        surface: AppColors.surface,
        onSurface: AppColors.text1,
      ),
      textTheme: textTheme,
      splashFactory: InkRipple.splashFactory,
      highlightColor: Colors.white10,
      dividerColor: AppColors.hairline,
      sliderTheme: base.sliderTheme.copyWith(
        trackHeight: 4,
        activeTrackColor: AppColors.accent,
        inactiveTrackColor: const Color(0x3DFFFFFF),
        thumbColor: Colors.white,
        overlayColor: const Color(0x337C5CFC),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
      ),
    );
  }

  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    final textTheme =
        GoogleFonts.plusJakartaSansTextTheme(base.textTheme).apply(
      bodyColor: AppColors.lightText1,
      displayColor: AppColors.lightText1,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.lightBg,
      canvasColor: AppColors.lightBg,
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: AppColors.accent,
        onPrimary: Colors.white,
        secondary: AppColors.teal,
        onSecondary: Colors.white,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightText1,
      ),
      textTheme: textTheme,
      splashFactory: InkRipple.splashFactory,
      highlightColor: Colors.black12,
      dividerColor: const Color(0xFFE4E7EC),
      sliderTheme: base.sliderTheme.copyWith(
        trackHeight: 4,
        activeTrackColor: AppColors.accent,
        inactiveTrackColor: const Color(0xFFCBD5E1),
        thumbColor: AppColors.accent,
        overlayColor: const Color(0x337C5CFC),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
      ),
    );
  }

  // Helpers typographiques réutilisables.
  static TextStyle title(double size, {FontWeight w = FontWeight.w800}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: size,
        fontWeight: w,
        color: AppColors.text1,
        letterSpacing: -0.03 * size / 10,
        height: 1.05,
      );

  static TextStyle label(double size,
          {Color? color, FontWeight w = FontWeight.w600}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: size,
        fontWeight: w,
        color: color ?? AppColors.text2,
      );

  static TextStyle overline(Color color) => GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        color: color,
      );
}
