import "package:flutter/material.dart";

enum WidgetColor {
  primary,
  secondary,
  tertiary,
  error,
  surface,
}

abstract final class J1Config {
  static const double buttonOverlayOpacity = 0.1;

  static const PageTransitionsTheme transitions = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}
