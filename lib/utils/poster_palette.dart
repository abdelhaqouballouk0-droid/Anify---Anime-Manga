import 'package:flutter/material.dart';

enum PosterMotif { rings, blade, shards, leaf, flame, saw, wave, slash, stars, petal }

/// Palette duotone "key-art" pour un titre (équivalent du `ART` map du mockup).
class PosterPalette {
  final Color a; // haut-gauche
  final Color b; // bas-droite
  final Color glow; // lueur accent
  final PosterMotif motif;

  const PosterPalette(this.a, this.b, this.glow, this.motif);
}

const Map<String, PosterPalette> kPosterPalettes = {
  'demon': PosterPalette(Color(0xFF2B0F3A), Color(0xFFD6275F), Color(0xFFFF7A59), PosterMotif.blade),
  'jjk': PosterPalette(Color(0xFF0B1230), Color(0xFF5B2BD6), Color(0xFF37E0FF), PosterMotif.rings),
  'solo': PosterPalette(Color(0xFF06121F), Color(0xFF0E7BD6), Color(0xFF67F5FF), PosterMotif.shards),
  'frieren': PosterPalette(Color(0xFF10261F), Color(0xFF1F8A6D), Color(0xFFFFE08A), PosterMotif.leaf),
  'dungeon': PosterPalette(Color(0xFF2A1606), Color(0xFFC8762A), Color(0xFFFFD166), PosterMotif.flame),
  'csm': PosterPalette(Color(0xFF1A0606), Color(0xFFD23B2A), Color(0xFFFF9E3D), PosterMotif.saw),
  'onepiece': PosterPalette(Color(0xFF06182A), Color(0xFF1F78C8), Color(0xFFFFD34D), PosterMotif.wave),
  'berserk': PosterPalette(Color(0xFF0A0A0C), Color(0xFF5A1212), Color(0xFFC4453A), PosterMotif.slash),
  'spy': PosterPalette(Color(0xFF2A0F24), Color(0xFFC2407E), Color(0xFFFFCE5C), PosterMotif.stars),
  'apoth': PosterPalette(Color(0xFF241226), Color(0xFF8A4BC9), Color(0xFF7FF0C4), PosterMotif.petal),
  'bluelock': PosterPalette(Color(0xFF06142A), Color(0xFF2155D6), Color(0xFF46F0FF), PosterMotif.rings),
  'vinland': PosterPalette(Color(0xFF0C1A22), Color(0xFF2F6E8A), Color(0xFFCFE9FF), PosterMotif.wave),
};

PosterPalette paletteFor(String key) =>
    kPosterPalettes[key] ?? kPosterPalettes['jjk']!;

Color accentOf(String key) => paletteFor(key).glow;
