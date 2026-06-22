import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/media.dart';
import '../theme/app_colors.dart';
import '../widgets/poster_art.dart';
import 'chatbot_screen.dart';
import 'quiz_screen.dart';

class SettingsScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  const SettingsScreen(
      {super.key, required this.themeMode, required this.onThemeChanged});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool alerts = true;

  @override
  Widget build(BuildContext context) {
    final totalTitles = SampleData.library.length;
    final animeCount = SampleData.library.where((e) => !e.media.isManga).length;
    final mangaCount = SampleData.library.where((e) => e.media.isManga).length;
    final completedCount = SampleData.library.where((e) => e.status == LibStatus.completed).length;
    final completionPct = totalTitles > 0 ? (completedCount * 100 ~/ totalTitles) : 0;
    final allGenres = SampleData.library.expand((e) => e.media.genres).toList();
    final genreCount = <String, int>{};
    for (final g in allGenres) genreCount[g] = (genreCount[g] ?? 0) + 1;
    final topGenre = genreCount.entries.isEmpty
        ? 'Action'
        : (genreCount.entries.toList()..sort((a, b) => b.value.compareTo(a.value))).first.key;

    return ListView(
      padding: const EdgeInsets.only(top: 4, bottom: 100),
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 4, 16, 18),
          child: Text('Settings',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.7,
                  color: Colors.white)),
        ),
        // profile card
        Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0x297C5CFC), Color(0x141DB8A0)],
            ),
            border: Border.all(color: const Color(0x387C5CFC)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 54,
                height: 54,
                child: PosterArt(
                  paletteKey: 'jjk',
                  radius: 16,
                  children: const [
                    Center(
                        child: Text('K',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 22,
                                color: Colors.white))),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Kaito',
                        style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w800,
                            color: Colors.white)),
                    const SizedBox(height: 2),
                    Text('$totalTitles titles in library',
                        style: const TextStyle(fontSize: 12, color: AppColors.text2)),
                    const SizedBox(height: 10),
                    Row(children: [
                      _miniStat('$animeCount', 'Anime'),
                      const SizedBox(width: 16),
                      _miniStat('$mangaCount', 'Manga'),
                      const SizedBox(width: 16),
                      _miniStat('$completionPct%', 'Done'),
                      const SizedBox(width: 16),
                      _miniStat(topGenre, 'Top Genre'),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
        _section('Preferences', [
          _toggleItem(Icons.notifications_rounded, 'New title alerts', alerts,
              (v) => setState(() => alerts = v), last: true),
        ]),
        _section('Appearance', [
          _themeItem(Icons.light_mode_rounded, 'Light mode', ThemeMode.light),
          _themeItem(Icons.dark_mode_rounded, 'Dark mode', ThemeMode.dark,
              last: true),
        ]),
        _section('Extras', [
          _navItem(Icons.quiz_rounded, 'Anime & Manga Quiz', onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const QuizScreen()));
          }),
          _navItem(Icons.chat_bubble_rounded, 'Anime ChatBot', onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const ChatBotScreen()));
          }, last: true),
        ]),
        _section('Account', [
          _navItem(Icons.shield_rounded, 'Privacy & data', last: true),
        ]),
      ],
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 9),
            child: Text(title.toUpperCase(),
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: AppColors.text3)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0x0AFFFFFF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0x12FFFFFF)),
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label,
      {String? value, bool last = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        decoration: BoxDecoration(
          border: last
              ? null
              : const Border(bottom: BorderSide(color: Color(0x0DFFFFFF))),
        ),
        child: Row(
          children: [
            Icon(icon, size: 19, color: AppColors.accent300),
            const SizedBox(width: 13),
            Expanded(
                child: Text(label,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white))),
            if (value != null && value.isNotEmpty)
              Text(value,
                  style: const TextStyle(fontSize: 13, color: AppColors.text3)),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right_rounded,
                size: 16, color: AppColors.text3),
          ],
        ),
      ),
    );
  }

  Widget _themeItem(IconData icon, String label, ThemeMode mode,
      {bool last = false}) {
    final selected = widget.themeMode == mode;
    return GestureDetector(
      onTap: () => widget.onThemeChanged(mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        decoration: BoxDecoration(
          border: last
              ? null
              : const Border(bottom: BorderSide(color: Color(0x0DFFFFFF))),
        ),
        child: Row(
          children: [
            Icon(icon, size: 19, color: AppColors.accent300),
            const SizedBox(width: 13),
            Expanded(
                child: Text(label,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: selected ? AppColors.accent : const Color(0x12FFFFFF),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(selected ? 'Active' : 'Select',
                  style: TextStyle(
                      fontSize: 12.5,
                      color: selected ? Colors.white : AppColors.text3,
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white)),
        Text(label,
            style: const TextStyle(fontSize: 10, color: AppColors.text2)),
      ],
    );
  }

  Widget _toggleItem(
      IconData icon, String label, bool value, ValueChanged<bool> onChanged,
      {bool last = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(bottom: BorderSide(color: Color(0x0DFFFFFF))),
      ),
      child: Row(
        children: [
          Icon(icon, size: 19, color: AppColors.accent300),
          const SizedBox(width: 13),
          Expanded(
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white))),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: AppColors.accent,
            inactiveTrackColor: const Color(0x24FFFFFF),
            inactiveThumbColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
