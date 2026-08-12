# History: 017 - Redesign Book Reader & Overview Page

## User Request
At the read/listen page:
1. On top show the book cover.
2. Under cover show the book name.
3. Under book name show the author name.
4. Under author name show key points count & listening duration in ONE line.
5. Under that show a high level summary of the book in ONE paragraph.
6. Then show a list of what you will learn from this book.
7. Then show a list of key points titles which is clickable and navigates to exact key point position in summary reading mode.
8. Then show about the author in one paragraph.
9. At the bottom playback controls before the save icon, add a Reading button that opens full summary text.

## Assistant Response
1. Updated `BookSummary` entity model (`lib/src/features/library/domain/entities/book_summary.dart`) with `highLevelSummary`, `whatYouWillLearn`, and `aboutAuthor` localized fields and methods.
2. Updated `mock_book_summaries.dart` with rich mock data for all sample titles in Persian (Iran), Persian (Dari), and English.
3. Redesigned `BookReaderPage` (`lib/src/features/reader_player/presentation/pages/book_reader_page.dart`):
   - **Header Section:** Prominent book cover image, book title, author, and single-line pill indicator (`3 Key Points • 4 Min Listen`).
   - **Overview Paragraph:** High-level overview paragraph box.
   - **What You Will Learn:** Bulleted checklist of key learning outcomes.
   - **Clickable Key Points Titles:** Interactive list of key takeaway card titles. Tapping any title launches reading mode starting at that exact card position.
   - **About the Author:** Dedicated paragraph describing author background.
   - **Bottom Audio Bar:** Added **"Read Summary / مطالعه خلاصه"** button before the bookmark/save icon.
4. Verified `flutter analyze` (0 issues) and `flutter test` (all 9 tests passed).
