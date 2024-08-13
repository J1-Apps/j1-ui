import "dart:ui";

import "package:flutter/material.dart";

extension ColorExtensions on Color {
  WidgetStateProperty<Color> widgetState() {
    return WidgetStatePropertyAll(this);
  }

  Color getBW() {
    return isLight() ? Colors.black : Colors.white;
  }

  bool isLight() {
    return (red * 0.3 + green * 0.6 + blue * 0.1) > 186;
  }

  bool isDark() {
    return !isLight();
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();

    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write("ff");
    }

    buffer.write(hexString.replaceFirst("#", ""));
    final value = int.tryParse(buffer.toString(), radix: 16);

    if (value == null) {
      return Colors.black;
    }

    return Color(value);
  }

  String toHex({bool withTag = true}) {
    final buffer = StringBuffer();

    if (withTag) {
      buffer.write("#");
    }

    buffer.write(alpha.toRadixString(16).padLeft(2, "0"));
    buffer.write(red.toRadixString(16).padLeft(2, "0"));
    buffer.write(green.toRadixString(16).padLeft(2, "0"));
    buffer.write(blue.toRadixString(16).padLeft(2, "0"));
    return buffer.toString();
  }

  Color addValue(double value) {
    final hsv = HSVColor.fromColor(this);
    return hsv.withValue(clampDouble(hsv.value + value, 0, 1)).toColor();
  }

  /// Brightens (or darkens) a [Color] by the given [amount]. Give a positive number from 0.0 to 1.0 to brighten, and a
  /// negative number from -1.0 to 0.0 to darken.
  Color brighten(double amount) {
    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness + amount).clamp(0, 1).toDouble();
    return hsl.withLightness(lightness).toColor();
  }
}

extension ThemeExtensions on ThemeData {
  Color shimmerBase() => colorScheme.surface.addValue(brightness == Brightness.dark ? 0.06 : -0.06);
  Color shimmerHighlight() => colorScheme.surface.addValue(brightness == Brightness.dark ? 0.04 : -0.04);
}

extension DoubleExtensions on double {
  WidgetStateProperty<double> widgetState() {
    return WidgetStatePropertyAll(this);
  }
}

extension EdgeInsetsExtensions on EdgeInsets {
  WidgetStateProperty<EdgeInsets> widgetState() {
    return WidgetStatePropertyAll(this);
  }
}

extension SizeExtensions on Size {
  WidgetStateProperty<Size> widgetState() {
    return WidgetStatePropertyAll(this);
  }
}

extension OutlinedBorderExtensions on OutlinedBorder {
  WidgetStateProperty<OutlinedBorder> widgetState() {
    return WidgetStatePropertyAll(this);
  }
}

extension TextStyleExtensions on TextStyle {
  WidgetStateProperty<TextStyle> widgetState() {
    return WidgetStatePropertyAll(this);
  }
}

// coverage:ignore-start
extension BuildContextExtensions on BuildContext {
  ThemeData theme() {
    return Theme.of(this);
  }

  TextTheme textTheme() {
    return Theme.of(this).textTheme;
  }

  ColorScheme colorScheme() {
    return Theme.of(this).colorScheme;
  }

  bool isCurrent() {
    return mounted && (ModalRoute.of(this)?.isCurrent ?? false);
  }
}
// coverage:ignore-end
