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
  int _userRating = 0;
  final _noteController = TextEditingController();
  bool _editingNote = false;
  String _userNote = '';
  LibStatus? _libraryStatus;

  Media get m => widget.media;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final related = [
      SampleData.demon,
      SampleData.solo,
      SampleData.frieren,
      SampleData.dungeon,
      SampleData.bluelock,
    ].where((r) => r.key != m.key).take(4).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _hero(context)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _genres(),
                const SizedBox(height: 12),
                _addToLibraryButton(),
                const SizedBox(height: 16),
                _synopsis(),
                const SizedBox(height: 22),
                _infoSection(),
                const SizedBox(height: 22),
                _myRatingSection(),
                const SizedBox(height: 22),
                _myNotesSection(),
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
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(
              child: PosterArt(paletteKey: m.key, radius: 0, showMotif: true)),
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.bg,
                        Color(0x8C0D0D0F),
                        Color(0x590D0D0F)
                      ],
                      stops: [0.02, 0.45, 1],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            child: Row(
              children: [
                _GlassBtn(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => Navigator.of(context).pop()),
                const Spacer(),
                _GlassBtn(icon: Icons.ios_share_rounded, onTap: () {}),
                const SizedBox(width: 9),
                _GlassBtn(
                  icon: saved
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: saved ? AppColors.accent300 : Colors.white,
                  onTap: () => setState(() => saved = !saved),
                ),
              ],
            ),
          ),
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
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0x99000000),
                          blurRadius: 34,
                          offset: Offset(0, 14))
                    ],
                  ),
                  child: PosterArt(paletteKey: m.key, radius: 14),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(m.title,
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.7,
                              color: Colors.white,
                              height: 1)),
                      const SizedBox(height: 5),
                      Text('${m.jpTitle} · ${m.year}',
                          style: const TextStyle(
                              fontSize: 13, color: AppColors.text2)),
                      const SizedBox(height: 8),
                      Row(children: [
                        RatingStars(rating: m.rating, size: 13),
                        const SizedBox(width: 7),
                        Text(m.rating.toString(),
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: AppColors.star)),
                        const SizedBox(width: 7),
                        Text(
                            '· ${m.count} ${m.isManga ? "ch." : "entries"}',
                            style: const TextStyle(
                                fontSize: 11.5, color: AppColors.text3)),
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
          overflow:
              expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 13.5, height: 1.6, color: AppColors.text2),
        ),
        const SizedBox(height: 7),
        GestureDetector(
          onTap: () => setState(() => expanded = !expanded),
          child: Text(expanded ? 'Show less' : 'Read more',
              style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent300)),
        ),
      ],
    );
  }

  Widget _infoSection() {
    final countLabel =
        '${m.count} ${m.isManga ? "chapters" : "entries"}';
    final typeLabel = m.isManga ? 'Manga' : 'Anime';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Show Info',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Colors.white)),
        const SizedBox(height: 12),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0x0AFFFFFF),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0x12FFFFFF)),
          ),
          child: Column(
            children: [
              _infoRow('Type', typeLabel),
              const Divider(color: Color(0x12FFFFFF), height: 18),
              _infoRow(m.isManga ? 'Chapters' : 'Entries',
                  m.count.toString()),
              const Divider(color: Color(0x12FFFFFF), height: 18),
              _infoRow('Year', m.year.toString()),
              const Divider(color: Color(0x12FFFFFF), height: 18),
              _infoRow('Rating', '${m.rating} / 10'),
              const Divider(color: Color(0x12FFFFFF), height: 18),
              _infoRow('Count', countLabel),
            ],
          ),
        ),
      ],
    );
  }

  Widget _myRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('My Rating',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Colors.white)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0x0AFFFFFF),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0x12FFFFFF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  for (int i = 1; i <= 5; i++)
                    GestureDetector(
                      onTap: () => setState(() {
                        _userRating = (_userRating == i * 2) ? 0 : i * 2;
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Icon(
                          i * 2 <= _userRating
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          size: 36,
                          color: i * 2 <= _userRating
                              ? AppColors.star
                              : AppColors.text3,
                        ),
                      ),
                    ),
                  const Spacer(),
                  if (_userRating > 0)
                    Text('$_userRating / 10',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.star)),
                ],
              ),
              if (_userRating == 0)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text('Tap stars to rate this title',
                      style:
                          TextStyle(fontSize: 12, color: AppColors.text3)),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _myNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('My Notes',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Colors.white)),
            if (_editingNote)
              GestureDetector(
                onTap: () => setState(() {
                  _userNote = _noteController.text.trim();
                  _editingNote = false;
                }),
                child: const Text('Save',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent300)),
              ),
          ],
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            if (!_editingNote) {
              setState(() {
                _noteController.text = _userNote;
                _editingNote = true;
              });
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0x0AFFFFFF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                  color: _editingNote
                      ? const Color(0x4A7C5CFC)
                      : const Color(0x12FFFFFF)),
            ),
            child: _editingNote
                ? TextField(
                    controller: _noteController,
                    autofocus: true,
                    maxLines: 4,
                    style: const TextStyle(
                        fontSize: 13.5,
                        color: Colors.white,
                        height: 1.5),
                    cursorColor: AppColors.accent,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      hintText: 'Write your thoughts...',
                      hintStyle: TextStyle(color: AppColors.text3),
                    ),
                  )
                : Text(
                    _userNote.isEmpty
                        ? 'Tap to add your personal notes...'
                        : _userNote,
                    style: TextStyle(
                        fontSize: 13.5,
                        height: 1.5,
                        color: _userNote.isEmpty
                            ? AppColors.text3
                            : AppColors.text2),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _addToLibraryButton() {
    final status = _libraryStatus;
    return GestureDetector(
      onTap: _showAddToLibrarySheet,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: status != null ? const Color(0x0AFFFFFF) : AppColors.accent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: status != null ? const Color(0x24FFFFFF) : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              status != null ? Icons.bookmark_rounded : Icons.bookmark_add_rounded,
              size: 18,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              status != null ? status.label : 'Add to Library',
              style: const TextStyle(
                  fontSize: 14.5, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            if (status != null) ...[
              const SizedBox(width: 6),
              const Icon(Icons.expand_more_rounded, size: 16, color: AppColors.text2),
            ],
          ],
        ),
      ),
    );
  }

  void _showAddToLibrarySheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0x24FFFFFF),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Add to Library',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
              const SizedBox(height: 14),
              for (final s in LibStatus.values) _statusOption(s),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusOption(LibStatus s) {
    final selected = _libraryStatus == s;
    return GestureDetector(
      onTap: () {
        setState(() => _libraryStatus = s);
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0x1A7C5CFC) : const Color(0x0AFFFFFF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? const Color(0x4A7C5CFC) : const Color(0x12FFFFFF),
          ),
        ),
        child: Row(
          children: [
            Text(s.label,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: selected ? AppColors.accent300 : Colors.white)),
            const Spacer(),
            if (selected)
              const Icon(Icons.check_rounded, size: 18, color: AppColors.accent300),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 13,
                color: AppColors.text3,
                fontWeight: FontWeight.w500)),
        Text(value,
            style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _related(List<Media> related) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Text('More Like This',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Colors.white)),
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
                    MaterialPageRoute(
                        builder: (_) => DetailsScreen(media: r))),
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
                            colors: [
                              Color(0xCC08080B),
                              Colors.transparent
                            ],
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
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.1)),
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
  const _GlassBtn(
      {required this.icon,
      this.color = Colors.white,
      required this.onTap});
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
      child: Text(text,
          style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: AppColors.text2)),
    );
  }
}
