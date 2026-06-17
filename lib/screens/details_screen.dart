import 'dart:ui';
import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/media.dart';
import '../theme/app_colors.dart';
import '../widgets/poster_art.dart';
import '../widgets/rating_stars.dart';

class DetailsScreen extends StatefulWidget {
  final Media media;
  const DetailsScreen({super.key, required this.media});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool expanded = false;
  bool saved = false;

  Media get m => widget.media;

  @override
  Widget build(BuildContext context) {
    final related = [SampleData.demon, SampleData.solo, SampleData.frieren, SampleData.dungeon, SampleData.bluelock]
        .where((r) => r.key != m.key)
        .take(5)
        .toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _hero(context)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _genres(),
                const SizedBox(height: 16),
                _synopsis(),
                const SizedBox(height: 22),
                _infoSection(),
                const SizedBox(height: 26),
              ]),
            ),
          ),
          SliverToBoxAdapter(child: _related(related)),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _hero(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Stack(
        children: [
          Positioned.fill(child: PosterArt(paletteKey: m.key, radius: 0, showMotif: true)),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [AppColors.bg, Color(0x8C0D0D0F), Color(0x590D0D0F)],
                    stops: [0.02, 0.45, 1],
                  ),
                ),
              ),
            ),
          ),
          // top controls
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            child: Row(
              children: [
                _GlassBtn(icon: Icons.arrow_back_rounded, onTap: () => Navigator.of(context).pop()),
                const Spacer(),
                _GlassBtn(icon: Icons.ios_share_rounded, onTap: () {}),
                const SizedBox(width: 9),
                _GlassBtn(
                  icon: saved ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: saved ? AppColors.accent300 : Colors.white,
                  onTap: () => setState(() => saved = !saved),
                ),
              ],
            ),
          ),
          // poster + title
          Positioned(
            left: 16,
            right: 16,
            bottom: 14,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 92,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0x24FFFFFF)),
                    boxShadow: const [BoxShadow(color: Color(0x99000000), blurRadius: 34, offset: Offset(0, 14))],
                  ),
                  child: PosterArt(paletteKey: m.key, radius: 14),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(m.title,
                          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800, letterSpacing: -0.7, color: Colors.white, height: 1)),
                      const SizedBox(height: 5),
                      Text('${m.jpTitle} · ${m.year}',
                          style: const TextStyle(fontSize: 13, color: AppColors.text2)),
                      const SizedBox(height: 8),
                      Row(children: [
                        RatingStars(rating: m.rating, size: 13),
                        const SizedBox(width: 7),
                        Text(m.rating.toString(),
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.star)),
                        const SizedBox(width: 7),
                        Text('· ${m.count} ${m.isManga ? 'ch.' : 'eps'}', style: const TextStyle(fontSize: 11.5, color: AppColors.text3)),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _genres() {
    return Wrap(
      spacing: 7,
      runSpacing: 7,
      children: [
        for (final g in [...m.genres, m.subtitle]) _Chip(g),
      ],
    );
  }


  Widget _synopsis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          m.synopsis,
          maxLines: expanded ? null : 3,
          overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 13.5, height: 1.6, color: AppColors.text2),
        ),
        const SizedBox(height: 7),
        GestureDetector(
          onTap: () => setState(() => expanded = !expanded),
          child: Text(expanded ? 'Show less' : 'Read more',
              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.accent300)),
        ),
      ],
    );
  }

  Widget _infoSection() {
    final countLabel = m.isManga ? '${m.count} chapters' : '${m.count} episodes';
    final typeLabel = m.isManga ? 'Manga' : 'Anime';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Show Info',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.white)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0x0AFFFFFF),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0x12FFFFFF)),
          ),
          child: Column(
            children: [
              _infoRow('Type', typeLabel),
              const Divider(color: Color(0x12FFFFFF), height: 18),
              _infoRow(m.isManga ? 'Chapters' : 'Episodes', m.count.toString()),
              const Divider(color: Color(0x12FFFFFF), height: 18),
              _infoRow('Year', m.year.toString()),
              const Divider(color: Color(0x12FFFFFF), height: 18),
              _infoRow('Rating', '${m.rating} / 10'),
              const Divider(color: Color(0x12FFFFFF), height: 18),
              _infoRow('Duration', m.isManga ? countLabel : m.duration),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 13, color: AppColors.text3, fontWeight: FontWeight.w500)),
        Text(value,
            style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _related(List<Media> related) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Text('More Like This', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.white)),
        ),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: related.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) {
              final r = related[i];
              return GestureDetector(
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => DetailsScreen(media: r))),
                child: SizedBox(
                  width: 118,
                  child: PosterArt(
                    paletteKey: r.key,
                    radius: 14,
                    children: [
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Color(0xCC08080B), Colors.transparent],
                            stops: [0, 0.45],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 9,
                        right: 9,
                        bottom: 8,
                        child: Text(r.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white, height: 1.1)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// --------------------------------------------------------------------------

class _GlassBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _GlassBtn({required this.icon, this.color = Colors.white, required this.onTap});
  @override
  Widget build(BuildContext context) {
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
              color: const Color(0x800D0D0F),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0x1FFFFFFF)),
            ),
            child: Icon(icon, size: 19, color: color),
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  const _Chip(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0x0FFFFFFF),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0x14FFFFFF)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.text2)),
    );
  }
}


