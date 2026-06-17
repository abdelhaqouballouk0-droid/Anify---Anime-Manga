/// Modèle unifié anime / manga.
class Media {
  final String key; // clé de palette
  final String title;
  final String jpTitle;
  final String subtitle;
  final double rating;
  final int year;
  final int count; // épisodes (anime) ou chapitres (manga)
  final String duration; // "24m" / "Ch. 162"
  final List<String> genres;
  final bool isManga;
  final bool unread;
  final String synopsis;

  const Media({
    required this.key,
    required this.title,
    required this.jpTitle,
    required this.subtitle,
    required this.rating,
    required this.year,
    required this.count,
    required this.duration,
    required this.genres,
    this.isManga = false,
    this.unread = false,
    required this.synopsis,
  });
}

/// Élément "en cours" : un Media + une progression.
class ProgressItem {
  final Media media;
  final int number; // n° épisode ou chapitre
  final double progress; // 0..1
  final String? timeLeft;

  const ProgressItem({
    required this.media,
    required this.number,
    required this.progress,
    this.timeLeft,
  });
}

/// Statut de bibliothèque.
enum LibStatus { watching, completed, planning, dropped, favorites }

extension LibStatusLabel on LibStatus {
  String get label => switch (this) {
        LibStatus.watching => 'Watching',
        LibStatus.completed => 'Completed',
        LibStatus.planning => 'Planning',
        LibStatus.dropped => 'Dropped',
        LibStatus.favorites => 'Favorites',
      };
}

class LibraryEntry {
  final Media media;
  final LibStatus status;
  final int? current;
  final int? total;

  const LibraryEntry({
    required this.media,
    required this.status,
    this.current,
    this.total,
  });

  bool get inProgress => current != null && total != null && current! < total!;
}

