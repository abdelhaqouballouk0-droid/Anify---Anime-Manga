import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/media.dart';
import '../theme/app_colors.dart';
import '../widgets/pill.dart';
import '../widgets/app_logo.dart';
import '../widgets/poster_art.dart';
import '../widgets/rating_stars.dart';
import '../widgets/section_header.dart';
import 'chatbot_screen.dart';
import 'details_screen.dart';
import 'quiz_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _open(BuildContext context, Media m) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => DetailsScreen(media: m),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 4, bottom: 100),
      children: [
        _TopBar(onSearch: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const SearchScreen()));
        }),
        const SizedBox(height: 6),
        _HeroSpotlight(
            media: SampleData.jjk, onTap: () => _open(context, SampleData.jjk)),
        const SizedBox(height: 22),
        const SectionHeader(
            title: 'Explore', overline: 'Tools', onAction: _noop),
        _FeatureRow(
          children: [
            _FeatureCard(
              icon: Icons.quiz_rounded,
              title: 'Anime Quiz',
              subtitle: 'Test your knowledge',
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const QuizScreen())),
            ),
            _FeatureCard(
              icon: Icons.chat_bubble_rounded,
              title: 'ChatBot',
              subtitle: 'Ask about anime & manga',
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ChatBotScreen())),
            ),
          ],
        ),
        const SizedBox(height: 26),
        const SectionHeader(
            title: 'New Releases', overline: 'This week', onAction: _noop),
        _HRow(
          height: 252,
          children: [
            for (final m in SampleData.newReleases)
              _AiringCard(media: m, onTap: () => _open(context, m)),
          ],
        ),
        const SizedBox(height: 28),
        const SectionHeader(
            title: 'Popular This Season', overline: 'Top 6', onAction: _noop),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: SampleData.popular.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 168 / 168,
            ),
            itemBuilder: (_, i) => _PopularCard(
              media: SampleData.popular[i],
              rank: i + 1,
              onTap: () => _open(context, SampleData.popular[i]),
            ),
          ),
        ),
      ],
    );
  }

  static void _noop() {}
}

// --------------------------------------------------------------------------

class _TopBar extends StatelessWidget {
  final VoidCallback onSearch;
  const _TopBar({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Row(
        children: [
          const AppLogo(size: 36, withBackground: true),
          const Spacer(),
          _IconButton(icon: Icons.search_rounded, onTap: onSearch),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: SizedBox(
              width: 40,
              height: 40,
              child: PosterArt(
                paletteKey: 'jjk',
                radius: 13,
                children: const [
                  Center(
                    child: Text('K',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconButton({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
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
          child: Icon(icon, size: 21, color: Colors.white),
        ),
      ),
    );
  }
}

class _HRow extends StatelessWidget {
  final double height;
  final List<Widget> children;
  const _HRow({required this.height, required this.children});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: children.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => children[i],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final List<Widget> children;
  const _FeatureRow({required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            Expanded(child: children[i]),
            if (i != children.length - 1) const SizedBox(width: 12),
          ],
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0x141B1B24),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0x14FFFFFF)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 14),
            Text(title,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.white)),
            const SizedBox(height: 6),
            Text(subtitle,
                style: const TextStyle(
                    fontSize: 12.5, color: AppColors.text2, height: 1.4)),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------------------------------

class _HeroSpotlight extends StatelessWidget {
  final Media media;
  final VoidCallback onTap;
  const _HeroSpotlight({required this.media, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 200,
          child: PosterArt(
            paletteKey: media.key,
            radius: 20,
            children: [
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xEB08080B),
                      Color(0x1A08080B),
                      Color(0x4D08080B)
                    ],
                    stops: [0.04, 0.55, 1],
                  ),
                ),
              ),
              const Positioned(
                top: 12,
                left: 12,
                child: Row(children: [
                  Pill('#1 Spotlight',
                      tone: PillTone.accent,
                      icon: Icon(Icons.local_fire_department_rounded)),
                ]),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(media.title,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.7,
                            color: Colors.white)),
                    const SizedBox(height: 6),
                    Row(children: [
                      RatingStars(rating: media.rating),
                      const SizedBox(width: 8),
                      Text(media.rating.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: AppColors.star,
                              fontSize: 12)),
                      const SizedBox(width: 8),
                      Text(media.genres.take(2).join(' · '),
                          style: const TextStyle(
                              color: AppColors.text2, fontSize: 12)),
                    ]),
                    const SizedBox(height: 12),
                    Row(children: [
                      _CtaButton(
                          label: 'My List',
                          icon: Icons.add_rounded,
                          filled: false,
                          onTap: () {}),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CtaButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;
  const _CtaButton(
      {required this.label,
      required this.icon,
      required this.filled,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: filled ? Colors.white : const Color(0x24FFFFFF),
          borderRadius: BorderRadius.circular(12),
          border: filled ? null : Border.all(color: const Color(0x1AFFFFFF)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 17, color: filled ? AppColors.bg : Colors.white),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13.5,
                  color: filled ? AppColors.bg : Colors.white)),
        ]),
      ),
    );
  }
}

// --------------------------------------------------------------------------

class _AiringCard extends StatelessWidget {
  final Media media;
  final VoidCallback onTap;
  const _AiringCard({required this.media, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 148,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: PosterArt(
                paletteKey: media.key,
                radius: 14,
                children: [
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Color(0xB308080B), Colors.transparent],
                        stops: [0, 0.45],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    right: 10,
                    bottom: 10,
                    child: Text(media.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.1)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 7),
            Text(media.genres.first,
                style: const TextStyle(fontSize: 11, color: AppColors.text3)),
          ],
        ),
      ),
    );
  }
}



class _PopularCard extends StatelessWidget {
  final Media media;
  final int rank;
  final VoidCallback onTap;
  const _PopularCard(
      {required this.media, required this.rank, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: PosterArt(
        paletteKey: media.key,
        radius: 14,
        children: [
          Positioned(
            top: 0,
            left: 8,
            child: Text('$rank',
                style: const TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.w900,
                    height: 0.8,
                    letterSpacing: -2,
                    color: Color(0x29FFFFFF))),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Pill(media.rating.toString(),
                icon: const Icon(Icons.star_rounded, color: AppColors.star)),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xD108080B), Colors.transparent],
                stops: [0, 0.46],
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(media.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.1)),
                const SizedBox(height: 3),
                Text('${media.genres.first} · ${media.count} eps',
                    style: const TextStyle(
                        fontSize: 10.5, color: AppColors.text2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
