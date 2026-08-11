import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../core/i18n/app_locale.dart';
import '../core/i18n/font_resolver.dart';
import '../core/i18n/locale_notifier.dart';
import '../core/theme/app_theme.dart';
import '../features/gamification/presentation/widgets/streak_header_widget.dart';
import '../features/library/data/mock_book_summaries.dart';
import '../features/library/domain/entities/book_summary.dart';
import '../features/library/presentation/notifiers/category_notifier.dart';
import '../features/library/presentation/widgets/book_sections_widget.dart';
import '../features/reader_player/presentation/widgets/card_deck_reader.dart';

class RoshanaApp extends StatelessWidget {
  const RoshanaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleNotifier()),
        ChangeNotifierProvider(create: (_) => CategoryNotifier()),
      ],
      child: Consumer<LocaleNotifier>(
        builder: (context, localeNotifier, child) {
          final roshanaLocale = localeNotifier.roshanaLocale;

          return MaterialApp(
            title: 'Roshana',
            debugShowCheckedModeBanner: false,
            locale: localeNotifier.currentLocale,
            supportedLocales: const [
              Locale('fa', 'IR'),
              Locale('fa', 'AF'),
              Locale('fa'),
              Locale('en', 'US'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: RoshanaTheme.getDarkTheme(roshanaLocale),
            builder: (context, child) {
              return Directionality(
                textDirection: roshanaLocale.direction,
                child: child ?? const SizedBox.shrink(),
              );
            },
            home: RoshanaHomeScreen(roshanaLocale: roshanaLocale),
          );
        },
      ),
    );
  }
}

class RoshanaHomeScreen extends StatefulWidget {
  final RoshanaLocale roshanaLocale;

  const RoshanaHomeScreen({super.key, required this.roshanaLocale});

  @override
  State<RoshanaHomeScreen> createState() => _RoshanaHomeScreenState();
}

class _RoshanaHomeScreenState extends State<RoshanaHomeScreen> {
  late BookSummary _selectedSummary;
  int _selectedNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedSummary = sampleBookSummaries[0];
  }

  @override
  Widget build(BuildContext context) {
    final localeNotifier = Provider.of<LocaleNotifier>(context, listen: false);
    final langCode = widget.roshanaLocale.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.auto_stories_rounded, color: Color(0xFFF59E0B)),
            const SizedBox(width: 8),
            Text(
              'روشنا',
              style: RoshanaTypography.getTextStyle(
                currentLocale: widget.roshanaLocale,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF59E0B),
              ),
            ),
          ],
        ),
        actions: [
          // Language Switcher Dropdown
          PopupMenuButton<RoshanaLocale>(
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                children: [
                  const Icon(Icons.language_rounded, size: 16, color: Colors.white70),
                  const SizedBox(width: 4),
                  Text(
                    widget.roshanaLocale.label.split(' ')[0],
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
            onSelected: (newLocale) {
              localeNotifier.setLocale(newLocale);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: RoshanaLocale.faIR,
                child: Row(
                  children: [
                    Text(
                      '🇮🇷  فارسی (ایران)',
                      style: RoshanaTypography.getTextStyle(
                        currentLocale: RoshanaLocale.faIR,
                        fontSize: 14,
                      ),
                    ),
                    if (widget.roshanaLocale == RoshanaLocale.faIR) ...[
                      const Spacer(),
                      const Icon(Icons.check_rounded, color: Color(0xFFF59E0B), size: 18),
                    ],
                  ],
                ),
              ),
              PopupMenuItem(
                value: RoshanaLocale.faAF,
                child: Row(
                  children: [
                    Text(
                      '🇦🇫  فارسی دری (افغانستان)',
                      style: RoshanaTypography.getTextStyle(
                        currentLocale: RoshanaLocale.faAF,
                        fontSize: 14,
                      ),
                    ),
                    if (widget.roshanaLocale == RoshanaLocale.faAF) ...[
                      const Spacer(),
                      const Icon(Icons.check_rounded, color: Color(0xFFF59E0B), size: 18),
                    ],
                  ],
                ),
              ),
              PopupMenuItem(
                value: RoshanaLocale.enUS,
                child: Row(
                  children: [
                    Text(
                      '🇺🇸  English (US)',
                      style: RoshanaTypography.getTextStyle(
                        currentLocale: RoshanaLocale.enUS,
                        fontSize: 14,
                      ),
                    ),
                    if (widget.roshanaLocale == RoshanaLocale.enUS) ...[
                      const Spacer(),
                      const Icon(Icons.check_rounded, color: Color(0xFFF59E0B), size: 18),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Streak Component
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: StreakHeaderWidget(
                  streakDays: 7,
                  hasStreakFreeze: true,
                  currentLocale: widget.roshanaLocale,
                ),
              ),

              // 4 Draggable Book Cover Sections (Picked for You, Continue Reading, Category Picks, Saved for Later)
              BookSectionsWidget(
                summaries: sampleBookSummaries,
                selectedSummary: _selectedSummary,
                currentLocale: widget.roshanaLocale,
                onBookSelected: (summary) {
                  setState(() {
                    _selectedSummary = summary;
                  });
                },
              ),

              const Divider(color: Colors.white12, indent: 20, endIndent: 20),
              const SizedBox(height: 8),

              // Card Deck Reader Interface for Selected Book
              SizedBox(
                height: 520,
                child: CardDeckReader(
                  key: ValueKey(_selectedSummary.summaryId),
                  bookSummary: _selectedSummary,
                  currentLocale: widget.roshanaLocale,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedNavIndex,
        onTap: (idx) {
          setState(() {
            _selectedNavIndex = idx;
          });
        },
        backgroundColor: const Color(0xFF0F172A),
        selectedItemColor: const Color(0xFFF59E0B),
        unselectedItemColor: Colors.white38,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.style_outlined),
            activeIcon: const Icon(Icons.style_rounded),
            label: langCode == 'en' ? 'Reader' : 'خلاصه',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.auto_stories_outlined),
            activeIcon: const Icon(Icons.auto_stories_rounded),
            label: langCode == 'en' ? 'Library' : 'کتابخانه',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.psychology_outlined),
            activeIcon: const Icon(Icons.psychology_rounded),
            label: langCode == 'en' ? 'Flashcards' : 'مرور',
          ),
        ],
      ),
    );
  }
}
