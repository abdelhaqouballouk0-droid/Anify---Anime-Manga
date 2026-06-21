/// Modèle unifié anime / manga.
class Media {
  final String key; // clé de palette
  final String title;
  final String jpTitle;
  final String subtitle;
  final double rating;
  final int year;
  final int count;
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
    required this.genres,
    this.isManga = false,
    this.unread = false,
    required this.synopsis,
  });
}

/// Statut de bibliothèque.
enum LibStatus { watching, completed, planning, dropped, favorites }

extension LibStatusLabel on LibStatus {
  String get label => switch (this) {
        LibStatus.watching => 'Following',
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

