import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/i18n/app_locale.dart';
import '../../../../core/i18n/font_resolver.dart';
import '../../../reader_player/presentation/pages/book_reader_page.dart';
import '../../data/mock_book_summaries.dart';
import '../../domain/entities/book_summary.dart';

class LibraryPage extends StatefulWidget {
  final RoshanaLocale currentLocale;

  const LibraryPage({
    super.key,
    required this.currentLocale,
  });

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langCode = widget.currentLocale.locale.languageCode;
    final countryCode = widget.currentLocale.locale.countryCode;
    final isEn = langCode == 'en';

    final savedBooks = sampleBookSummaries.where((b) => b.isSavedForLater).toList();
    final completedBooks = sampleBookSummaries.where((b) => b.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEn ? 'Your Library' : 'کتابخانه شما',
          style: RoshanaTypography.getTextStyle(
            currentLocale: widget.currentLocale,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFF59E0B),
          labelColor: const Color(0xFFF59E0B),
          unselectedLabelColor: Colors.white54,
          labelStyle: RoshanaTypography.getTextStyle(
            currentLocale: widget.currentLocale,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
          tabs: [
            Tab(text: isEn ? 'Saved For Later' : 'ذخیره‌شده‌ها'),
            Tab(text: isEn ? 'Completed (${completedBooks.length})' : 'تکمیل‌شده‌ها (${completedBooks.length})'),
            Tab(text: isEn ? 'Highlights (${sampleHighlights.length})' : 'هایلایت‌ها (${sampleHighlights.length})'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            // Tab 1: Saved for Later Items (Marked with Completion status)
            _buildSavedForLaterList(savedBooks, langCode, countryCode, isEn),

            // Tab 2: Completed Books List
            _buildCompletedBooksList(completedBooks, langCode, countryCode, isEn),

            // Tab 3: Customer Book Highlights Tab
            _buildHighlightsList(isEn),
          ],
        ),
      ),
    );
  }

  /// Tab 1: Saved for Later List
  Widget _buildSavedForLaterList(
    List<BookSummary> savedBooks,
    String langCode,
    String? countryCode,
    bool isEn,
  ) {
    if (savedBooks.isEmpty) {
      return Center(
        child: Text(
          isEn ? 'No saved books yet.' : 'هنوز کتابی ذخیره نکرده‌اید.',
          style: const TextStyle(color: Colors.white54),
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: savedBooks.length,
      itemBuilder: (context, index) {
        final book = savedBooks[index];
        final title = book.getLocalizedTitle(langCode, countryCode);
        final isCompleted = book.isCompleted;

        return GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BookReaderPage(
                  bookSummary: book,
                  currentLocale: widget.currentLocale,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isCompleted
                    ? const Color(0xFF10B981).withValues(alpha: 0.5)
                    : Colors.white12,
              ),
            ),
            child: Row(
              children: [
                // Book Cover
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    book.coverImageUrl,
                    width: 70,
                    height: 95,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 70,
                      height: 95,
                      color: const Color(0xFF0F172A),
                      child: const Icon(Icons.book_rounded, color: Colors.white38),
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Details & Status Badge
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: RoshanaTypography.getTextStyle(
                          currentLocale: widget.currentLocale,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book.originalAuthor,
                        style: RoshanaTypography.getTextStyle(
                          currentLocale: widget.currentLocale,
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Completion Status Marker
                      Row(
                        children: [
                          if (isCompleted) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFF10B981)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    isEn ? 'Completed' : 'تکمیل‌شده',
                                    style: const TextStyle(
                                      color: Color(0xFF10B981),
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ] else if (book.progress > 0.0) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFFF59E0B)),
                              ),
                              child: Text(
                                isEn
                                    ? 'In Progress (${(book.progress * 100).toInt()}%)'
                                    : 'در حال مطالعه (${(book.progress * 100).toInt()}٪)',
                                style: const TextStyle(
                                  color: Color(0xFFF59E0B),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ] else ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                isEn ? 'Not Started' : 'شروع نشده',
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.white38),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Tab 2: Completed Books List
  Widget _buildCompletedBooksList(
    List<BookSummary> completedBooks,
    String langCode,
    String? countryCode,
    bool isEn,
  ) {
    if (completedBooks.isEmpty) {
      return Center(
        child: Text(
          isEn ? 'No completed books yet.' : 'هنوز کتابی را به پایان نرسانده‌اید.',
          style: const TextStyle(color: Colors.white54),
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: completedBooks.length,
      itemBuilder: (context, index) {
        final book = completedBooks[index];
        final title = book.getLocalizedTitle(langCode, countryCode);

        return GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BookReaderPage(
                  bookSummary: book,
                  currentLocale: widget.currentLocale,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    book.coverImageUrl,
                    width: 70,
                    height: 95,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: RoshanaTypography.getTextStyle(
                          currentLocale: widget.currentLocale,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book.originalAuthor,
                        style: RoshanaTypography.getTextStyle(
                          currentLocale: widget.currentLocale,
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.verified_rounded, color: Color(0xFF10B981), size: 16),
                          const SizedBox(width: 6),
                          Text(
                            isEn ? '100% Completed' : '۱۰۰٪ تکمیل شده',
                            style: const TextStyle(
                              color: Color(0xFF10B981),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.replay_rounded, color: Color(0xFFF59E0B)),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BookReaderPage(
                          bookSummary: book,
                          currentLocale: widget.currentLocale,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Tab 3: Customer Highlights List
  Widget _buildHighlightsList(bool isEn) {
    if (sampleHighlights.isEmpty) {
      return Center(
        child: Text(
          isEn ? 'No book highlights saved.' : 'هنوز هایلایتی ذخیره نشده است.',
          style: const TextStyle(color: Colors.white54),
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: sampleHighlights.length,
      itemBuilder: (context, index) {
        final highlight = sampleHighlights[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Title & Tag Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      highlight.bookTitle,
                      style: RoshanaTypography.getTextStyle(
                        currentLocale: widget.currentLocale,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      highlight.cardType,
                      style: const TextStyle(color: Colors.white70, fontSize: 10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Highlight Quote Card Text
              Text(
                '«${highlight.cardText}»',
                style: RoshanaTypography.getTextStyle(
                  currentLocale: widget.currentLocale,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    highlight.author,
                    style: const TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy_rounded, color: Colors.white54, size: 18),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: highlight.cardText));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isEn ? 'Highlight copied to clipboard!' : 'هایلایت کپی شد!'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
