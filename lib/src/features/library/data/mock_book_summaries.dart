import '../domain/entities/book_summary.dart';
import '../domain/entities/highlight_item.dart';
import '../../reader_player/domain/entities/takeaway_card.dart';

final List<BookSummary> sampleBookSummaries = [
  // 1. Atomic Habits (In Progress)
  BookSummary(
    summaryId: 'atomic_habits_01',
    titleFaIr: 'عادت‌های اتمی',
    titleFaAf: 'عادت‌های اتمی',
    titleEnUs: 'Atomic Habits',
    originalAuthor: 'James Clear',
    coverImageUrl: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=600&q=80',
    category: 'Self-Improvement',
    totalReadingMinutes: 4,
    tags: ['Habits', 'Productivity', 'Self-Improvement'],
    progress: 0.65,
    isPickedForYou: true,
    isSavedForLater: true,
    cards: [
      const TakeawayCard(
        cardId: 'ah_card_1',
        summaryId: 'atomic_habits_01',
        cardIndex: 1,
        type: CardType.coreTakeaway,
        contentFaIr: 'تغییرات کوچک ۱ درصدی در طول زمان منجر به نتایج فوق‌العاده و شگفت‌انگیز می‌شوند.',
        contentFaAf: 'تغییرات کوچک ۱ فیصدی در طول زمان باعث نتایج فوق‌العاده و حیرت‌انگیز می‌شوند.',
        contentEnUs: 'Small 1% improvements every day compound into massive long-term results.',
        audioStartMs: 0,
        audioEndMs: 12000,
      ),
      const TakeawayCard(
        cardId: 'ah_card_2',
        summaryId: 'atomic_habits_01',
        cardIndex: 2,
        type: CardType.keyPrinciple,
        contentFaIr: 'شما به سطح اهدافتان صعود نمی‌کنید؛ بلکه به سطح سیستم‌هایتان سقوط می‌کنید.',
        contentFaAf: 'شما به سطح اهداف خویش بلند نمی‌روید؛ بلکه به سطح سیستم‌های خود پایین می‌آیید.',
        contentEnUs: 'You do not rise to the level of your goals. You fall to the level of your systems.',
        audioStartMs: 12000,
        audioEndMs: 25000,
      ),
    ],
  ),

  // 2. Thinking, Fast and Slow (Completed & Saved for Later!)
  BookSummary(
    summaryId: 'thinking_fast_slow_02',
    titleFaIr: 'تفکر، سریع و کند',
    titleFaAf: 'تفکر، شتابان و آرام',
    titleEnUs: 'Thinking, Fast and Slow',
    originalAuthor: 'Daniel Kahneman',
    coverImageUrl: 'https://images.unsplash.com/photo-1507842217343-583bb7270b66?auto=format&fit=crop&w=600&q=80',
    category: 'Psychology',
    totalReadingMinutes: 5,
    tags: ['Psychology', 'Mind', 'Decision Making'],
    progress: 1.0, // COMPLETED
    isPickedForYou: true,
    isSavedForLater: true,
    cards: [
      const TakeawayCard(
        cardId: 'tfs_card_1',
        summaryId: 'thinking_fast_slow_02',
        cardIndex: 1,
        type: CardType.coreTakeaway,
        contentFaIr: 'مغز ما از دو سیستم تصمیم‌گیری استفاده می‌کند: سیستم ۱ سریع و شهودی، سیستم ۲ کند و تحلیلی.',
        contentFaAf: 'مغز ما از دو سیستم تصمیم‌گیری استفاده می‌کند: سیستم ۱ شتابان و حدسی، سیستم ۲ آرام و سنجیده.',
        contentEnUs: 'Our brain operates on two systems: System 1 (fast, intuitive) and System 2 (slow, analytical).',
        audioStartMs: 0,
        audioEndMs: 15000,
      ),
    ],
  ),

  // 3. Deep Work (In Progress)
  BookSummary(
    summaryId: 'deep_work_03',
    titleFaIr: 'کار عمیق',
    titleFaAf: 'کار عمیق',
    titleEnUs: 'Deep Work',
    originalAuthor: 'Cal Newport',
    coverImageUrl: 'https://images.unsplash.com/photo-1499750310107-5fef28a66643?auto=format&fit=crop&w=600&q=80',
    category: 'Productivity',
    totalReadingMinutes: 4,
    tags: ['Productivity', 'Focus', 'Success'],
    progress: 0.25,
    isPickedForYou: true,
    isSavedForLater: true,
    cards: [
      const TakeawayCard(
        cardId: 'dw_card_1',
        summaryId: 'deep_work_03',
        cardIndex: 1,
        type: CardType.coreTakeaway,
        contentFaIr: 'توانایی تمرکز بدون حواس‌پرتی روی یک کار دشوار، مهارت ابرقدرت قرن بیست و یکم است.',
        contentFaAf: 'توانایی تمرکز بدون حواس‌پرتی روی یک کار دشوار، مهارت ابرقدرت قرن بیست و یکم است.',
        contentEnUs: 'Deep work is the ability to focus without distraction on a cognitively demanding task.',
        audioStartMs: 0,
        audioEndMs: 14000,
      ),
    ],
  ),

  // 4. The Psychology of Money (Completed & Saved for Later!)
  BookSummary(
    summaryId: 'psychology_of_money_04',
    titleFaIr: 'روانشناسی پول',
    titleFaAf: 'روانشناسی پول',
    titleEnUs: 'The Psychology of Money',
    originalAuthor: 'Morgan Housel',
    coverImageUrl: 'https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?auto=format&fit=crop&w=600&q=80',
    category: 'Finance',
    totalReadingMinutes: 5,
    tags: ['Finance', 'Wealth', 'Behavior'],
    progress: 1.0, // COMPLETED
    isPickedForYou: true,
    isSavedForLater: true,
    cards: [
      const TakeawayCard(
        cardId: 'pom_card_1',
        summaryId: 'psychology_of_money_04',
        cardIndex: 1,
        type: CardType.coreTakeaway,
        contentFaIr: 'موفقیت مالی ربط چندانی به هوش شما ندارد، بلکه با رفتار و انضباط شما در ارتباط است.',
        contentFaAf: 'موفقیت مالی ارتباط چندانی به هوش شما ندارد، بلکه با رفتار و انضباط شما ارتباط دارد.',
        contentEnUs: 'Doing well with money has a little to do with how smart you are and a lot to do with how you behave.',
        audioStartMs: 0,
        audioEndMs: 16000,
      ),
    ],
  ),

  // 5. Start With Why (In Progress)
  BookSummary(
    summaryId: 'start_with_why_05',
    titleFaIr: 'با چرا شروع کنید',
    titleFaAf: 'با چرا شروع کنید',
    titleEnUs: 'Start With Why',
    originalAuthor: 'Simon Sinek',
    coverImageUrl: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=600&q=80',
    category: 'Leadership',
    totalReadingMinutes: 5,
    tags: ['Leadership', 'Business', 'Motivation'],
    progress: 0.15,
    isPickedForYou: true,
    isSavedForLater: true,
    cards: [
      const TakeawayCard(
        cardId: 'sww_card_1',
        summaryId: 'start_with_why_05',
        cardIndex: 1,
        type: CardType.coreTakeaway,
        contentFaIr: 'مردم آنچه را انجام می‌دهید نمی‌خرند؛ آنها «چرا»یی انجام آن را می‌خرند.',
        contentFaAf: 'مردم آنچه انجام می‌دهید را نمی‌خرند؛ آنها «چرا»ی آن را می‌خرند.',
        contentEnUs: 'People don’t buy what you do; they buy why you do it.',
        audioStartMs: 0,
        audioEndMs: 13000,
      ),
    ],
  ),

  // 6. Sapiens (Saved for Later)
  BookSummary(
    summaryId: 'sapiens_06',
    titleFaIr: 'انسان عاقل (ساپینس)',
    titleFaAf: 'انسان عاقل (ساپینس)',
    titleEnUs: 'Sapiens: A Brief History of Humankind',
    originalAuthor: 'Yuval Noah Harari',
    coverImageUrl: 'https://images.unsplash.com/photo-1461360370896-922624d12aa1?auto=format&fit=crop&w=600&q=80',
    category: 'History',
    totalReadingMinutes: 6,
    tags: ['History', 'Culture', 'Evolution'],
    progress: 0.0,
    isPickedForYou: true,
    isSavedForLater: true,
    cards: [
      const TakeawayCard(
        cardId: 'sap_card_1',
        summaryId: 'sapiens_06',
        cardIndex: 1,
        type: CardType.coreTakeaway,
        contentFaIr: 'توانایی انسان‌ها در همکاری انعطاف‌پذیر در گروه‌های بزرگ، ناشی از تخیل و داستان‌های مشترک است.',
        contentFaAf: 'توانایی انسان‌ها در همکاری انعطاف‌پذیر در گروه‌های بزرگ، ناشی از تخیل و داستان‌های مشترک است.',
        contentEnUs: 'Sapiens rule the world because we are the only animal that can cooperate flexibly in large numbers.',
        audioStartMs: 0,
        audioEndMs: 18000,
      ),
    ],
  ),
];

