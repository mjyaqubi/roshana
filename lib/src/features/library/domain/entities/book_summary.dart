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
  final double progress; // 0.0 to 1.0 (e.g. 0.65 = 65% read/listened)
  final bool isPickedForYou;
  final bool isSavedForLater;

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
  });

  bool get isInProgress => progress > 0.0 && progress < 1.0;

  String getLocalizedTitle(String languageCode, String? countryCode) {
    if (languageCode == 'en') return titleEnUs;
    if (languageCode == 'fa' && countryCode == 'AF') return titleFaAf;
    return titleFaIr;
  }
}
