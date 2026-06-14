import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

import '../models/media.dart';
import '../theme/app_colors.dart';
import '../widgets/poster_art.dart';

class PlayerScreen extends StatefulWidget {
  final Media media;
  final Episode episode;
  const PlayerScreen({super.key, required this.media, required this.episode});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  static const total = 1432; // 23:52
  double time = 640;
  bool playing = true;
  bool chrome = true;
  double speed = 1;
  String quality = '1080p';
  bool showSpeed = false;
  bool showQuality = false;

  Timer? _ticker;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _startTicker();
    _scheduleHide();
  }

  void _startTicker() {
    _ticker?.cancel();
    if (!playing) return;
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => time = (time + speed).clamp(0, total.toDouble()));
    });
  }

  void _scheduleHide() {
    _hideTimer?.cancel();
    if (!chrome || !playing) return;
    _hideTimer = Timer(const Duration(milliseconds: 3800), () {
      if (mounted) setState(() { chrome = false; showSpeed = false; showQuality = false; });
    });
  }

  void _wake() {
    setState(() => chrome = !chrome);
    _scheduleHide();
  }

  void _togglePlay() {
    setState(() => playing = !playing);
    _startTicker();
    _scheduleHide();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _hideTimer?.cancel();
    super.dispose();
  }

  String _fmt(num t) {
    final m = (t ~/ 60).toString();
    final s = (t % 60).floor().toString().padLeft(2, '0');
    return '$m:$s';
  }

  bool get inIntro => time < 90;

  @override
  Widget build(BuildContext context) {
    final m = widget.media;
    final ep = widget.episode;
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _wake,
        child: Stack(
          children: [
            // "video"
            Positioned.fill(child: PosterArt(paletteKey: m.key, radius: 0)),
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 250),
                  opacity: chrome ? 1 : 0,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x9E000000), Colors.transparent, Colors.transparent, Color(0xC7000000)],
                        stops: [0, 0.24, 0.64, 1],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            if (chrome) _topBar(context, m, ep),
            if (chrome) _centerControls(),
            _floatingButtons(context),
            if (showSpeed && chrome) _speedMenu(),
            if (showQuality && chrome) _qualityMenu(),
            if (chrome) _bottomBar(ep),
          ],
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context, Media m, Episode ep) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 6,
      left: 16,
      right: 16,
      child: Row(
        children: [
          _glass(Icons.keyboard_arrow_down_rounded, () => Navigator.of(context).pop(), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(m.title,
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800, color: Colors.white)),
                Text('Episode ${ep.no} · ${ep.title}',
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11.5, color: Color(0xA6FFFFFF))),
              ],
            ),
          ),
          _glass(Icons.cast_rounded, () {}),
          const SizedBox(width: 9),
          _glass(Icons.settings_rounded, () {}),
        ],
      ),
    );
  }

  Widget _centerControls() {
    return Positioned.fill(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => setState(() => time = (time - 10).clamp(0, total.toDouble())),
            icon: const Icon(Icons.replay_10_rounded, size: 34, color: Colors.white),
          ),
          const SizedBox(width: 28),
          GestureDetector(
            onTap: _togglePlay,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0x29FFFFFF),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0x52FFFFFF), width: 1.5),
              ),
              child: Icon(playing ? Icons.pause_rounded : Icons.play_arrow_rounded, size: 32, color: Colors.white),
            ),
          ),
          const SizedBox(width: 28),
          IconButton(
            onPressed: () => setState(() => time = (time + 10).clamp(0, total.toDouble())),
            icon: const Icon(Icons.forward_10_rounded, size: 34, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _floatingButtons(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      right: 16,
      bottom: chrome ? 132 : 26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (inIntro)
            _floatBtn('Skip Intro', Icons.chevron_right_rounded, false, () => setState(() => time = 92)),
          const SizedBox(height: 10),
          _floatBtn('Next Episode', Icons.skip_next_rounded, true, () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => PlayerScreen(
                media: widget.media,
                episode: Episode(no: widget.episode.no + 1, title: 'Next Episode', duration: '24:00'),
              ),
            ));
          }),
        ],
      ),
    );
  }

  Widget _bottomBar(Episode ep) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 20,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 42,
                child: Text(_fmt(time),
                    style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                  ),
                  child: Slider(
                    value: time,
                    min: 0,
                    max: total.toDouble(),
                    onChanged: (v) => setState(() => time = v),
                  ),
                ),
              ),
              SizedBox(
                width: 42,
                child: Text(_fmt(total),
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Color(0x99FFFFFF))),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ctrlChip(Icons.speed_rounded, '${speed}x', () => setState(() { showSpeed = !showSpeed; showQuality = false; })),
              _ctrlChip(Icons.high_quality_rounded, quality, () => setState(() { showQuality = !showQuality; showSpeed = false; })),
              _ctrlChip(Icons.playlist_play_rounded, 'Episodes', () {}),
              _ctrlChip(Icons.fullscreen_rounded, null, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _speedMenu() {
    return Positioned(
      right: 16,
      bottom: 92,
      child: _menu([0.5, 1, 1.25, 1.5, 2].map((s) {
        return _menuItem('${s}x', speed == s, () => setState(() { speed = s.toDouble(); showSpeed = false; _startTicker(); }));
      }).toList()),
    );
  }

  Widget _qualityMenu() {
    return Positioned(
      right: 92,
      bottom: 92,
      child: _menu(['1080p', '720p', '480p', 'Auto'].map((q) {
        return _menuItem(q, quality == q, () => setState(() { quality = q; showQuality = false; }));
      }).toList()),
    );
  }

  // ---- petits helpers UI ----

  Widget _glass(IconData icon, VoidCallback onTap, {double size = 19}) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0x52000000),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0x24FFFFFF)),
            ),
            child: Icon(icon, size: size, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _floatBtn(String label, IconData icon, bool filled, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: filled ? const Color(0xEBFFFFFF) : const Color(0x80000000),
              borderRadius: BorderRadius.circular(12),
              border: filled ? null : Border.all(color: const Color(0x4DFFFFFF)),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(icon, size: 16, color: filled ? AppColors.bg : Colors.white),
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: filled ? AppColors.bg : Colors.white)),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _ctrlChip(IconData icon, String? label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: label == null ? 10 : 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0x1AFFFFFF),
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: const Color(0x1FFFFFFF)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 17, color: Colors.white),
          if (label != null) ...[
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5, color: Colors.white)),
          ],
        ]),
      ),
    );
  }

  Widget _menu(List<Widget> children) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xF514141A),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0x1AFFFFFF)),
            boxShadow: const [BoxShadow(color: Color(0x99000000), blurRadius: 34, offset: Offset(0, 14))],
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: children),
        ),
      ),
    );
  }

  Widget _menuItem(String label, bool on, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(9)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 13, fontWeight: on ? FontWeight.w800 : FontWeight.w600, color: on ? AppColors.accent300 : Colors.white)),
            if (on) const Icon(Icons.check_rounded, size: 14, color: AppColors.accent300),
          ],
        ),
      ),
    );
  }
}
