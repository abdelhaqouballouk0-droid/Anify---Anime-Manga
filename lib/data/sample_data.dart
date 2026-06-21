import '../models/media.dart';
import '../models/quiz.dart';

/// Données d'exemple (équivalent de `window.NIFY` dans le mockup).
class SampleData {
  SampleData._();

  // ---------------------------- ANIME ----------------------------
  static const jjk = Media(
    key: 'jjk',
    title: 'Shadow Exorcist',
    jpTitle: '影の祓師',
    subtitle: 'The Sealing Night',
    rating: 9.1,
    year: 2023,
    count: 23,
    genres: ['Action', 'Dark Fantasy', 'Supernatural'],
    synopsis:
        "On a cursed night, the city is sealed beneath an ancient barrier. Exorcists and spirits clash in the streets as a young warrior races to break the seal before an unstoppable evil reshapes the spirit world forever.",
  );

  static const demon = Media(
    key: 'demon',
    title: 'Blade of Twilight',
    jpTitle: '黄昏の刃',
    subtitle: 'Final Covenant Arc',
    rating: 8.9,
    year: 2024,
    count: 8,
    genres: ['Action', 'Fantasy', 'Supernatural'],
    synopsis:
        "A young swordsman joins the elite Covenant warriors in a grueling trial to prepare for a final confrontation against the dark lord and his army of shadow demons.",
  );

  static const solo = Media(
    key: 'solo',
    title: 'Infinite Ascent',
    jpTitle: '無限の覚醒',
    subtitle: 'Awakening',
    rating: 8.7,
    year: 2024,
    count: 12,
    genres: ['Action', 'Fantasy', 'Adventure'],
    synopsis:
        "Ren Kagura, ranked the weakest of all fighters, unlocks a mysterious system that grants unlimited growth potential. As the rifts grow darker, he climbs toward a power no one has ever witnessed.",
  );

  static const frieren = Media(
    key: 'frieren',
    title: 'Eternal Wanderer',
    jpTitle: '永遠の旅人',
    subtitle: 'Memories Arc',
    rating: 9.4,
    year: 2023,
    count: 28,
    genres: ['Adventure', 'Fantasy', 'Slice of Life'],
    synopsis:
        "An immortal mage who has outlived her companions sets out on a quiet journey to truly understand the mortals she once adventured with. A tender meditation on time, memory, and connection.",
  );

  static const dungeon = Media(
    key: 'dungeon',
    title: 'Labyrinth Feasts',
    jpTitle: '迷宮の晩餐',
    subtitle: 'Depths Edition',
    rating: 8.6,
    year: 2024,
    count: 24,
    genres: ['Adventure', 'Comedy', 'Fantasy'],
    synopsis:
        "After losing all their supplies to a fire dragon, a party of adventurers ventures back into the labyrinth — surviving by cooking and eating the monsters they defeat.",
  );

  static const bluelock = Media(
    key: 'bluelock',
    title: 'Striker Zero',
    jpTitle: 'ストライカーゼロ',
    subtitle: 'Selection Arc',
    rating: 8.3,
    year: 2024,
    count: 14,
    genres: ['Sports', 'Drama', 'Thriller'],
    synopsis:
        "Three hundred young footballers are locked inside a radical facility designed to forge the world's greatest striker. Only one will emerge victorious.",
  );

  static const vinland = Media(
    key: 'vinland',
    title: 'Northern Saga',
    jpTitle: '北の英雄',
    subtitle: 'Harvest Arc',
    rating: 8.8,
    year: 2023,
    count: 24,
    genres: ['Action', 'Adventure', 'Drama'],
    synopsis:
        "Stripped of vengeance and sold into bondage, a young warrior must find the will to live in a brutal world ruled by iron and blood.",
  );

  // ---------------------------- MANGA ----------------------------
  static const csm = Media(
    key: 'csm',
    title: 'Edge Reaper',
    jpTitle: '刃の悪魔',
    subtitle: 'School Arc',
    rating: 9.0,
    year: 2024,
    count: 162,
    genres: ['Action', 'Dark Fantasy', 'Comedy'],
    isManga: true,
    unread: true,
    synopsis:
        "Kei is a devil-fused hunter — a young man bonded to a blade demon, fighting dark creatures to survive in a world where devils and humans clash daily.",
  );

