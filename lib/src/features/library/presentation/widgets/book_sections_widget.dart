import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/i18n/app_locale.dart';
import '../../../../core/i18n/font_resolver.dart';
import '../../domain/entities/book_summary.dart';

class BookSectionsWidget extends StatelessWidget {
  final List<BookSummary> summaries;
  final BookSummary selectedSummary;
  final RoshanaLocale currentLocale;
  final ValueChanged<BookSummary> onBookSelected;

  const BookSectionsWidget({
    super.key,
    required this.summaries,
    required this.selectedSummary,
    required this.currentLocale,
    required this.onBookSelected,
  });

  @override
  Widget build(BuildContext context) {
    final langCode = currentLocale.locale.languageCode;
    final isEn = langCode == 'en';

    // Section 1: Picked for you
    final pickedForYou = summaries.where((b) => b.isPickedForYou).toList();
    // Section 2: Continue Reading (In Progress)
    final inProgress = summaries.where((b) => b.isInProgress).toList();
    // Section 3: Saved for later
    final savedForLater = summaries.where((b) => b.isSavedForLater).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section 1: Picked for you
        if (pickedForYou.isNotEmpty)
          _BookHorizontalSection(
            title: isEn ? 'Picked for you' : 'پیشنهاد شده برای شما',
            subtitle: isEn ? 'Top picks for you' : 'بر اساس علایق شما',
            books: pickedForYou,
            selectedSummary: selectedSummary,
            currentLocale: currentLocale,
            onBookSelected: onBookSelected,
            showProgress: false,
          ),

        // Section 2: Continue Reading (In Progress)
        if (inProgress.isNotEmpty)
          _BookHorizontalSection(
            title: isEn ? 'Continue Reading' : 'ادامه مطالعه',
            subtitle: isEn ? 'In progress' : 'کتاب‌های نیمه‌تمام اخیر',
            books: inProgress,
            selectedSummary: selectedSummary,
            currentLocale: currentLocale,
            onBookSelected: onBookSelected,
            showProgress: true,
          ),

        // Section 3: Saved for later
        if (savedForLater.isNotEmpty)
          _BookHorizontalSection(
            title: isEn ? 'Saved for later' : 'ذخیره‌شده برای بعد',
            subtitle: isEn ? 'Your reading list' : 'فهرست نشان‌شده شما',
            books: savedForLater,
            selectedSummary: selectedSummary,
            currentLocale: currentLocale,
            onBookSelected: onBookSelected,
            showProgress: false,
          ),
      ],
    );
  }
}

class _BookHorizontalSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<BookSummary> books;
  final BookSummary selectedSummary;
  final RoshanaLocale currentLocale;
  final ValueChanged<BookSummary> onBookSelected;
  final bool showProgress;

  const _BookHorizontalSection({
    required this.title,
    required this.subtitle,
    required this.books,
    required this.selectedSummary,
    required this.currentLocale,
    required this.onBookSelected,
    required this.showProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: RoshanaTypography.getTextStyle(
                        currentLocale: currentLocale,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: RoshanaTypography.getTextStyle(
                        currentLocale: currentLocale,
                        fontSize: 11,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
                Icon(
                  currentLocale.direction == TextDirection.rtl
                      ? Icons.arrow_back_ios_new_rounded
                      : Icons.arrow_forward_ios_rounded,
                  size: 13,
                  color: const Color(0xFFF59E0B),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Horizontal Draggable Cover List
          SizedBox(
            height: 155,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                final isSelected = book.summaryId == selectedSummary.summaryId;

                return GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    onBookSelected(book);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 12),
                    width: 105,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? const Color(0xFFF59E0B) : Colors.white12,
                        width: isSelected ? 2.5 : 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isSelected
                              ? const Color(0xFFF59E0B).withValues(alpha: 0.35)
                              : Colors.black.withValues(alpha: 0.4),
                          blurRadius: isSelected ? 14 : 8,
                          spreadRadius: isSelected ? 2 : 0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Cover Image
                          Image.network(
                            book.coverImageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: const Color(0xFF1E293B),
                              child: const Center(
                                child: Icon(Icons.book_rounded, color: Colors.white38, size: 36),
                              ),
                            ),
                          ),

                          // Active Selection Ring
                          if (isSelected)
                            Positioned(
                              top: 6,
                              right: 6,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF59E0B),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.play_arrow_rounded,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),
                            ),

                          // Progress Overlay for Section 2 (Continue Reading)
                          if (showProgress && book.progress > 0.0)
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withValues(alpha: 0.9),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF59E0B),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          '${(book.progress * 100).toInt()}%',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: LinearProgressIndicator(
                                        value: book.progress,
                                        minHeight: 3,
                                        backgroundColor: Colors.white24,
                                        valueColor: const AlwaysStoppedAnimation<Color>(
                                          Color(0xFFF59E0B),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
