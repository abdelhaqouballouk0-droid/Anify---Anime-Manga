import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/library_screen.dart';
import 'screens/search_screen.dart';
import 'screens/settings_screen.dart';
import 'widgets/nify_bottom_nav.dart';

/// Scaffold racine : IndexedStack des onglets persistants + bottom nav.
/// Home / Library / Settings vivent dans la pile ; Search est poussé en route.
class AnifyShell extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  const AnifyShell(
      {super.key, required this.themeMode, required this.onThemeChanged});

  @override
  State<AnifyShell> createState() => _AnifyShellState();
}

class _AnifyShellState extends State<AnifyShell> {
  int navIndex = 0; // 0 home · 1 search · 2 library · 3 settings

  // Mapping nav -> page dans l'IndexedStack.
  static const _navToPage = {0: 0, 2: 1, 3: 2};

  void _onTap(int i) {
    if (i == 1) {
      setState(() => navIndex = i);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const SearchScreen()))
          .then((_) {
        if (mounted) {
          setState(() => navIndex = 0);
        }
      });
      return;
    }
    setState(() => navIndex = i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SafeArea(
              bottom: false,
              child: IndexedStack(
                index: _navToPage[navIndex] ?? 0,
                children: [
                  const HomeScreen(),
                  const LibraryScreen(),
                  SettingsScreen(
                      themeMode: widget.themeMode,
                      onThemeChanged: widget.onThemeChanged),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: AnifyBottomNav(index: navIndex, onTap: _onTap),
            ),
          ),
        ],
      ),
    );
  }
}
