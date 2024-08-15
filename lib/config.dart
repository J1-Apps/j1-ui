import "package:flutter/material.dart";

enum WidgetColor {
  primary,
  secondary,
  tertiary,
  error,
  surface,
  onSurface,
}

enum WidgetSize {
  small,
  medium,
  large,
}

abstract final class J1Config {
  static const buttonOverlayOpacity = 0.1;
  static const strokeWidth = 2.0;
  static const selectedStrokeWidth = 3.0;
  static const disabledOpacity = 0.5;
  static const hintOpacity = 0.4;

  static const PageTransitionsTheme transitions = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}
