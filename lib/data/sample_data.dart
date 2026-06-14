import '../models/media.dart';
import '../models/quiz.dart';

/// Données d'exemple (équivalent de `window.NIFY` dans le mockup).
class SampleData {
  SampleData._();

  // ---------------------------- ANIME ----------------------------
  static const jjk = Media(
    key: 'jjk',
    title: 'Jujutsu Kaisen',
    jpTitle: '呪術廻戦',
    subtitle: 'Shibuya Incident',
    rating: 9.1,
    year: 2023,
    count: 23,
    duration: '24m',
    genres: ['Action', 'Dark Fantasy', 'Supernatural'],
    synopsis:
        "On Halloween night, Shibuya is sealed off by a veil. Sorcerers and curses clash in the streets as Yuji and his allies race to free Gojo and stop a catastrophe that could reshape the jujutsu world forever.",
  );

  static const demon = Media(
    key: 'demon',
    title: 'Demon Slayer',
    jpTitle: '鬼滅の刃',
    subtitle: 'Hashira Training Arc',
    rating: 8.9,
    year: 2024,
    count: 8,
    duration: '24m',
    genres: ['Action', 'Fantasy', 'Supernatural'],
    synopsis:
        "Tanjiro joins the Hashira as they begin a brutal training regimen to prepare for the looming battle against Muzan Kibutsuji and the Upper Rank demons.",
  );

  static const solo = Media(
    key: 'solo',
    title: 'Solo Leveling',
    jpTitle: '俺だけレベルアップな件',
    subtitle: 'Arise',
    rating: 8.7,
    year: 2024,
    count: 12,
    duration: '24m',
    genres: ['Action', 'Fantasy', 'Adventure'],
    synopsis:
        "Sung Jinwoo, the weakest hunter of all mankind, awakens a mysterious System that lets him grow without limit. As dungeons darken, he climbs toward a power no one has ever seen.",
  );

  static const frieren = Media(
    key: 'frieren',
    title: 'Frieren',
    jpTitle: '葬送のフリーレン',
    subtitle: "Beyond Journey's End",
    rating: 9.4,
    year: 2023,
    count: 28,
    duration: '24m',
    genres: ['Adventure', 'Fantasy', 'Slice of Life'],
    synopsis:
        "An elven mage who outlives her party sets out to truly understand the humans she travelled with. A quiet meditation on memory, time, and what it means to know someone.",
  );

  static const dungeon = Media(
    key: 'dungeon',
    title: 'Dungeon Meshi',
    jpTitle: 'ダンジョン飯',
    subtitle: 'Delicious in Dungeon',
    rating: 8.6,
    year: 2024,
    count: 24,
    duration: '24m',
    genres: ['Adventure', 'Comedy', 'Fantasy'],
    synopsis:
        "After a party loses everything to a red dragon, Laios leads them back into the dungeon — surviving on monster cuisine along the way.",
  );

  static const bluelock = Media(
    key: 'bluelock',
    title: 'Blue Lock',
    jpTitle: 'ブルーロック',
    subtitle: 'Episode Nagi',
    rating: 8.3,
    year: 2024,
    count: 14,
    duration: '24m',
    genres: ['Sports', 'Drama', 'Thriller'],
    synopsis:
        "300 strikers are locked into a radical facility built to forge the world's greatest egoist. Only one will emerge.",
  );

  static const vinland = Media(
    key: 'vinland',
    title: 'Vinland Saga',
    jpTitle: 'ヴィンランド・サガ',
    subtitle: 'Season 2',
    rating: 8.8,
    year: 2023,
    count: 24,
    duration: '24m',
    genres: ['Action', 'Adventure', 'Drama'],
    synopsis:
        "Stripped of vengeance and sold into slavery, Thorfinn must find a reason to live in a world ruled by the sword.",
  );

