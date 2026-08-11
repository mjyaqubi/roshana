import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/i18n/app_locale.dart';
import '../../../../core/i18n/font_resolver.dart';
import '../../../library/domain/entities/book_summary.dart';
import '../../domain/entities/takeaway_card.dart';

class CardDeckReader extends StatefulWidget {
  final BookSummary bookSummary;
  final RoshanaLocale currentLocale;

  const CardDeckReader({
    super.key,
    required this.bookSummary,
    required this.currentLocale,
  });

  @override
  State<CardDeckReader> createState() => _CardDeckReaderState();
}

class _CardDeckReaderState extends State<CardDeckReader> {
  late PageController _pageController;
  int _currentIndex = 0;
  bool _isPlaying = false;
  double _playbackSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    HapticFeedback.mediumImpact();
    setState(() {
      _currentIndex = index;
    });
  }

  void _togglePlayPause() {
    HapticFeedback.selectionClick();
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _cyclePlaybackSpeed() {
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

  Color _getBadgeColor(CardType type) {
    switch (type) {
      case CardType.coreTakeaway:
        return const Color(0xFFF59E0B); // Gold
      case CardType.keyPrinciple:
        return const Color(0xFF6366F1); // Indigo
      case CardType.actionableInsight:
        return const Color(0xFF10B981); // Emerald
    }
  }

  String _getBadgeLabel(CardType type, String langCode) {
    switch (type) {
      case CardType.coreTakeaway:
        return langCode == 'en' ? 'CORE TAKEAWAY' : 'دستآورد اصلی';
      case CardType.keyPrinciple:
        return langCode == 'en' ? 'KEY PRINCIPLE' : 'اصل بنیادی';
      case CardType.actionableInsight:
        return langCode == 'en' ? 'ACTIONABLE INSIGHT' : 'راهکار عملی';
    }
  }

  @override
  Widget build(BuildContext context) {
    final langCode = widget.currentLocale.locale.languageCode;
    final countryCode = widget.currentLocale.locale.countryCode;
    final title = widget.bookSummary.getLocalizedTitle(langCode, countryCode);
    final cards = widget.bookSummary.cards;

    return Column(
      children: [
        // Top Header Info
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: RoshanaTypography.getTextStyle(
                      currentLocale: widget.currentLocale,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.bookSummary.originalAuthor,
                    style: RoshanaTypography.getTextStyle(
                      currentLocale: widget.currentLocale,
                      fontSize: 13,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '${_currentIndex + 1} / ${cards.length}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Swipeable Card Stack Area
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];
              final badgeColor = _getBadgeColor(card.type);
              final badgeText = _getBadgeLabel(card.type, langCode);
              final cardText = card.getLocalizedContent(langCode, countryCode);

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF1E293B),
                      const Color(0xFF0F172A).withValues(alpha: 0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: badgeColor.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: badgeColor.withValues(alpha: 0.15),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge Header
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: badgeColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: badgeColor.withValues(alpha: 0.5)),
                      ),
                      child: Text(
                        badgeText,
                        style: RoshanaTypography.getTextStyle(
                          currentLocale: widget.currentLocale,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: badgeColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Main Takeaway Text
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          cardText,
                          style: RoshanaTypography.getTextStyle(
                            currentLocale: widget.currentLocale,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.timer_outlined, size: 15, color: Colors.white54),
                            const SizedBox(width: 4),
                            Text(
                              '${((card.audioEndMs - card.audioStartMs) / 1000).toStringAsFixed(0)}s',
                              style: const TextStyle(color: Colors.white54, fontSize: 12),
                            ),
                          ],
                        ),
                        Icon(Icons.swipe_outlined, size: 18, color: badgeColor.withValues(alpha: 0.7)),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // Audio Controls & Progress Bar Bar
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Speed toggle
              GestureDetector(
                onTap: _cyclePlaybackSpeed,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${_playbackSpeed}x',
                    style: const TextStyle(
                      color: Color(0xFFF59E0B),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Previous card button
              IconButton(
                icon: const Icon(Icons.skip_previous_rounded, color: Colors.white),
                onPressed: _currentIndex > 0
                    ? () => _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        )
                    : null,
              ),

              // Play / Pause button
              GestureDetector(
                onTap: _togglePlayPause,
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x66F59E0B),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Icon(
                    _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              ),

              // Next card button
              IconButton(
                icon: const Icon(Icons.skip_next_rounded, color: Colors.white),
                onPressed: _currentIndex < cards.length - 1
                    ? () => _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        )
                    : null,
              ),

              // Bookmark icon
              IconButton(
                icon: const Icon(Icons.bookmark_outline_rounded, color: Colors.white54),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Card bookmarked to SRS review deck!'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
