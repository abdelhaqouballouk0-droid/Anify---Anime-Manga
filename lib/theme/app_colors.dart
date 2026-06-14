import 'package:flutter/material.dart';

/// Tokens couleur de Nify — Arashi.
/// Pendant pour le `:root { --* }` du mockup HTML.
class AppColors {
  AppColors._();

  static const bg = Color(0xFF0D0D0F);
  static const surface = Color(0xFF16161A);
  static const surface2 = Color(0xFF1C1C22);

  static const text1 = Color(0xFFFFFFFF);
  static const text2 = Color(0xBDFFFFFF); // white 74%
  static const text3 = Color(0x75FFFFFF); // white 46%

  /// Accent principal (indigo électrique) — CTA, états actifs, barres de progression.
  static const accent = Color(0xFF7C5CFC);
  static const accent300 = Color(0xFFB6A3FF);

  /// Accent secondaire (teal doux) — éléments manga.
  static const teal = Color(0xFF1DB8A0);
  static const teal300 = Color(0xFF6FE6CF);

  static const star = Color(0xFFFFC54D);
  static const newGradStart = Color(0xFFFF5E7A);
  static const newGradEnd = Color(0xFFFF9E3D);

  /// Bordure 1px translucide des cartes.
  static const hairline = Color(0x12FFFFFF); // white ~7%
  static const hairlineStrong = Color(0x24FFFFFF);

  // Statuts de bibliothèque.
  static const statusWatching = accent;
  static const statusCompleted = teal;
  static const statusPlanning = Color(0xFF5B8DEF);
  static const statusDropped = Color(0xFF6B6B76);
  static const statusFavorites = Color(0xFFFF5E7A);

  static const lightBg = Color(0xFFF7F8FC);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurface2 = Color(0xFFF1F3F8);
  static const lightText1 = Color(0xFF101828);
  static const lightText2 = Color(0xFF475467);
  static const lightText3 = Color(0xFF667085);
}
