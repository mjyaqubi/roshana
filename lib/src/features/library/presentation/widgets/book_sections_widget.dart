import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../core/i18n/app_locale.dart';
import '../../../../core/i18n/font_resolver.dart';
import '../../../reader_player/presentation/pages/book_reader_page.dart';
import '../../domain/entities/book_summary.dart';
import '../../domain/entities/category_item.dart';
import '../notifiers/category_notifier.dart';
import '../pages/category_selection_page.dart';

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
    final categoryNotifier = Provider.of<CategoryNotifier>(context);
    final selectedCategories = categoryNotifier.categories.where((c) => c.isSelected).toList();

    // Section 1: Picked for you
    final pickedForYou = summaries.where((b) => b.isPickedForYou).toList();
    // Section 2: Continue Reading (In Progress)
    final inProgress = summaries.where((b) => b.isInProgress).toList();
    // Section 4: Saved for later
    final savedForLater = summaries.where((b) => b.isSavedForLater).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section 1: Picked for you
        if (pickedForYou.isNotEmpty)
          _BookHorizontalSection(
            title: isEn ? 'Picked for you' : 'پیشنهاد شده برای شما',
            subtitle: isEn ? 'Top picks based on your interests' : 'بر اساس برترین‌های مورد علاقه شما',
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
            subtitle: isEn ? 'Recent books in progress' : 'کتاب‌های نیمه‌تمام اخیر شما',
            books: inProgress,
            selectedSummary: selectedSummary,
            currentLocale: currentLocale,
            onBookSelected: onBookSelected,
            showProgress: true,
          ),

        // Section 3: Categories You're Interested In (Boxes with Icon & Name)
        _CategoryBoxSection(
          title: isEn ? "Categories You're Interested In" : "دسته‌بندی‌های مورد علاقه شما",
          subtitle: isEn
              ? '${selectedCategories.length} topics selected'
              : '${selectedCategories.length} موضوع فعال',
          selectedCategories: selectedCategories,
          currentLocale: currentLocale,
        ),

        // Section 4: Saved for later
        if (savedForLater.isNotEmpty)
          _BookHorizontalSection(
            title: isEn ? 'Saved for later' : 'ذخیره‌شده برای بعد',
            subtitle: isEn ? 'Your bookmarked library' : 'فهرست نشان‌شده شما',
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

/// Horizontal Category Box Slider (Displays Icon + Category Name in a box)
class _CategoryBoxSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<CategoryItem> selectedCategories;
  final RoshanaLocale currentLocale;

  const _CategoryBoxSection({
    required this.title,
    required this.subtitle,
    required this.selectedCategories,
    required this.currentLocale,
  });

  @override
  Widget build(BuildContext context) {
    final langCode = currentLocale.locale.languageCode;
    final isEn = langCode == 'en';

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Edit Button
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
                GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CategorySelectionPage(currentLocale: currentLocale),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.tune_rounded, size: 14, color: Color(0xFFF59E0B)),
                        const SizedBox(width: 4),
                        Text(
                          isEn ? 'Edit' : 'تغییر',
                          style: RoshanaTypography.getTextStyle(
                            currentLocale: currentLocale,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFF59E0B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Draggable Horizontal List of Category Boxes
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: selectedCategories.isEmpty ? 1 : selectedCategories.length,
              itemBuilder: (context, index) {
                if (selectedCategories.isEmpty) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CategorySelectionPage(currentLocale: currentLocale),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.add_circle_outline_rounded, color: Color(0xFFF59E0B)),
                          const SizedBox(width: 8),
                          Text(
                            isEn ? 'Select Categories' : 'انتخاب دسته‌بندی‌ها',
                            style: const TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final category = selectedCategories[index];

                return GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CategorySelectionPage(currentLocale: currentLocale),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF1E293B),
                          const Color(0xFF0F172A).withValues(alpha: 0.9),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFF59E0B).withValues(alpha: 0.3),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            category.icon,
                            color: const Color(0xFFF59E0B),
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          category.getLocalizedName(langCode),
                          style: RoshanaTypography.getTextStyle(
                            currentLocale: currentLocale,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
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

/// Horizontal Book Cover Slider
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BookReaderPage(
                          bookSummary: book,
                          currentLocale: currentLocale,
                        ),
                      ),
                    );
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
