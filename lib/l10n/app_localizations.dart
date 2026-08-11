import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa'),
    Locale('fa', 'AF'),
    Locale('fa', 'IR'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In fa_IR, this message translates to:
  /// **'روشنا'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In fa_IR, this message translates to:
  /// **'خلاصه کتاب‌ها و یادگیری روزانه'**
  String get appSubtitle;

  /// No description provided for @exploreCatalog.
  ///
  /// In fa_IR, this message translates to:
  /// **'کاوش کتاب‌ها'**
  String get exploreCatalog;

  /// No description provided for @dailyStreak.
  ///
  /// In fa_IR, this message translates to:
  /// **'زنجیره مطالعه'**
  String get dailyStreak;

  /// No description provided for @streakDays.
  ///
  /// In fa_IR, this message translates to:
  /// **'{count} روز پیاپی'**
  String streakDays(int count);

  /// No description provided for @streakFreezeActive.
  ///
  /// In fa_IR, this message translates to:
  /// **'یخ‌ساز زنجیره فعال است'**
  String get streakFreezeActive;

  /// No description provided for @srsReviewDue.
  ///
  /// In fa_IR, this message translates to:
  /// **'یادآوری کارت‌ها ({count})'**
  String srsReviewDue(int count);

  /// No description provided for @readSummary.
  ///
  /// In fa_IR, this message translates to:
  /// **'مطالعه خلاصه'**
  String get readSummary;

  /// No description provided for @listenAudio.
  ///
  /// In fa_IR, this message translates to:
  /// **'شنیدن روایت صوتی'**
  String get listenAudio;

  /// No description provided for @switchLanguage.
  ///
  /// In fa_IR, this message translates to:
  /// **'تغییر زبان'**
  String get switchLanguage;

  /// No description provided for @persianIran.
  ///
  /// In fa_IR, this message translates to:
  /// **'فارسی (ایران)'**
  String get persianIran;

  /// No description provided for @persianAfghan.
  ///
  /// In fa_IR, this message translates to:
  /// **'فارسی دری (افغانستان)'**
  String get persianAfghan;

  /// No description provided for @englishUs.
  ///
  /// In fa_IR, this message translates to:
  /// **'English (US)'**
  String get englishUs;

  /// No description provided for @proSubscriber.
  ///
  /// In fa_IR, this message translates to:
  /// **'اشتراک ویژه روشنا'**
  String get proSubscriber;

  /// No description provided for @freeTier.
  ///
  /// In fa_IR, this message translates to:
  /// **'نسخه رایگان'**
  String get freeTier;

  /// No description provided for @upgradeToPro.
  ///
  /// In fa_IR, this message translates to:
  /// **'ارتقا به نسخه ویژه'**
  String get upgradeToPro;

  /// No description provided for @takeawayCard.
  ///
  /// In fa_IR, this message translates to:
  /// **'نکته کلیدی {current} از {total}'**
  String takeawayCard(int current, int total);

  /// No description provided for @keyPrinciple.
  ///
  /// In fa_IR, this message translates to:
  /// **'اصل بنیادی'**
  String get keyPrinciple;

  /// No description provided for @actionableInsight.
  ///
  /// In fa_IR, this message translates to:
  /// **'راهکار عملی'**
  String get actionableInsight;

  /// No description provided for @coreTakeaway.
  ///
  /// In fa_IR, this message translates to:
  /// **'دستآورد اصلی'**
  String get coreTakeaway;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'fa':
      {
        switch (locale.countryCode) {
          case 'AF':
            return AppLocalizationsFaAf();
          case 'IR':
            return AppLocalizationsFaIr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
