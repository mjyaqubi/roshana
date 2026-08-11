// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'روشنا';

  @override
  String get appSubtitle => 'خلاصه کتاب‌ها و یادگیری روزانه';

  @override
  String get exploreCatalog => 'کاوش کتاب‌ها';

  @override
  String get dailyStreak => 'زنجیره مطالعه';

  @override
  String streakDays(int count) {
    return '$count روز پیاپی';
  }

  @override
  String get streakFreezeActive => 'یخ‌ساز زنجیره فعال است';

  @override
  String srsReviewDue(int count) {
    return 'یادآوری کارت‌ها ($count)';
  }

  @override
  String get readSummary => 'مطالعه خلاصه';

  @override
  String get listenAudio => 'شنیدن روایت صوتی';

  @override
  String get switchLanguage => 'تغییر زبان';

  @override
  String get persianIran => 'فارسی (ایران)';

  @override
  String get persianAfghan => 'فارسی دری (افغانستان)';

  @override
  String get englishUs => 'English (US)';

  @override
  String get proSubscriber => 'اشتراک ویژه روشنا';

  @override
  String get freeTier => 'نسخه رایگان';

  @override
  String get upgradeToPro => 'ارتقا به نسخه ویژه';

  @override
  String takeawayCard(int current, int total) {
    return 'نکته کلیدی $current از $total';
  }

  @override
  String get keyPrinciple => 'اصل بنیادی';

  @override
  String get actionableInsight => 'راهکار عملی';

  @override
  String get coreTakeaway => 'دستآورد اصلی';
}

/// The translations for Persian, as used in Afghanistan (`fa_AF`).
class AppLocalizationsFaAf extends AppLocalizationsFa {
  AppLocalizationsFaAf() : super('fa_AF');

  @override
  String get appTitle => 'روشنا';

  @override
  String get appSubtitle => 'خلاصه کتاب‌ها و آموختن روزانه';

  @override
  String get exploreCatalog => 'جستجوی کتاب‌ها';

  @override
  String get dailyStreak => 'زنجیره مطالعه';

  @override
  String streakDays(int count) {
    return '$count روز پیاپی';
  }

  @override
  String get streakFreezeActive => 'حفاظت زنجیره فعال است';

  @override
  String srsReviewDue(int count) {
    return 'مرور کارت‌ها ($count)';
  }

  @override
  String get readSummary => 'خواندن خلاصه';

  @override
  String get listenAudio => 'شنیدن صدای خلاصه';

  @override
  String get switchLanguage => 'تغییر زبان';

  @override
  String get persianIran => 'فارسی (ایران)';

  @override
  String get persianAfghan => 'فارسی دری (افغانستان)';

  @override
  String get englishUs => 'English (US)';

  @override
  String get proSubscriber => 'اشتراک ویژه روشنا';

  @override
  String get freeTier => 'نسخه رایگان';

  @override
  String get upgradeToPro => 'ارتقا به نسخه ویژه';

  @override
  String takeawayCard(int current, int total) {
    return 'نکته مهم $current از $total';
  }

  @override
  String get keyPrinciple => 'اصل اساسی';

  @override
  String get actionableInsight => 'رهنمود عملی';

  @override
  String get coreTakeaway => 'آموزه اصلی';
}

/// The translations for Persian, as used in Islamic Republic of Iran (`fa_IR`).
class AppLocalizationsFaIr extends AppLocalizationsFa {
  AppLocalizationsFaIr() : super('fa_IR');

  @override
  String get appTitle => 'روشنا';

  @override
  String get appSubtitle => 'خلاصه کتاب‌ها و یادگیری روزانه';

  @override
  String get exploreCatalog => 'کاوش کتاب‌ها';

  @override
  String get dailyStreak => 'زنجیره مطالعه';

  @override
  String streakDays(int count) {
    return '$count روز پیاپی';
  }

  @override
  String get streakFreezeActive => 'یخ‌ساز زنجیره فعال است';

  @override
  String srsReviewDue(int count) {
    return 'یادآوری کارت‌ها ($count)';
  }

  @override
  String get readSummary => 'مطالعه خلاصه';

  @override
  String get listenAudio => 'شنیدن روایت صوتی';

  @override
  String get switchLanguage => 'تغییر زبان';

  @override
  String get persianIran => 'فارسی (ایران)';

  @override
  String get persianAfghan => 'فارسی دری (افغانستان)';

  @override
  String get englishUs => 'English (US)';

  @override
  String get proSubscriber => 'اشتراک ویژه روشنا';

  @override
  String get freeTier => 'نسخه رایگان';

  @override
  String get upgradeToPro => 'ارتقا به نسخه ویژه';

  @override
  String takeawayCard(int current, int total) {
    return 'نکته کلیدی $current از $total';
  }

  @override
  String get keyPrinciple => 'اصل بنیادی';

  @override
  String get actionableInsight => 'راهکار عملی';

  @override
  String get coreTakeaway => 'دستآورد اصلی';
}
