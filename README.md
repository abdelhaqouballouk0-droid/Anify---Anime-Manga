# Anify (Flutter)

Application anime & manga sombre, premium, avec
découverte, lecture vidéo, lecture manga et suivi de progression.

Cette base reprend fidèlement le mockup HTML d'origine : palette near-black, accent indigo
électrique `#7C5CFC`, accent teal `#1DB8A0` pour le manga, posters génératifs (aucune image
sous copyright), typo Plus Jakarta Sans.

---

## 1. Prérequis

- Flutter SDK **3.3+** (Dart 3.3+) — `flutter --version`
- VSCode + extensions **Flutter** et **Dart**
- Un émulateur Android/iOS ou Chrome pour le web

## 2. Démarrage

Ce dossier contient `lib/` et `pubspec.yaml`. Il faut générer les dossiers de plateforme
(android / ios / web…) une seule fois :

```bash
cd nify_app

# Génère android/ ios/ web/ etc. SANS écraser lib/ ni pubspec.yaml
flutter create .

flutter pub get
flutter run        # choisis ta cible (Chrome, émulateur…)
```

> Astuce : pour le web → `flutter run -d chrome`.

## 3. Architecture

```
lib/
├── main.dart                 # point d'entrée → AnifyApp
├── app.dart                  # MaterialApp + thème
├── shell.dart                # Scaffold racine : bottom nav + IndexedStack
├── theme/
│   ├── app_colors.dart       # tokens couleur
│   └── app_theme.dart        # ThemeData Material 3 + textes
├── models/
│   └── media.dart            # modèle Media (anime/manga) + items de progression
├── data/
│   └── sample_data.dart      # données d'exemple (titres, feeds home, library)
├── utils/
│   └── poster_palette.dart   # palettes duotone + type de motif par titre
├── widgets/
│   ├── poster_art.dart       # poster génératif (gradient + motif peint)
│   ├── poster_motif_painter.dart
│   ├── pill.dart             # badges / pills
│   ├── progress_bar.dart
│   ├── rating_stars.dart
│   ├── section_header.dart
│   └── nify_bottom_nav.dart
└── screens/
    ├── home_screen.dart
    ├── details_screen.dart
    ├── player_screen.dart
    ├── reader_screen.dart
    ├── library_screen.dart
    ├── search_screen.dart
    └── settings_screen.dart
```

## 4. Navigation

- **Bottom nav** : Home / Search / Library / Settings (via `Navigator` pour Search).
- Taper une carte anime → `DetailsScreen` → bouton lecture → `PlayerScreen`.
- Taper un manga → `ReaderScreen` (lecture longue, chrome qui se cache au scroll).
- Toutes les transitions utilisent `Navigator.push` avec des routes animées.

## 5. À faire ensuite (pistes)

- Brancher une vraie source de données (API type AniList / consumet) dans `data/`.
- Lecteur vidéo réel : remplacer le faux player par `video_player` + `chewie`.
- Lecteur manga : `extended_image` + pagination réseau.
- Persistance de la progression : `shared_preferences` ou `isar` / `drift`.
- State management : `riverpod` ou `bloc` (le scaffold utilise du `setState` simple).

---

Couleurs et composants sont centralisés dans `theme/` et `widgets/` : commence par là pour
ajuster l'identité visuelle.
