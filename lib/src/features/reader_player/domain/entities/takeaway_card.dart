enum CardType { coreTakeaway, keyPrinciple, actionableInsight }

class TakeawayCard {
  final String cardId;
  final String summaryId;
  final int cardIndex;
  final CardType type;
  final String contentFaIr;
  final String contentFaAf;
  final String contentEnUs;
  final int audioStartMs;
  final int audioEndMs;

  const TakeawayCard({
    required this.cardId,
    required this.summaryId,
    required this.cardIndex,
    required this.type,
    required this.contentFaIr,
    required this.contentFaAf,
    required this.contentEnUs,
    required this.audioStartMs,
    required this.audioEndMs,
  });

  String getLocalizedContent(String languageCode, String? countryCode) {
    if (languageCode == 'en') return contentEnUs;
    if (languageCode == 'fa' && countryCode == 'AF') return contentFaAf;
    return contentFaIr;
  }
}
