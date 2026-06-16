import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/media.dart';
import '../theme/app_colors.dart';
import '../widgets/pill.dart';
import '../widgets/poster_art.dart';
import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String q = '';

  static const recents = [
    'Eternal Wanderer',
    'Infinite Ascent',
    'Dark fantasy',
    'Double Veil'
  ];
  static const suggestions = [
    'Action',
    'Fantasy',
    'Mystery',
    'Teens',
    'Dark fantasy',
    'Slice of life'
  ];

  void _open(Media m) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => DetailsScreen(media: m),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = q.trim();
    final results = query.isEmpty
        ? const <Media>[]
        : SampleData.searchPool
            .where((m) => m.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
    final matchedSuggestions = query.isEmpty
        ? suggestions
        : suggestions
            .where((s) => s.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 4, 14, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0x12FFFFFF),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0x667C5CFC)),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0x1F7C5CFC),
                              blurRadius: 0,
                              spreadRadius: 3)
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search_rounded,
                              size: 19, color: AppColors.text3),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              autofocus: true,
                              onChanged: (v) => setState(() => q = v),
                              cursorColor: AppColors.accent,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w500),
                              decoration: const InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: 'Search anime, manga, genres…',
                                hintStyle: TextStyle(
                                    color: AppColors.text3,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          if (q.isNotEmpty)
                            GestureDetector(
                              onTap: () => setState(() {
                                q = '';
                                _controller.clear();
                              }),
                              child: const Icon(Icons.close_rounded,
                                  size: 18, color: AppColors.text3),
                            )
                          else
                            const Icon(Icons.mic_rounded,
                                size: 19, color: AppColors.accent300),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Text('Cancel',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text2)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: query.isEmpty
                  ? _idleState(matchedSuggestions)
                  : _resultsState(results, matchedSuggestions),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultsState(List<Media> results, List<String> suggestionChips) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Text(
              '${results.length} result${results.length != 1 ? 's' : ''} for "$q"',
              style: const TextStyle(fontSize: 12.5, color: AppColors.text3)),
        ),
        if (suggestionChips.isNotEmpty) ...[
          _chipRow('Try these tags', suggestionChips),
          const SizedBox(height: 16),
        ],
        if (results.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: Text('No titles match "$q".',
                  style:
                      const TextStyle(fontSize: 13.5, color: AppColors.text3)),
            ),
          ),
        for (final r in results)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () => _open(r),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0x08FFFFFF),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0x0FFFFFFF)),
                ),
                child: Row(
                  children: [
                    SizedBox(
                        width: 52,
                        height: 70,
                        child: PosterArt(paletteKey: r.key, radius: 10)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r.title,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),
                          const SizedBox(height: 3),
                          Row(children: [
                            const Icon(Icons.star_rounded,
                                size: 11, color: AppColors.star),
                            const SizedBox(width: 2),
                            Text(r.rating.toString(),
                                style: const TextStyle(
                                    fontSize: 11, color: AppColors.star)),
                            const Text('  ·  ',
                                style: TextStyle(
                                    fontSize: 11, color: AppColors.text3)),
                            Text(r.isManga ? 'Manga' : 'Anime',
                                style: const TextStyle(
                                    fontSize: 11, color: AppColors.text3)),
                            const Text('  ·  ',
                                style: TextStyle(
                                    fontSize: 11, color: AppColors.text3)),
                            Text(r.genres.first,
                                style: const TextStyle(
                                    fontSize: 11, color: AppColors.text3)),
                          ]),
                        ],
                      ),
                    ),
                    Pill(r.isManga ? 'MANGA' : 'ANIME',
                        tone: r.isManga ? PillTone.teal : PillTone.accent),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _idleState(List<String> suggestionChips) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
      children: [
        _chipRow('Search suggestions', suggestionChips),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Recent',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text2)),
            GestureDetector(
              onTap: () {},
              child: const Text('Clear',
                  style: TextStyle(fontSize: 12, color: AppColors.text3)),
            ),
          ],
        ),
        const SizedBox(height: 11),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final r in recents)
              GestureDetector(
                onTap: () => setState(() {
                  q = r;
                  _controller.text = r;
                }),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0x0FFFFFFF),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: const Color(0x14FFFFFF)),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.schedule_rounded,
                        size: 13, color: AppColors.text3),
                    const SizedBox(width: 7),
                    Text(r,
                        style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text2)),
                  ]),
                ),
              ),
          ],
        ),
        const SizedBox(height: 26),
        const Row(children: [
          Icon(Icons.local_fire_department_rounded,
              size: 15, color: AppColors.accent300),
          SizedBox(width: 6),
          Text('Trending Now',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text2)),
        ]),
        const SizedBox(height: 13),
        for (var i = 0; i < SampleData.trending.length; i++)
          _trendRow(i + 1, SampleData.trending[i]),
      ],
    );
  }

  Widget _chipRow(String title, List<String> chips) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.text2)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final chip in chips)
              GestureDetector(
                onTap: () => setState(() {
                  q = chip;
                  _controller.text = chip;
                }),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                  decoration: BoxDecoration(
                    color: const Color(0x0FFFFFFF),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: const Color(0x14FFFFFF)),
                  ),
                  child: Text(chip,
                      style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.text2,
                          fontWeight: FontWeight.w600)),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _trendRow(int rank, Media m) {
    return GestureDetector(
      onTap: () => _open(m),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: 18,
              child: Text('$rank',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color:
                          rank <= 3 ? AppColors.accent300 : AppColors.text3)),
            ),
            const SizedBox(width: 13),
            SizedBox(
                width: 42,
                height: 56,
                child: PosterArt(paletteKey: m.key, radius: 9)),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(m.title,
                      style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                  const SizedBox(height: 2),
                  Text(m.genres.take(2).join(' · '),
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.text3)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                size: 16, color: AppColors.text3),
          ],
        ),
      ),
    );
  }
}
