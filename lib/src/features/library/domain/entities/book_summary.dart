import '../../../reader_player/domain/entities/takeaway_card.dart';

class BookSummary {
  final String summaryId;
  final String titleFaIr;
  final String titleFaAf;
  final String titleEnUs;
  final String originalAuthor;
  final String coverImageUrl;
  final String category;
  final int totalReadingMinutes;
  final List<String> tags;
  final List<TakeawayCard> cards;
  final double progress; // 0.0 to 1.0 (e.g. 1.0 = 100% completed)
  final bool isPickedForYou;
  final bool isSavedForLater;

  // Overview & Author metadata
  final String highLevelSummaryFaIr;
  final String highLevelSummaryFaAf;
  final String highLevelSummaryEnUs;
  final List<String> whatYouWillLearnFaIr;
  final List<String> whatYouWillLearnFaAf;
  final List<String> whatYouWillLearnEnUs;
  final String aboutAuthorFaIr;
  final String aboutAuthorFaAf;
  final String aboutAuthorEnUs;

  const BookSummary({
    required this.summaryId,
    required this.titleFaIr,
    required this.titleFaAf,
    required this.titleEnUs,
    required this.originalAuthor,
    required this.coverImageUrl,
    required this.category,
    required this.totalReadingMinutes,
    required this.tags,
    required this.cards,
    this.progress = 0.0,
    this.isPickedForYou = false,
    this.isSavedForLater = false,
    this.highLevelSummaryFaIr = '',
    this.highLevelSummaryFaAf = '',
    this.highLevelSummaryEnUs = '',
    this.whatYouWillLearnFaIr = const [],
    this.whatYouWillLearnFaAf = const [],
    this.whatYouWillLearnEnUs = const [],
    this.aboutAuthorFaIr = '',
    this.aboutAuthorFaAf = '',
    this.aboutAuthorEnUs = '',
  });

  bool get isInProgress => progress > 0.0 && progress < 1.0;
  bool get isCompleted => progress >= 1.0;

  String getLocalizedTitle(String languageCode, String? countryCode) {
    if (languageCode == 'en') return titleEnUs;
    if (languageCode == 'fa' && countryCode == 'AF') return titleFaAf;
    return titleFaIr;
  }

  String getLocalizedHighLevelSummary(String languageCode, String? countryCode) {
    if (languageCode == 'en') return highLevelSummaryEnUs;
    if (languageCode == 'fa' && countryCode == 'AF') return highLevelSummaryFaAf;
    return highLevelSummaryFaIr;
  }

  List<String> getLocalizedWhatYouWillLearn(String languageCode, String? countryCode) {
    if (languageCode == 'en') return whatYouWillLearnEnUs;
    if (languageCode == 'fa' && countryCode == 'AF') return whatYouWillLearnFaAf;
    return whatYouWillLearnFaIr;
  }

  String getLocalizedAboutAuthor(String languageCode, String? countryCode) {
    if (languageCode == 'en') return aboutAuthorEnUs;
    if (languageCode == 'fa' && countryCode == 'AF') return aboutAuthorFaAf;
    return aboutAuthorFaIr;
  }
}
