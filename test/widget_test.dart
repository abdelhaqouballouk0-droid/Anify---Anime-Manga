import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:anify/app.dart';
import 'package:anify/widgets/app_logo.dart';
import 'package:anify/widgets/nify_bottom_nav.dart';
import 'package:anify/widgets/pill.dart';
import 'package:anify/widgets/rating_stars.dart';

void main() {
  setUpAll(() {
    // Prevent google_fonts from hitting the network during tests.
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  // ---------------------------------------------------------------------------
  // AppLogo
  // ---------------------------------------------------------------------------
  group('AppLogo', () {
    testWidgets('renders at the requested size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AppLogo(size: 64))),
      );
      final box = tester.renderObject<RenderBox>(find.byType(SizedBox).first);
      expect(box.size, const Size(64, 64));
    });

    testWidgets('uses CustomPaint to draw the logo', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AppLogo())),
      );
      expect(
        find.descendant(of: find.byType(AppLogo), matching: find.byType(CustomPaint)),
        findsOneWidget,
      );
    });

    testWidgets('renders without background', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppLogo(withBackground: false)),
        ),
      );
      expect(find.byType(AppLogo), findsOneWidget);
    });
  });

  // ---------------------------------------------------------------------------
  // AnifyBottomNav
  // ---------------------------------------------------------------------------
  group('AnifyBottomNav', () {
    Widget buildNav({int index = 0, ValueChanged<int>? onTap}) =>
        MaterialApp(
          home: Scaffold(
            body: AnifyBottomNav(index: index, onTap: onTap ?? (_) {}),
          ),
        );

    testWidgets('shows all four tab labels', (tester) async {
      await tester.pumpWidget(buildNav());
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Library'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('calls onTap with the correct index', (tester) async {
      int tapped = -1;
      await tester.pumpWidget(buildNav(onTap: (i) => tapped = i));
      await tester.tap(find.text('Library'));
      expect(tapped, 2);
    });

    testWidgets('calls onTap when Settings is tapped', (tester) async {
      int tapped = -1;
      await tester.pumpWidget(buildNav(onTap: (i) => tapped = i));
      await tester.tap(find.text('Settings'));
      expect(tapped, 3);
    });
  });

  // ---------------------------------------------------------------------------
  // RatingStars
  // ---------------------------------------------------------------------------
  group('RatingStars', () {
    Widget buildStars(double rating) => MaterialApp(
          home: Scaffold(body: RatingStars(rating: rating)),
        );

    testWidgets('always renders exactly 5 star icons', (tester) async {
      await tester.pumpWidget(buildStars(7.0));
      // Each star uses two Icons.star_rounded (background + clip layer).
      expect(find.byIcon(Icons.star_rounded), findsNWidgets(10));
    });

    testWidgets('renders for zero rating', (tester) async {
      await tester.pumpWidget(buildStars(0));
      expect(find.byType(RatingStars), findsOneWidget);
    });

    testWidgets('renders for maximum rating (10)', (tester) async {
      await tester.pumpWidget(buildStars(10));
      expect(find.byType(RatingStars), findsOneWidget);
    });
  });

  // ---------------------------------------------------------------------------
  // Pill
  // ---------------------------------------------------------------------------
  group('Pill', () {
    Widget buildPill(String text, {PillTone tone = PillTone.glass}) =>
        MaterialApp(
          home: Scaffold(body: Pill(text, tone: tone)),
        );

    testWidgets('displays its text', (tester) async {
      await tester.pumpWidget(buildPill('TV · 24 ep'));
      expect(find.text('TV · 24 ep'), findsOneWidget);
    });

    testWidgets('renders accent tone without error', (tester) async {
      await tester.pumpWidget(buildPill('NEW', tone: PillTone.accent));
      expect(find.text('NEW'), findsOneWidget);
    });

    testWidgets('renders solid tone without error', (tester) async {
      await tester.pumpWidget(buildPill('HD', tone: PillTone.solid));
      expect(find.text('HD'), findsOneWidget);
    });

    testWidgets('renders with an icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Pill(
              '8.4',
              tone: PillTone.glass,
              icon: const Icon(Icons.star_rounded),
            ),
          ),
        ),
      );
      expect(find.text('8.4'), findsOneWidget);
      expect(find.byIcon(Icons.star_rounded), findsOneWidget);
    });
  });

  // ---------------------------------------------------------------------------
  // AnifyApp
  // ---------------------------------------------------------------------------
  group('AnifyApp', () {
    testWidgets('starts in dark mode by default', (tester) async {
      await tester.pumpWidget(const AnifyApp());
      await tester.pump();
      final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app.themeMode, ThemeMode.dark);
    });

    testWidgets('renders the bottom navigation bar', (tester) async {
      await tester.pumpWidget(const AnifyApp());
      await tester.pump();
      expect(find.byType(AnifyBottomNav), findsOneWidget);
    });

    testWidgets('shows Home tab on launch', (tester) async {
      await tester.pumpWidget(const AnifyApp());
      await tester.pump();
      expect(find.text('Home'), findsOneWidget);
    });
  });
}
