# History: 016 - Move Profile Avatar Button to Leading Side (Opposite Language Dropdown)

## User Request
Move the profile icon to the opposite side of the language dropdown.

## Assistant Response
1. Updated top AppBar in `RoshanaHomeScreen` (`lib/src/app/app.dart`).
2. Placed the profile avatar button inside the `leading` slot on the far opposite side from the language dropdown in `actions`.
3. Verified symmetrical AppBar balancing across Persian (RTL) and English (LTR) layouts.
4. Verified `flutter analyze` (0 issues) and `flutter test` (all 9 tests passed).
