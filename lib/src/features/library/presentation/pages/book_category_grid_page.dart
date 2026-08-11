import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/i18n/app_locale.dart';
import '../../../../core/i18n/font_resolver.dart';
import '../../../reader_player/presentation/pages/book_reader_page.dart';
import '../../domain/entities/book_summary.dart';

class BookCategoryGridPage extends StatefulWidget {
  final String sectionTitle;
  final List<BookSummary> initialBooks;
  final RoshanaLocale currentLocale;

  const BookCategoryGridPage({
    super.key,
    required this.sectionTitle,
    required this.initialBooks,
    required this.currentLocale,
  });

  @override
  State<BookCategoryGridPage> createState() => _BookCategoryGridPageState();
}

class _BookCategoryGridPageState extends State<BookCategoryGridPage> {
  final ScrollController _scrollController = ScrollController();
  late List<BookSummary> _displayedBooks;
  bool _isLoadingMore = false;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _displayedBooks = List.from(widget.initialBooks);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore) {
      _loadMoreBooks();
    }
  }

  Future<void> _loadMoreBooks() async {
    setState(() {
      _isLoadingMore = true;
    });

    // Simulate network / database pagination loading delay
    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      setState(() {
        _page++;
        // Duplicate items with unique keys to simulate paginated infinite scroll
        final nextBatch = widget.initialBooks.map((book) {
          return BookSummary(
            summaryId: '${book.summaryId}_page_$_page',
            titleFaIr: book.titleFaIr,
            titleFaAf: book.titleFaAf,
            titleEnUs: book.titleEnUs,
            originalAuthor: book.originalAuthor,
            coverImageUrl: book.coverImageUrl,
            category: book.category,
            totalReadingMinutes: book.totalReadingMinutes,
            tags: book.tags,
            cards: book.cards,
            progress: book.progress,
            isPickedForYou: book.isPickedForYou,
            isSavedForLater: book.isSavedForLater,
          );
        }).toList();

        _displayedBooks.addAll(nextBatch);
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final langCode = widget.currentLocale.locale.languageCode;
    final countryCode = widget.currentLocale.locale.countryCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.sectionTitle,
          style: RoshanaTypography.getTextStyle(
            currentLocale: widget.currentLocale,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            widget.currentLocale.direction == TextDirection.rtl
                ? Icons.arrow_forward_ios_rounded
                : Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.62, // Larger tall book covers
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 16,
                ),
                itemCount: _displayedBooks.length,
                itemBuilder: (context, index) {
                  final book = _displayedBooks[index];
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
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Large Cover Image
                          Expanded(
                            flex: 4,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    book.coverImageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: const Color(0xFF0F172A),
                                      child: const Center(
                                        child: Icon(Icons.book_rounded, color: Colors.white38, size: 40),
                                      ),
                                    ),
                                  ),
                                  if (book.progress > 0.0)
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF59E0B),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          '${(book.progress * 100).toInt()}%',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),

                          // Book Info underneath
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: RoshanaTypography.getTextStyle(
                                      currentLocale: widget.currentLocale,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    book.originalAuthor,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: RoshanaTypography.getTextStyle(
                                      currentLocale: widget.currentLocale,
                                      fontSize: 11,
                                      color: Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Pagination loading spinner at bottom
            if (_isLoadingMore)
              Container(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF59E0B)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      langCode == 'en' ? 'Loading more books...' : 'در حال بارگذاری کتاب‌های بیشتر...',
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