final List<HighlightItem> sampleHighlights = [
  HighlightItem(
    id: 'hl_1',
    bookSummaryId: 'atomic_habits_01',
    bookTitle: 'عادت‌های اتمی (Atomic Habits)',
    author: 'James Clear',
    cardText: 'شما به سطح اهدافتان صعود نمی‌کنید؛ بلکه به سطح سیستم‌هایتان سقوط می‌کنید.',
    cardType: 'اصل بنیادی',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  HighlightItem(
    id: 'hl_2',
    bookSummaryId: 'thinking_fast_slow_02',
    bookTitle: 'تفکر، سریع و کند (Thinking, Fast and Slow)',
    author: 'Daniel Kahneman',
    cardText: 'مغز ما از دو سیستم تصمیم‌گیری استفاده می‌کند: سیستم ۱ سریع و شهودی، سیستم ۲ کند و تحلیلی.',
    cardType: 'دستآورد اصلی',
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
  ),
  HighlightItem(
    id: 'hl_3',
    bookSummaryId: 'psychology_of_money_04',
    bookTitle: 'روانشناسی پول (The Psychology of Money)',
    author: 'Morgan Housel',
    cardText: 'موفقیت مالی ربط چندانی به هوش شما ندارد، بلکه با رفتار و انضباط شما در ارتباط است.',
    cardType: 'دستآورد اصلی',
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
];
