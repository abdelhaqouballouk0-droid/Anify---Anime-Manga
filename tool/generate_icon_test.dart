// Run with: flutter test tool/generate_icon_test.dart
// Generates assets/icon.png from the same A-letter drawing used in AppLogo.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('generate app icon PNG', () async {
    const double sz = 1024;
    const double w = sz, h = sz, cx = sz / 2;

    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder, ui.Rect.fromLTWH(0, 0, w, h));

    // Black rounded background
    canvas.drawRRect(
      ui.RRect.fromRectAndRadius(
        ui.Rect.fromLTWH(0, 0, w, h),
        ui.Radius.circular(w * 0.225),
      ),
      ui.Paint()
        ..color = const ui.Color(0xFF000000)
        ..isAntiAlias = true,
    );

    // White A letter — same geometry as _AppLogoPainter
    final fg = ui.Paint()
      ..color = const ui.Color(0xFFFFFFFF)
      ..style = ui.PaintingStyle.fill
      ..isAntiAlias = true;

    const apexY   = h * 0.11;
    const bottomY = h * 0.88;
    const lOuterX = w * 0.05;
    const lInnerX = w * 0.28;
    const cbTopY  = h * 0.52;
    const cbBotY  = h * 0.66;

    double lDiag(double y) =>
        cx + (y - apexY) / (bottomY - apexY) * (lInnerX - cx);

    // Left stroke
    canvas.drawPath(
      ui.Path()
        ..moveTo(cx, apexY)
        ..lineTo(lOuterX, bottomY)
        ..lineTo(lInnerX, bottomY)
        ..close(),
      fg,
    );

    // Right stroke (mirror)
    canvas.drawPath(
      ui.Path()
        ..moveTo(cx, apexY)
        ..lineTo(w - lOuterX, bottomY)
        ..lineTo(w - lInnerX, bottomY)
        ..close(),
      fg,
    );

    // Crossbar (trapezoid following inner diagonals)
    canvas.drawPath(
      ui.Path()
        ..moveTo(lDiag(cbTopY), cbTopY)
        ..lineTo(w - lDiag(cbTopY), cbTopY)
        ..lineTo(w - lDiag(cbBotY), cbBotY)
        ..lineTo(lDiag(cbBotY), cbBotY)
        ..close(),
      fg,
    );

    final picture = recorder.endRecording();
    final image   = await picture.toImage(sz.toInt(), sz.toInt());
    final bytes   = await image.toByteData(format: ui.ImageByteFormat.png);

    final file = File('assets/icon.png');
    await file.writeAsBytes(bytes!.buffer.asUint8List());
    // ignore: avoid_print
    print('✓ Icon written → ${file.absolute.path}');
  });
}
