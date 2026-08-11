class HighlightItem {
  final String id;
  final String bookSummaryId;
  final String bookTitle;
  final String author;
  final String cardText;
  final String cardType;
  final DateTime createdAt;

  const HighlightItem({
    required this.id,
    required this.bookSummaryId,
    required this.bookTitle,
    required this.author,
    required this.cardText,
    required this.cardType,
    required this.createdAt,
  });
}
