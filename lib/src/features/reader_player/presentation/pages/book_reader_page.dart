import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/i18n/app_locale.dart';
import '../../../../core/i18n/font_resolver.dart';
import '../../../library/domain/entities/book_summary.dart';
import '../widgets/card_deck_reader.dart';

class BookReaderPage extends StatelessWidget {
  final BookSummary bookSummary;
  final RoshanaLocale currentLocale;

  const BookReaderPage({
    super.key,
    required this.bookSummary,
    required this.currentLocale,
  });

  @override
  Widget build(BuildContext context) {
    final langCode = currentLocale.locale.languageCode;
    final countryCode = currentLocale.locale.countryCode;
    final title = bookSummary.getLocalizedTitle(langCode, countryCode);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: RoshanaTypography.getTextStyle(
            currentLocale: currentLocale,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            currentLocale.direction == TextDirection.rtl
                ? Icons.arrow_forward_ios_rounded
                : Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border_rounded, color: Color(0xFFF59E0B)),
            onPressed: () {
              HapticFeedback.lightImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    langCode == 'en'
                        ? 'Book saved to your reading list!'
                        : 'کتاب در فهرست ذخیره‌شده‌ها قرار گرفت!',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Micro-Card Stack & Audio narration player
            Expanded(
              child: CardDeckReader(
                bookSummary: bookSummary,
                currentLocale: currentLocale,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
