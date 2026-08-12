import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/i18n/app_locale.dart';
import '../../../../core/i18n/font_resolver.dart';
import '../../../library/domain/entities/book_summary.dart';

class BookFullReaderPlayerPage extends StatefulWidget {
  final BookSummary bookSummary;
  final RoshanaLocale currentLocale;
  final int initialTabIndex; // 0 = Reading, 1 = Listening

  const BookFullReaderPlayerPage({
    super.key,
    required this.bookSummary,
    required this.currentLocale,
    this.initialTabIndex = 0,
  });

  @override
  State<BookFullReaderPlayerPage> createState() => _BookFullReaderPlayerPageState();
}

class _BookFullReaderPlayerPageState extends State<BookFullReaderPlayerPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isPlaying = false;
  double _playbackSpeed = 1.0;
  int _currentCardIndex = 0;
  double _audioProgressSeconds = 25.0; // Simulated audio position
  final double _totalAudioSeconds = 240.0; // 4 minutes

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    HapticFeedback.selectionClick();
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _seekBackward10s() {
    HapticFeedback.selectionClick();
    setState(() {
      _audioProgressSeconds = (_audioProgressSeconds - 10).clamp(0.0, _totalAudioSeconds);
    });
  }

  void _seekForward10s() {
    HapticFeedback.selectionClick();
    setState(() {
      _audioProgressSeconds = (_audioProgressSeconds + 10).clamp(0.0, _totalAudioSeconds);
    });
  }

  void _goToPreviousCard() {
    HapticFeedback.selectionClick();
    if (_currentCardIndex > 0) {
      setState(() {
        _currentCardIndex--;
        _audioProgressSeconds = (_currentCardIndex * (_totalAudioSeconds / widget.bookSummary.cards.length));
      });
    }
  }

  void _goToNextCard() {
    HapticFeedback.selectionClick();
    if (_currentCardIndex < widget.bookSummary.cards.length - 1) {
      setState(() {
        _currentCardIndex++;
        _audioProgressSeconds = (_currentCardIndex * (_totalAudioSeconds / widget.bookSummary.cards.length));
      });
    }
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

  String _formatTime(double seconds) {
    final mins = (seconds / 60).floor();
    final secs = (seconds % 60).floor();
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final langCode = widget.currentLocale.locale.languageCode;
    final countryCode = widget.currentLocale.locale.countryCode;
    final isEn = langCode == 'en';
    final book = widget.bookSummary;
    final title = book.getLocalizedTitle(langCode, countryCode);

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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFF59E0B),
          labelColor: const Color(0xFFF59E0B),
          unselectedLabelColor: Colors.white54,
          labelStyle: RoshanaTypography.getTextStyle(
            currentLocale: widget.currentLocale,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          tabs: [
            Tab(
              icon: const Icon(Icons.chrome_reader_mode_rounded, size: 20),
              text: isEn ? 'Reading' : 'مطالعه',
            ),
            Tab(
              icon: const Icon(Icons.headphones_rounded, size: 20),
              text: isEn ? 'Listening' : 'شنیدار',
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            // Tab 1: Reading View (Full Summary in Paragraphs)
            _buildReadingTab(book, langCode, countryCode, isEn),

            // Tab 2: Listening View (Cover, Progress Bar & Audio Player Controls)
            _buildListeningTab(book, langCode, countryCode, isEn),
          ],
        ),
      ),
    );
  }

  /// Tab 1: Reading View - Paragraphs continuous scroll
  Widget _buildReadingTab(BookSummary book, String langCode, String? countryCode, bool isEn) {
    final highLevelSummary = book.getLocalizedHighLevelSummary(langCode, countryCode);
    final cards = book.cards;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // High Level Overview Section
          if (highLevelSummary.isNotEmpty) ...[
            Text(
              isEn ? 'High-Level Overview' : 'خلاصه کلی اثر',
              style: RoshanaTypography.getTextStyle(
                currentLocale: widget.currentLocale,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF59E0B),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
              ),
              child: Text(
                highLevelSummary,
                style: RoshanaTypography.getTextStyle(
                  currentLocale: widget.currentLocale,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Key Takeaways & Principles in Paragraphs
          Text(
            isEn ? 'Key Takeaways & Principles' : 'فصل‌ها و اصول کلیدی',
            style: RoshanaTypography.getTextStyle(
              currentLocale: widget.currentLocale,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFF59E0B),
            ),
          ),
          const SizedBox(height: 14),

          Column(
            children: cards.asMap().entries.map((entry) {
              final idx = entry.key;
              final card = entry.value;
              final content = card.getLocalizedContent(langCode, countryCode);

              return Container(
                margin: const EdgeInsets.only(bottom: 18),
                padding: const EdgeInsets.all(18),
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
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFF59E0B)),
                          ),
                          child: Text(
                            isEn ? 'Key Point ${idx + 1}' : 'نکته شماره ${idx + 1}',
                            style: const TextStyle(
                              color: Color(0xFFF59E0B),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      content,
                      style: RoshanaTypography.getTextStyle(
                        currentLocale: widget.currentLocale,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Tab 2: Listening View - Cover, Progress Bar, Previous, 10s Back, Play/Pause, 10s Forward, Next
  Widget _buildListeningTab(BookSummary book, String langCode, String? countryCode, bool isEn) {
    final cards = book.cards;
    final currentCard = cards.isNotEmpty ? cards[_currentCardIndex] : null;
    final currentCardContent = currentCard?.getLocalizedContent(langCode, countryCode) ?? '';

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Book Cover Image at the Top
          Container(
            height: 230,
            width: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.white24, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF59E0B).withValues(alpha: 0.25),
                  blurRadius: 24,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                book.coverImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFF1E293B),
                  child: const Center(
                    child: Icon(Icons.book_rounded, color: Colors.white38, size: 50),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Card Index & Title Indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
            ),
            child: Text(
              isEn
                  ? 'Key Point ${_currentCardIndex + 1} of ${cards.length}'
                  : 'نکته کلیدی ${_currentCardIndex + 1} از ${cards.length}',
              style: RoshanaTypography.getTextStyle(
                currentLocale: widget.currentLocale,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF59E0B),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Active Card Content Snippet
          Text(
            '«$currentCardContent»',
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: RoshanaTypography.getTextStyle(
              currentLocale: widget.currentLocale,
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 28),

          // 2. Audio Progress Slider & Timecodes (Top of controls)
          Column(
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                  activeTrackColor: const Color(0xFFF59E0B),
                  inactiveTrackColor: Colors.white24,
                  thumbColor: const Color(0xFFF59E0B),
                ),
                child: Slider(
                  value: _audioProgressSeconds,
                  min: 0.0,
                  max: _totalAudioSeconds,
                  onChanged: (val) {
                    setState(() {
                      _audioProgressSeconds = val;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatTime(_audioProgressSeconds),
                      style: const TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                    Text(
                      _formatTime(_totalAudioSeconds),
                      style: const TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 3. Playback Control Buttons Row (Previous, 10s Back, Play/Pause, 10s Forward, Next)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 1. Previous Key Point
              IconButton(
                iconSize: 32,
                icon: const Icon(Icons.skip_previous_rounded, color: Colors.white),
                onPressed: _goToPreviousCard,
                tooltip: isEn ? 'Previous Key Point' : 'نکته قبلی',
              ),

              // 2. Backward 10s
              IconButton(
                iconSize: 32,
                icon: const Icon(Icons.replay_10_rounded, color: Colors.white70),
                onPressed: _seekBackward10s,
                tooltip: isEn ? 'Backward 10s' : '۱۰ ثانیه عقب',
              ),

              // 3. Play and Pause (Primary Middle Button)
              GestureDetector(
                onTap: _togglePlayPause,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x66F59E0B),
                        blurRadius: 16,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: Colors.black,
                    size: 38,
                  ),
                ),
              ),

              // 4. Forward 10s
              IconButton(
                iconSize: 32,
                icon: const Icon(Icons.forward_10_rounded, color: Colors.white70),
                onPressed: _seekForward10s,
                tooltip: isEn ? 'Forward 10s' : '۱۰ ثانیه جلو',
              ),

              // 5. Next Key Point
              IconButton(
                iconSize: 32,
                icon: const Icon(Icons.skip_next_rounded, color: Colors.white),
                onPressed: _goToNextCard,
                tooltip: isEn ? 'Next Key Point' : 'نکته بعدی',
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Speed Multiplier Selector
          GestureDetector(
            onTap: _cycleSpeed,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.4)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.speed_rounded, color: Color(0xFFF59E0B), size: 18),
                  const SizedBox(width: 6),
                  Text(
                    '${isEn ? 'Speed' : 'سرعت پخش'}: ${_playbackSpeed}x',
                    style: const TextStyle(
                      color: Color(0xFFF59E0B),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
