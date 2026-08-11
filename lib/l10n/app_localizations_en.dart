// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Roshana';

  @override
  String get appSubtitle => 'Micro-Learning & Book Summaries';

  @override
  String get exploreCatalog => 'Explore Library';

  @override
  String get dailyStreak => 'Daily Streak';

  @override
  String streakDays(int count) {
    return '$count Day Streak';
  }

  @override
  String get streakFreezeActive => 'Streak Freeze Active';

  @override
  String srsReviewDue(int count) {
    return 'Flashcards Due ($count)';
  }

  @override
  String get readSummary => 'Read Summary';

  @override
  String get listenAudio => 'Listen Audio';

  @override
  String get switchLanguage => 'Switch Language';

  @override
  String get persianIran => 'Persian (Iran)';

  @override
  String get persianAfghan => 'Persian (Dari - Afghanistan)';

  @override
  String get englishUs => 'English (US)';

  @override
  String get proSubscriber => 'Roshana Pro Member';

  @override
  String get freeTier => 'Free Tier';

  @override
  String get upgradeToPro => 'Upgrade to Pro';

  @override
  String takeawayCard(int current, int total) {
    return 'Takeaway $current of $total';
  }

  @override
  String get keyPrinciple => 'Key Principle';

  @override
  String get actionableInsight => 'Actionable Insight';

  @override
  String get coreTakeaway => 'Core Takeaway';
}
