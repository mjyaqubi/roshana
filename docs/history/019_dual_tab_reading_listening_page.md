# History: 019 - Dual-Tab Reading & Listening Page and Full-Width Bottom Buttons

## User Request
1. Remove save icon, play button, and speed button from bottom bar of `BookReaderPage`.
2. Replace bottom bar with two buttons spanning the entire bottom of the page: "Reading" and "Listening".
3. Create a dedicated page (`BookFullReaderPlayerPage`) featuring two tabs: "Reading" and "Listening".
   - **Reading Tab:** Displays the full book summary in single continuous paragraph view.
   - **Listening Tab:** Displays book cover at top, progress bar, and exact control buttons: `Previous` -> `Backward 10s` -> `Play/Pause` -> `Forward 10s` -> `Next`.

## Assistant Response
1. Updated `BookReaderPage` (`lib/src/features/reader_player/presentation/pages/book_reader_page.dart`):
   - Replaced old playing box with two full-width elevated action buttons: **"Reading" / "مطالعه"** and **"Listening" / "شنیدار"**.
   - Tapping "Reading" opens `BookFullReaderPlayerPage` pre-selected on Tab 0.
   - Tapping "Listening" opens `BookFullReaderPlayerPage` pre-selected on Tab 1.
2. Built `BookFullReaderPlayerPage` (`lib/src/features/reader_player/presentation/pages/book_full_reader_player_page.dart`):
   - **Reading Tab:** Continuous single scroll view rendering high-level overview and card takeaways in formatted paragraphs.
   - **Listening Tab:** Centered book cover at top, audio progress slider with timecodes, speed toggle, and playback controls in exact order:
     - ⏮️ `Previous Key Point`
     - ⏪ `Backward 10s`
     - ⏯️ `Play / Pause` (Primary center gradient button)
     - ⏩ `Forward 10s`
     - ⏭️ `Next Key Point`
3. Verified `flutter analyze` (0 issues) and `flutter test` (all 9 tests passed).