  static const onepiece = Media(
    key: 'onepiece',
    title: 'Endless Voyage',
    jpTitle: '果てなき航海',
    subtitle: 'Final Arc · Sky Fortress',
    rating: 9.3,
    year: 2024,
    count: 1118,
    genres: ['Adventure', 'Action', 'Fantasy'],
    isManga: true,
    unread: true,
    synopsis:
        "Captain Rao Sunfist and his crew of misfit sailors chase a legendary treasure across uncharted seas. The Final Arc tears back the curtain on the world's oldest secrets.",
  );

  static const berserk = Media(
    key: 'berserk',
    title: 'Cursed Blade',
    jpTitle: '呪われた剣',
    subtitle: 'Realm Arc',
    rating: 9.4,
    year: 2024,
    count: 374,
    genres: ['Dark Fantasy', 'Action', 'Tragedy'],
    isManga: true,
    synopsis:
        "Marked for death by a god-hand, a lone black swordsman wages a relentless war against demons and a fate written in blood.",
  );

  static const spy = Media(
    key: 'spy',
    title: 'Double Veil',
    jpTitle: '二重の仮面',
    subtitle: 'Operation Cipher',
    rating: 8.7,
    year: 2024,
    count: 102,
    genres: ['Comedy', 'Action', 'Slice of Life'],
    isManga: true,
    unread: true,
    synopsis:
        "An elite agent, a ghost assassin, and a gifted child form a secret family to prevent a war — none of them knowing the others' true identity.",
  );

  static const apoth = Media(
    key: 'apoth',
    title: 'Court Alchemist',
    jpTitle: '宮廷の薬師',
    subtitle: 'Volume 12',
    rating: 8.9,
    year: 2024,
    count: 78,
    genres: ['Mystery', 'Drama', 'Historical'],
    isManga: true,
    synopsis:
        "A razor-sharp herbalist navigates poison plots, court politics, and deadly intrigue within the walls of the imperial palace.",
  );

  // ---------------------------- FEEDS ----------------------------
  static const List<Media> newReleases = [
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
          'Dans quel anime un jeune guerrier combat-il des esprits dans une ville scellée par une barrière maudite ?',
      options: [
        'Blade of Twilight',
        'Shadow Exorcist',
        'Northern Saga',
        'Double Veil'
      ],
      answerIndex: 1,
      explanation:
          'Shadow Exorcist suit un jeune exorciste dans un monde de malédictions et de barrières spirituelles.',
    ),
    QuizQuestion(
      question:
          "Quel manga met en scene un capitaine aventurier a la recherche d'un tresor legendaire ?",
      options: ['Edge Reaper', 'Endless Voyage', 'Cursed Blade', 'Eternal Wanderer'],
      answerIndex: 1,
      explanation:
          "Endless Voyage raconte l'histoire du capitaine Rao Sunfist et de son équipage en quête du trésor ultime.",
    ),
    QuizQuestion(
      question:
          "Quel titre présente une famille secrète formée d'un agent, d'une assassine et d'un enfant doué ?",
      options: [
        'Infinite Ascent',
        'Blade of Twilight',
        'Double Veil',
        'Northern Saga'
      ],
      answerIndex: 2,
      explanation:
          'Double Veil met en scène trois individus aux identités secrètes qui vivent sous couverture familiale.',
    ),
    QuizQuestion(
      question:
          "Quel anime a un ton contemplatif et explore la mémoire à travers les yeux d'une mage immortelle ?",
      options: ['Eternal Wanderer', 'Striker Zero', 'Labyrinth Feasts', 'Edge Reaper'],
      answerIndex: 0,
      explanation:
          "Eternal Wanderer explore le temps et la mémoire à travers le voyage d'une mage qui a survécu à ses compagnons.",
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

}
