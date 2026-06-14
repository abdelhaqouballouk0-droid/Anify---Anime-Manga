import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/media.dart';
import '../theme/app_colors.dart';
import '../widgets/poster_art.dart';
import '../widgets/progress_bar.dart';
import 'details_screen.dart';
import 'search_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  LibStatus tab = LibStatus.watching;

  Color _statusColor(LibStatus s) => switch (s) {
        LibStatus.watching => AppColors.statusWatching,
        LibStatus.completed => AppColors.statusCompleted,
        LibStatus.planning => AppColors.statusPlanning,
        LibStatus.dropped => AppColors.statusDropped,
        LibStatus.favorites => AppColors.statusFavorites,
      };

  void _open(Media m) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => DetailsScreen(media: m),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final entries = SampleData.library.where((e) => e.status == tab).toList();
    final counts = {for (final s in LibStatus.values) s: SampleData.library.where((e) => e.status == s).length};

    return ListView(
      padding: const EdgeInsets.only(top: 4, bottom: 100),
      children: [
        // header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('My Library',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: -0.7, color: Colors.white)),
                  const SizedBox(height: 2),
                  Text('${SampleData.library.length} titles tracked',
                      style: const TextStyle(fontSize: 12.5, color: AppColors.text3)),
                ],
              ),
              const Spacer(),
              _iconBtn(Icons.search_rounded, () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SearchScreen()));
              }),
              const SizedBox(width: 9),
              _iconBtn(Icons.tune_rounded, () {}),
            ],
          ),
        ),
        // tabs
        SizedBox(
          height: 38,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              for (final s in LibStatus.values) ...[
                _tabChip(s, counts[s] ?? 0),
                const SizedBox(width: 8),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),
        // sort row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(TextSpan(children: [
                TextSpan(text: '${entries.length}', style: const TextStyle(color: AppColors.text2, fontWeight: FontWeight.w700)),
                TextSpan(text: ' in ${tab.label}', style: const TextStyle(color: AppColors.text3)),
              ], style: const TextStyle(fontSize: 12.5))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0x0DFFFFFF),
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: const Color(0x14FFFFFF)),
                ),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.swap_vert_rounded, size: 15, color: AppColors.text2),
                  SizedBox(width: 6),
                  Text('Recent', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.text2)),
                ]),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        // grid
        if (entries.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 60),
            child: Column(children: [
              Icon(Icons.bookmark_border_rounded, size: 40, color: Color(0x66FFFFFF)),
              SizedBox(height: 12),
              Text('Nothing here yet', style: TextStyle(fontSize: 14, color: AppColors.text3, fontWeight: FontWeight.w600)),
            ]),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: entries.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 11,
                mainAxisSpacing: 11,
                childAspectRatio: 104 / 176,
              ),
              itemBuilder: (_, i) => _LibCard(
                entry: entries[i],
                statusColor: _statusColor(entries[i].status),
                onTap: () => _open(entries[i].media),
              ),
            ),
          ),
      ],
    );
  }

  Widget _tabChip(LibStatus s, int count) {
    final on = s == tab;
    return GestureDetector(
      onTap: () => setState(() => tab = s),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: on ? Colors.white : const Color(0x0FFFFFFF),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: on ? Colors.white : const Color(0x14FFFFFF)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(s.label,
              style: TextStyle(fontSize: 13, fontWeight: on ? FontWeight.w800 : FontWeight.w600, color: on ? AppColors.bg : AppColors.text2)),
          const SizedBox(width: 7),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: on ? const Color(0x1A0D0D0F) : const Color(0x14FFFFFF),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text('$count',
                style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: on ? AppColors.bg : AppColors.text3)),
          ),
        ]),
      ),
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap) {
    return Material(
      color: const Color(0x0FFFFFFF),
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: const Color(0x14FFFFFF)),
          ),
          child: Icon(icon, size: 19, color: Colors.white),
        ),
      ),
    );
  }
}

class _LibCard extends StatelessWidget {
  final LibraryEntry entry;
  final Color statusColor;
  final VoidCallback onTap;
  const _LibCard({required this.entry, required this.statusColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final m = entry.media;
    return GestureDetector(
      onTap: onTap,
      child: PosterArt(
        paletteKey: m.key,
        radius: 14,
        children: [
          // type + status dot
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.fromLTRB(6, 3, 8, 3),
              decoration: BoxDecoration(
                color: const Color(0xA808080C),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0x1FFFFFFF)),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: statusColor, blurRadius: 6)],
                  ),
                ),
                const SizedBox(width: 5),
                Text(m.isManga ? 'Manga' : 'Anime',
                    style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: Colors.white)),
              ]),
            ),
          ),
          // score
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xA808080C),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0x1FFFFFFF)),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.star_rounded, size: 10, color: AppColors.star),
                const SizedBox(width: 3),
                Text(m.rating.toString(),
                    style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: AppColors.star)),
              ]),
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xD908080B), Colors.transparent],
                stops: [0, 0.48],
              ),
            ),
          ),
          Positioned(
            left: 9,
            right: 9,
            bottom: entry.inProgress ? 14 : 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(m.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white, height: 1.1)),
                if (entry.current != null && entry.total != null) ...[
                  const SizedBox(height: 3),
                  Text(m.isManga ? 'Ch ${entry.current}/${entry.total}' : 'EP ${entry.current}/${entry.total}',
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.text2)),
                ],
              ],
            ),
          ),
          if (entry.inProgress)
            Positioned(
              left: 8,
              right: 8,
              bottom: 8,
              child: NifyProgressBar(
                value: entry.current! / entry.total!,
                color: m.isManga ? AppColors.teal : AppColors.accent,
              ),
            ),
        ],
      ),
    );
  }
}
