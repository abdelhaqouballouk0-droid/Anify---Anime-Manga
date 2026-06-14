import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'shell.dart';
import 'theme/app_theme.dart';

class NifyApp extends StatefulWidget {
  const NifyApp({super.key});

  @override
  State<NifyApp> createState() => _NifyAppState();
}

class _NifyAppState extends State<NifyApp> {
  ThemeMode themeMode = ThemeMode.dark;

  void _updateTheme(ThemeMode mode) {
    setState(() {
      themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLight = themeMode == ThemeMode.light;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
      systemNavigationBarColor:
          isLight ? const Color(0xFFF7F8FC) : const Color(0xFF0D0D0F),
      systemNavigationBarIconBrightness:
          isLight ? Brightness.dark : Brightness.light,
    ));

    return MaterialApp(
      title: 'Anify - Anime & Manga',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      home: NifyShell(themeMode: themeMode, onThemeChanged: _updateTheme),
    );
  }
}
