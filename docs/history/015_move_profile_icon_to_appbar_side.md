# History: 015 - Relocate Profile Avatar Button to AppBar Actions Side

## User Request
Move the profile icon to the side.

## Assistant Response
1. Updated top AppBar in `RoshanaHomeScreen` (`lib/src/app/app.dart`).
2. Relocated the profile avatar button from the brand title row to the top bar `actions` side right next to the language switcher dropdown.
3. Verified clean header layout in both RTL and LTR directionalities.
4. Verified `flutter analyze` (0 issues) and `flutter test` (all 9 tests passed).
