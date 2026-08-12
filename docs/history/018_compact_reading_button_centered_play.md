# History: 018 - Compact Reading Button & Centered Play Control Layout

## User Request
1. Reading button is very wide, keep it smaller and the text should be "Reading" only.
2. The play button should be in the middle.
3. Then the speed button and save icon.

## Assistant Response
1. Updated bottom playback controls bar in `BookReaderPage` (`lib/src/features/reader_player/presentation/pages/book_reader_page.dart`):
   - **Compact Reading Button:** Reduced padding and width, text simplified to concise `"Reading"` (`"مطالعه"` in Persian).
   - **Centered Play Button:** Prominently placed in the center of the control bar.
   - **Speed & Save Controls:** Placed after the play button with compact spacing.
2. Verified `flutter analyze` (0 issues) and `flutter test` (all 9 tests passed).
