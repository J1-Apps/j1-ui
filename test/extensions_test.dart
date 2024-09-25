import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";

void main() {
  group("Color Extensions", () {
    test("color get dark or light returns an appropriate value", () {
      expect(Colors.black.isDark(), true);
      expect(Colors.black.isLight(), false);
      expect(Colors.white.isLight(), true);
      expect(Colors.white.isDark(), false);
    });

    test("color get black and white returns an appropriate surface color", () {
      expect(Colors.black.getBW(), Colors.white);
      expect(Colors.white.getBW(), Colors.black);
      expect(Colors.red.shade800.getBW(), Colors.white);
      expect(Colors.yellow.shade200.getBW(), Colors.black);
    });

    test("color can be built from a hex string", () {
      expect(JColorExtensions.fromHex("#FF000000"), Colors.black);
      expect(JColorExtensions.fromHex("#FFFFFFFF"), Colors.white);
      expect(JColorExtensions.fromHex("F5F5F5"), Colors.grey.shade100);
    });

    test("color can converted to a hex string", () {
      expect(Colors.black.toHex(), "#ff000000");
      expect(Colors.white.toHex(withTag: false), "ffffffff");
      expect(Colors.black.withOpacity(0.5).toHex(), "#80000000");
      expect(Colors.grey.shade100.toHex(withTag: false), "fff5f5f5");
    });

    test("color can have its value updated", () {
      final original = HSVColor.fromColor(Colors.black);
      final modified = original.withValue(original.value + 0.2);

      expect(Colors.black.addValue(0.2), modified.toColor());
    });

    test("color can have its lightness changed", () {
      final original = HSLColor.fromColor(Colors.black);
      final modified = original.withLightness(1);

      expect(Colors.black.brighten(1), modified.toColor());
    });
  });

  group("ThemeData Extensions", () {
    test("theme can have shimmer colors", () {
      final theme = ThemeData.from(colorScheme: const ColorScheme.dark(surface: Colors.red));

      expect(theme.shimmerBase(), Colors.red.addValue(0.06));
      expect(theme.shimmerHighlight(), Colors.red.addValue(0.04));
    });
  });

  group("WidgetState Extensions", () {
    test("color material state resolves in all cases", () {
      final property = Colors.red.widgetState();
      expect(property.resolve({WidgetState.disabled}), Colors.red);
      expect(property.resolve({WidgetState.hovered}), Colors.red);
      expect(property.resolve({WidgetState.dragged, WidgetState.pressed}), Colors.red);
    });

    test("double material state resolves in all cases", () {
      final property = 7.toDouble().widgetState();
      expect(property.resolve({WidgetState.disabled}), 7);
      expect(property.resolve({WidgetState.hovered}), 7);
      expect(property.resolve({WidgetState.dragged, WidgetState.pressed}), 7);
    });

    test("edge insets material state resolves in all cases", () {
      final property = const EdgeInsets.only(top: 7).widgetState();
      expect(property.resolve({WidgetState.disabled}).top, 7);
      expect(property.resolve({WidgetState.hovered}).top, 7);
      expect(property.resolve({WidgetState.dragged, WidgetState.pressed}).top, 7);
    });

    test("border side material state resolves in all cases", () {
      final property = const BorderSide(width: 2).widgetState();
      expect(property.resolve({WidgetState.disabled}).width, 2);
      expect(property.resolve({WidgetState.hovered}).width, 2);
      expect(property.resolve({WidgetState.dragged, WidgetState.pressed}).width, 2);
    });

    test("size material state resolves in all cases", () {
      final property = const Size.square(7).widgetState();
      expect(property.resolve({WidgetState.disabled}).width, 7);
      expect(property.resolve({WidgetState.hovered}).height, 7);
      expect(property.resolve({WidgetState.dragged, WidgetState.pressed}).width, 7);
    });

    test("outlined border material state resolves in all cases", () {
      final property = const RoundedRectangleBorder(
        side: BorderSide(width: 7),
      ).widgetState();

      expect(property.resolve({WidgetState.disabled}).side.width, 7);
      expect(property.resolve({WidgetState.hovered}).side.width, 7);
      expect(property.resolve({WidgetState.dragged, WidgetState.pressed}).side.width, 7);
    });

    test("text style material state resolves in all cases", () {
      final property = const TextStyle(fontSize: 7).widgetState();
      expect(property.resolve({WidgetState.disabled}).fontSize, 7);
      expect(property.resolve({WidgetState.hovered}).fontSize, 7);
      expect(property.resolve({WidgetState.dragged, WidgetState.pressed}).fontSize, 7);
    });
  });
}
