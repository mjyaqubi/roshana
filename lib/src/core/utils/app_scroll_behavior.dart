import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Custom ScrollBehavior enabling touch, mouse, trackpad, and stylus drag scrolling across all platforms
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      };
}
