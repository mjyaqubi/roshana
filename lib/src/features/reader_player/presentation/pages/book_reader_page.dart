import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/i18n/app_locale.dart';
import '../../../../core/i18n/font_resolver.dart';
import '../../../library/domain/entities/book_summary.dart';
import '../widgets/card_deck_reader.dart';

class BookReaderPage extends StatefulWidget {
  final BookSummary bookSummary;
  final RoshanaLocale currentLocale;

  const BookReaderPage({
    super.key,
    required this.bookSummary,
    required this.currentLocale,
  });

  @override
  State<BookReaderPage> createState() => _BookReaderPageState();
}

class _BookReaderPageState extends State<BookReaderPage> {
  bool _isPlaying = false;
  double _playbackSpeed = 1.0;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.bookSummary.isSavedForLater;
  }

  void _togglePlayPause() {
    HapticFeedback.selectionClick();
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _cycleSpeed() {
    HapticFeedback.selectionClick();
    setState(() {
      if (_playbackSpeed == 1.0) {
        _playbackSpeed = 1.25;
      } else if (_playbackSpeed == 1.25) {
        _playbackSpeed = 1.5;
      } else if (_playbackSpeed == 1.5) {
        _playbackSpeed = 2.0;
      } else {
        _playbackSpeed = 1.0;
      }
    });
  }

  void _openFullReadingMode({int initialCardIndex = 0}) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.88,
        child: Column(
          children: [
            // Sheet handle
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 6),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Expanded(
              child: CardDeckReader(
                bookSummary: widget.bookSummary,
                currentLocale: widget.currentLocale,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final langCode = widget.currentLocale.locale.languageCode;
    final countryCode = widget.currentLocale.locale.countryCode;
    final isEn = langCode == 'en';
    final book = widget.bookSummary;

    final title = book.getLocalizedTitle(langCode, countryCode);
    final highLevelSummary = book.getLocalizedHighLevelSummary(langCode, countryCode);
    final whatYouWillLearn = book.getLocalizedWhatYouWillLearn(langCode, countryCode);
    final aboutAuthor = book.getLocalizedAboutAuthor(langCode, countryCode);
    final cards = book.cards;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: RoshanaTypography.getTextStyle(
            currentLocale: widget.currentLocale,
            fontSize: 16,
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
        actions: [
          IconButton(
            icon: Icon(
              _isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              color: const Color(0xFFF59E0B),
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              setState(() {
                _isSaved = !_isSaved;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isSaved
                        ? (isEn ? 'Book saved for later!' : 'کتاب در لیست ذخیره گردید!')
                        : (isEn ? 'Book removed from saved list' : 'کتاب از ذخیره‌ها حذف گردید'),
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          // Scrollable Book Overview Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 1. Book Cover Image (Top)
                  Container(
                    height: 220,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white24, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(
                        book.coverImageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xFF1E293B),
                          child: const Center(
                            child: Icon(Icons.book_rounded, color: Colors.white38, size: 48),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // 2. Book Name
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: RoshanaTypography.getTextStyle(
                      currentLocale: widget.currentLocale,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // 3. Author Name
                  Text(
                    book.originalAuthor,
                    textAlign: TextAlign.center,
                    style: RoshanaTypography.getTextStyle(
                      currentLocale: widget.currentLocale,
                      fontSize: 14,
                      color: Colors.white60,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 4. Key points count & listening duration in ONE line
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.style_rounded, color: Color(0xFFF59E0B), size: 16),
                        const SizedBox(width: 6),
                        Text(
                          isEn ? '${cards.length} Key Points' : '${cards.length} نکته کلیدی',
                          style: RoshanaTypography.getTextStyle(
                            currentLocale: widget.currentLocale,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('•', style: TextStyle(color: Color(0xFFF59E0B), fontSize: 14)),
                        ),
                        const Icon(Icons.headset_rounded, color: Color(0xFF10B981), size: 16),
                        const SizedBox(width: 6),
                        Text(
                          isEn
                              ? '${book.totalReadingMinutes} Min Listen'
                              : '${book.totalReadingMinutes} دقیقه شنیدار',
                          style: RoshanaTypography.getTextStyle(
                            currentLocale: widget.currentLocale,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // 5. High-Level Summary (One Paragraph)
                  if (highLevelSummary.isNotEmpty) ...[
                    Align(
                      alignment: widget.currentLocale.direction == TextDirection.rtl
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Text(
                        isEn ? 'Overview' : 'خلاصه کلی',
                        style: RoshanaTypography.getTextStyle(
                          currentLocale: widget.currentLocale,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFF59E0B),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Text(
                        highLevelSummary,
                        style: RoshanaTypography.getTextStyle(
                          currentLocale: widget.currentLocale,
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                  ],

                  // 6. What You Will Learn List
                  if (whatYouWillLearn.isNotEmpty) ...[
                    Align(
                      alignment: widget.currentLocale.direction == TextDirection.rtl
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Text(
                        isEn ? 'What You Will Learn' : 'آنچه در این کتاب می‌آموزید',
                        style: RoshanaTypography.getTextStyle(
                          currentLocale: widget.currentLocale,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFF59E0B),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Column(
                        children: whatYouWillLearn.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 18),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: RoshanaTypography.getTextStyle(
                                      currentLocale: widget.currentLocale,
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 22),
                  ],

                  // 7. Clickable Key Points Titles (Navigates to exact card position in reading mode!)
                  Align(
                    alignment: widget.currentLocale.direction == TextDirection.rtl
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Text(
                      isEn ? 'Key Takeaways & Principles' : 'نکات و اصول کلیدی کتاب',
                      style: RoshanaTypography.getTextStyle(
                        currentLocale: widget.currentLocale,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: cards.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final card = entry.value;
                      final cardText = card.getLocalizedContent(langCode, countryCode);
                      final cardTitle = isEn
                          ? 'Key Point ${idx + 1}'
                          : 'نکته کلیدی شماره ${idx + 1}';

                      return GestureDetector(
                        onTap: () {
                          _openFullReadingMode(initialCardIndex: idx);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFF59E0B).withValues(alpha: 0.25),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${idx + 1}',
                                    style: const TextStyle(
                                      color: Color(0xFFF59E0B),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cardTitle,
                                      style: RoshanaTypography.getTextStyle(
                                        currentLocale: widget.currentLocale,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFFF59E0B),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      cardText,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: RoshanaTypography.getTextStyle(
                                        currentLocale: widget.currentLocale,
                                        fontSize: 12,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.play_circle_fill_rounded, color: Color(0xFFF59E0B), size: 24),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 22),

                  // 8. About the Author (One Paragraph)
                  if (aboutAuthor.isNotEmpty) ...[
                    Align(
                      alignment: widget.currentLocale.direction == TextDirection.rtl
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Text(
                        isEn ? 'About the Author' : 'درباره نویسنده',
                        style: RoshanaTypography.getTextStyle(
                          currentLocale: widget.currentLocale,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFF59E0B),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Text(
                        aboutAuthor,
                        style: RoshanaTypography.getTextStyle(
                          currentLocale: widget.currentLocale,
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ),

          // 9. Bottom Audio Control Bar + Reading Button before Save Icon
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              border: Border.all(color: Colors.white12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Play / Pause Button
                GestureDetector(
                  onTap: _togglePlayPause,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                      ),
                    ),
                    child: Icon(
                      _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),

                // Speed Cycle Toggle
                GestureDetector(
                  onTap: _cycleSpeed,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_playbackSpeed}x',
                      style: const TextStyle(
                        color: Color(0xFFF59E0B),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // READING BUTTON (Opens full summary text reading mode before save icon!)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF59E0B),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  ),
                  onPressed: () => _openFullReadingMode(initialCardIndex: 0),
                  icon: const Icon(Icons.chrome_reader_mode_rounded, size: 18),
                  label: Text(
                    isEn ? 'Read Summary' : 'مطالعه خلاصه',
                    style: RoshanaTypography.getTextStyle(
                      currentLocale: widget.currentLocale,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                // Save / Bookmark Icon Button
                IconButton(
                  icon: Icon(
                    _isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                    color: const Color(0xFFF59E0B),
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    setState(() {
                      _isSaved = !_isSaved;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