  // ---------------------------- MANGA ----------------------------
  static const csm = Media(
    key: 'csm',
    title: 'Chainsaw Man',
    jpTitle: 'チェンソーマン',
    subtitle: 'Part 2: Academy Saga',
    rating: 9.0,
    year: 2024,
    count: 162,
    duration: 'Ch. 162',
    genres: ['Action', 'Dark Fantasy', 'Comedy'],
    isManga: true,
    unread: true,
    synopsis:
        "Denji is the Chainsaw Devil — a kid with a chainsaw for a head, hunting devils to pay off an impossible debt. Then everything gets so much weirder.",
  );

  static const onepiece = Media(
    key: 'onepiece',
    title: 'One Piece',
    jpTitle: 'ワンピース',
    subtitle: 'Final Saga · Egghead',
    rating: 9.3,
    year: 2024,
    count: 1118,
    duration: 'Ch. 1118',
    genres: ['Adventure', 'Action', 'Fantasy'],
    isManga: true,
    unread: true,
    synopsis:
        "Monkey D. Luffy and the Straw Hats sail toward the legendary One Piece. The Final Saga pulls back the curtain on the world's deepest secrets.",
  );

  static const berserk = Media(
    key: 'berserk',
    title: 'Berserk',
    jpTitle: 'ベルセルク',
    subtitle: 'Fantasia Arc',
    rating: 9.4,
    year: 2024,
    count: 374,
    duration: 'Ch. 374',
    genres: ['Dark Fantasy', 'Action', 'Tragedy'],
    isManga: true,
    synopsis:
        "Branded for death, the lone swordsman Guts wages an endless war against demons and fate itself.",
  );

  static const spy = Media(
    key: 'spy',
    title: 'Spy x Family',
    jpTitle: 'スパイファミリー',
    subtitle: 'Mission 102',
    rating: 8.7,
    year: 2024,
    count: 102,
    duration: 'Ch. 102',
    genres: ['Comedy', 'Action', 'Slice of Life'],
    isManga: true,
    unread: true,
    synopsis:
        "A spy, an assassin, and a telepath form a fake family for the sake of world peace — none of them knowing the others' secret.",
  );

  static const apoth = Media(
    key: 'apoth',
    title: 'The Apothecary Diaries',
    jpTitle: '薬屋のひとりごと',
    subtitle: 'Volume 12',
    rating: 8.9,
    year: 2024,
    count: 78,
    duration: 'Ch. 78',
    genres: ['Mystery', 'Drama', 'Historical'],
    isManga: true,
    synopsis:
        "A sharp-witted apothecary navigates poison, politics, and palace intrigue in the imperial rear court.",
  );

  // ---------------------------- FEEDS ----------------------------
  static const List<Media> airing = [
    jjk,
    solo,
    demon,
    frieren,
    dungeon,
    bluelock
  ];
  static const List<Media> popular = [
    demon,
    dungeon,
    bluelock,
    vinland,
    solo,
    frieren
  ];

  static const List<ProgressItem> continueWatching = [
    ProgressItem(media: jjk, number: 17, progress: 0.62, timeLeft: '9m left'),
    ProgressItem(media: solo, number: 8, progress: 0.30, timeLeft: '17m left'),
    ProgressItem(
        media: frieren, number: 21, progress: 0.85, timeLeft: '4m left'),
    ProgressItem(
        media: vinland, number: 11, progress: 0.12, timeLeft: '21m left'),
  ];

  static const List<ProgressItem> continueReading = [
    ProgressItem(media: csm, number: 161, progress: 0.55),
    ProgressItem(media: onepiece, number: 1117, progress: 0.40),
    ProgressItem(media: spy, number: 101, progress: 0.78),
    ProgressItem(media: apoth, number: 77, progress: 0.20),
  ];

