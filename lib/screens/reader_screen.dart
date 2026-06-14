import 'dart:ui';
import 'package:flutter/material.dart';

import '../models/media.dart';
import '../theme/app_colors.dart';
import '../utils/poster_palette.dart';
import '../widgets/poster_motif_painter.dart';

class ReaderScreen extends StatefulWidget {
  final Media media;
  const ReaderScreen({super.key, required this.media});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  final _scroll = ScrollController();
  bool chrome = true;
  int page = 1;
  late int chapter;
  bool showChapters = false;
  double _lastOffset = 0;

  static const totalPages = 8;
  static const panelHeights = [320.0, 460.0, 300.0, 540.0, 360.0, 480.0, 320.0, 500.0];

  @override
  void initState() {
    super.initState();
    chapter = widget.media.count;
    _scroll.addListener(_onScroll);
  }

  void _onScroll() {
    final y = _scroll.offset;
    final max = _scroll.position.maxScrollExtent;
    if (max > 0) {
      setState(() => page = (1 + (y / max * (totalPages - 1)).round()).clamp(1, totalPages));
    }
    if (y > _lastOffset + 6 && y > 60) {
      if (chrome) setState(() => chrome = false);
    } else if (y < _lastOffset - 6) {
      if (!chrome) setState(() => chrome = true);
    }
    _lastOffset = y;
  }

  void _goChapter(int c) {
    setState(() {
      chapter = c.clamp(1, 9999);
      showChapters = false;
    });
    _scroll.jumpTo(0);
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // strip
          GestureDetector(
            onTap: () => setState(() => chrome = !chrome),
            child: ListView(
              controller: _scroll,
              padding: EdgeInsets.zero,
              children: [
                SizedBox(height: topPad + 52),
                for (var i = 0; i < panelHeights.length; i++)
                  _MangaPanel(
                    paletteKey: widget.media.key,
                    height: panelHeights[i],
                    label: i == 0 ? 'Cover' : null,
                    light: i % 3 == 1,
                  ),
                _endOfChapter(),
              ],
            ),
          ),

          // top overlay
          AnimatedSlide(
            duration: const Duration(milliseconds: 280),
            offset: chrome ? Offset.zero : const Offset(0, -1.2),
            child: Container(
              padding: EdgeInsets.fromLTRB(14, topPad + 10, 14, 14),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xD1000000), Colors.transparent],
                ),
              ),
              child: Row(
                children: [
                  _glass(Icons.arrow_back_rounded, () => Navigator.of(context).pop()),
                  const SizedBox(width: 10),
                  Expanded(child: _chapterButton()),
                  const SizedBox(width: 10),
                  _glass(Icons.settings_rounded, () {}),
                ],
              ),
            ),
          ),

          if (showChapters && chrome) _chapterDropdown(topPad),

          // bottom overlay
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 280),
              offset: chrome ? Offset.zero : const Offset(0, 1.2),
              child: Container(
                padding: const EdgeInsets.fromLTRB(18, 40, 18, 22),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xCC000000), Colors.transparent],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _navArrow(Icons.chevron_left_rounded, () => _goChapter(chapter - 1)),
                    _pageCounter(),
                    _navArrow(Icons.chevron_right_rounded, () => _goChapter(chapter + 1)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _endOfChapter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 34, 24, 80),
      child: Column(
        children: [
          Text('END OF CHAPTER $chapter',
              style: const TextStyle(fontSize: 12, letterSpacing: 1.2, color: AppColors.text3)),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => _goChapter(chapter + 1),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
              decoration: BoxDecoration(
                color: AppColors.teal,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: AppColors.teal.withOpacity(0.35), blurRadius: 24, offset: const Offset(0, 8))],
              ),
              child: const Row(mainAxisSize: MainAxisSize.min, children: [
                Text('Next Chapter',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF04231D))),
                SizedBox(width: 8),
                Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xFF04231D)),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chapterButton() {
    return GestureDetector(
      onTap: () => setState(() => showChapters = !showChapters),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: const Color(0xB314141A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0x1AFFFFFF)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.media.title.toUpperCase(),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.6, color: AppColors.teal300)),
                      Text('Chapter $chapter',
                          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: Colors.white)),
                    ],
                  ),
                ),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: showChapters ? 0.5 : 0,
                  child: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: AppColors.text2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chapterDropdown(double topPad) {
    final chapters = List.generate(6, (i) => chapter + 2 - i);
    return Positioned(
      top: topPad + 62,
      left: 58,
      right: 58,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xF712121A),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0x1AFFFFFF)),
              boxShadow: const [BoxShadow(color: Color(0x99000000), blurRadius: 40, offset: Offset(0, 18))],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: chapters.map((c) {
                final on = c == chapter;
                return GestureDetector(
                  onTap: () => _goChapter(c),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                    decoration: BoxDecoration(
                      color: on ? const Color(0x1F1DB8A0) : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Chapter $c',
                            style: TextStyle(
                                fontSize: 13.5, fontWeight: on ? FontWeight.w800 : FontWeight.w600, color: on ? AppColors.teal300 : Colors.white)),
                        if (on) const Icon(Icons.check_rounded, size: 16, color: AppColors.teal300),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _pageCounter() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xCC14141A),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0x1FFFFFFF)),
          ),
          child: Text.rich(TextSpan(children: [
            TextSpan(text: 'Page $page', style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: Colors.white)),
            const TextSpan(text: ' / $totalPages', style: TextStyle(fontSize: 12.5, color: Color(0x80FFFFFF))),
          ])),
        ),
      ),
    );
  }

  Widget _glass(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xB314141A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0x1AFFFFFF)),
            ),
            child: Icon(icon, size: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _navArrow(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xCC14141A),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0x1FFFFFFF)),
        ),
        child: Icon(icon, size: 22, color: Colors.white),
      ),
    );
  }
}

/// Une "page" manga monochrome (placeholder encre) bâtie sur le motif de la palette.
class _MangaPanel extends StatelessWidget {
  final String paletteKey;
  final double height;
  final String? label;
  final bool light;
  const _MangaPanel({required this.paletteKey, required this.height, this.label, this.light = false});

  @override
  Widget build(BuildContext context) {
    final p = paletteFor(paletteKey);
    final paper = light ? const Color(0xFFE8E6DF) : const Color(0xFF15151A);
    final ink = light ? const Color(0xFF15151A) : const Color(0xFFE8E6DF);
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: paper,
        border: const Border(bottom: BorderSide(color: Colors.black, width: 2)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: light ? 0.5 : 0.7,
            child: ColorFiltered(
              colorFilter: const ColorFilter.matrix(<double>[
                0.33, 0.33, 0.33, 0, 0,
                0.33, 0.33, 0.33, 0, 0,
                0.33, 0.33, 0.33, 0, 0,
                0, 0, 0, 1, 0,
              ]),
              child: CustomPaint(
                painter: PosterMotifPainter(p.motif, ink),
                child: const SizedBox.expand(),
              ),
            ),
          ),
          // radial light
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: light ? const Alignment(-0.4, -0.8) : const Alignment(0.4, 0.8),
                radius: 1.1,
                colors: light
                    ? [Colors.white.withOpacity(0.4), Colors.transparent]
                    : [Colors.black.withOpacity(0.5), Colors.transparent],
                stops: const [0, 0.6],
              ),
            ),
          ),
          if (label != null)
            Positioned(
              left: 16,
              bottom: 14,
              child: Text(label!.toUpperCase(),
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.4, color: ink.withOpacity(0.45))),
            ),
        ],
      ),
    );
  }
}
