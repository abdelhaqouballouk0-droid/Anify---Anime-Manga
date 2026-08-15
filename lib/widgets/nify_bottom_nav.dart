import 'dart:ui';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class NavDestination {
  final IconData icon;
  final String label;
  const NavDestination(this.icon, this.label);
}

/// Barre de navigation flottante (Home / Search / Library / Settings).
class AnifyBottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;

  const AnifyBottomNav({super.key, required this.index, required this.onTap});

  static const _items = [
    NavDestination(Icons.home_rounded, 'Home'),
    NavDestination(Icons.search_rounded, 'Search'),
    NavDestination(Icons.grid_view_rounded, 'Library'),
    NavDestination(Icons.settings_rounded, 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x000D0D0F), AppColors.bg],
          stops: [0, 0.4],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xD116161B),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0x12FFFFFF)),
              boxShadow: const [
                BoxShadow(color: Color(0x80000000), blurRadius: 34, offset: Offset(0, 12)),
              ],
            ),
            child: Row(
              children: List.generate(_items.length, (i) {
                final on = i == index;
                final it = _items[i];
                return Expanded(
                  child: InkWell(
                    onTap: () => onTap(i),
                    borderRadius: BorderRadius.circular(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 6,
                          child: on
                              ? Container(
                                  width: 26,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: AppColors.accent,
                                    borderRadius: BorderRadius.circular(999),
                                    boxShadow: const [
                                      BoxShadow(color: AppColors.accent, blurRadius: 12),
                                    ],
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(height: 6),
                        Icon(it.icon, size: 23, color: on ? AppColors.accent300 : AppColors.text3),
                        const SizedBox(height: 3),
                        Text(
                          it.label,
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: on ? FontWeight.w700 : FontWeight.w600,
                            color: on ? AppColors.accent300 : AppColors.text3,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
