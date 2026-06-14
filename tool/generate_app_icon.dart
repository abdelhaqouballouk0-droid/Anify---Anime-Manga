import 'dart:io';

import 'package:image/image.dart';

void main() {
  final size = 1024;
  final image = Image(width: size, height: size);

  for (var y = 0; y < size; y++) {
    final t = y / (size - 1);
    final r = (60 + (232 - 60) * t).round();
    final g = (54 + (129 - 54) * t).round();
    final b = (255 + (155 - 255) * t).round();
    for (var x = 0; x < size; x++) {
      image.setPixelRgba(x, y, r, g, b, 255);
    }
  }

  final radius = (size * 0.16).round();
  fillRect(image,
      x1: (size * 0.08).round(),
      y1: (size * 0.08).round(),
      x2: (size * 0.92).round(),
      y2: (size * 0.92).round(),
      color: ColorRgba8(255, 255, 255, 255),
      radius: radius,
      alphaBlend: false);

  const stroke = 120;
  final x0 = (size * 0.28).round();
  final x2 = (size * 0.56).round();
  final x3 = (size * 0.72).round();
  final y0 = (size * 0.24).round();
  final y1 = (size * 0.76).round();

  final logoColor = ColorRgb8(47, 53, 66);
  drawLine(image,
      x1: x0, y1: y0, x2: x0, y2: y1, color: logoColor, thickness: stroke);
  drawLine(image,
      x1: x0, y1: y1, x2: x2, y2: y1, color: logoColor, thickness: stroke);
  drawLine(image,
      x1: x2, y1: y1, x2: x2, y2: y0, color: logoColor, thickness: stroke);
  drawLine(image,
      x1: x2, y1: y0, x2: x3, y2: y1, color: logoColor, thickness: stroke);
  drawLine(image,
      x1: x3, y1: y1, x2: x3, y2: y0, color: logoColor, thickness: stroke);

  final outDir = Directory('assets');
  if (!outDir.existsSync()) outDir.createSync(recursive: true);

  final file = File('assets/icon.png');
  file.writeAsBytesSync(encodePng(image));
  print('Generated assets/icon.png');
}