  // ---------------------------- LIBRARY ----------------------------
  static const List<LibraryEntry> library = [
    LibraryEntry(
        media: jjk, status: LibStatus.watching, current: 17, total: 23),
    LibraryEntry(
        media: solo, status: LibStatus.watching, current: 8, total: 12),
    LibraryEntry(
        media: frieren, status: LibStatus.watching, current: 21, total: 28),
    LibraryEntry(
        media: csm, status: LibStatus.watching, current: 161, total: 162),
    LibraryEntry(
        media: demon, status: LibStatus.completed, current: 8, total: 8),
    LibraryEntry(
        media: vinland, status: LibStatus.completed, current: 24, total: 24),
    LibraryEntry(
        media: spy, status: LibStatus.completed, current: 102, total: 102),
    LibraryEntry(media: dungeon, status: LibStatus.planning),
    LibraryEntry(media: bluelock, status: LibStatus.planning),
    LibraryEntry(media: berserk, status: LibStatus.planning),
    LibraryEntry(
        media: apoth, status: LibStatus.dropped, current: 12, total: 78),
    LibraryEntry(
        media: onepiece,
        status: LibStatus.favorites,
        current: 1117,
        total: 1118),
    LibraryEntry(media: frieren, status: LibStatus.favorites),
  ];

  static const List<QuizQuestion> quizQuestions = [
    QuizQuestion(
      question:
          'Quel anime se déroule dans un monde rempli de malédictions et d’exorcistes ?',
      options: [
        'Demon Slayer',
        'Jujutsu Kaisen',
        'Vinland Saga',
        'Spy x Family'
      ],
      answerIndex: 1,
      explanation:
          'Jujutsu Kaisen suit Yuji Itadori dans un monde de sorcellerie et de malédictions.',
    ),
    QuizQuestion(
      question:
          'Quel manga suit un pirate en quête du trésor légendaire One Piece ?',
      options: ['Chainsaw Man', 'One Piece', 'Berserk', 'Frieren'],
      answerIndex: 1,
      explanation:
          'One Piece raconte l’histoire de Monkey D. Luffy et de son équipage pirate.',
    ),
    QuizQuestion(
      question:
          'Quel titre est centré sur une famille d’espions et d’assassins ?',
      options: [
        'Solo Leveling',
        'Demon Slayer',
        'Spy x Family',
        'Vinland Saga'
      ],
      answerIndex: 2,
      explanation:
          'Spy x Family met en scène un espion, une assassin et une télépathe sous couverture familiale.',
    ),
    QuizQuestion(
      question:
          'Quel anime a un ton plus contemplatif et traite de la vie après une quête ?',
      options: ['Frieren', 'Blue Lock', 'Dungeon Meshi', 'Chainsaw Man'],
      answerIndex: 0,
      explanation:
          'Frieren explore le temps et la mémoire après la fin d’une grande aventure.',
    ),
  ];

  static const List<Media> searchPool = [
    jjk,
    demon,
    solo,
    frieren,
    dungeon,
    bluelock,
    vinland,
    csm,
    onepiece,
    berserk,
    spy,
    apoth,
  ];

  static const List<Media> trending = [
    jjk,
    demon,
    solo,
    csm,
    frieren,
    onepiece
  ];

  // Génère une liste d'épisodes pour l'écran de détails.
  static List<Episode> episodesFor(Media m) {
    const titles = [
      'To Defeat the Strongest',
      'Hidden Inventory',
      'A New Resolve',
      'Crossroads',
      'The Shape of Fear',
      'Pandemonium',
      'Right and Wrong',
      "Storm's Edge",
      'Ashes and Embers',
      'The Long Night',
      'Severance',
      'Daybreak',
    ];
    const durations = ['23:40', '24:12', '24:05', '23:58'];
    final n = m.count.clamp(1, 12);
    return List.generate(
      n,
      (i) => Episode(
        no: i + 1,
        title: titles[i % titles.length],
        duration: durations[i % durations.length],
        watched: i < 3,
        current: i == 3,
      ),
    );
  }
}
