import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";
import "package:mocktail/mocktail.dart";

import "../helpers/mock_callbacks.dart";
import "../helpers/test_wrapper.dart";

void main() {
  group("Theme Card", () {
    testWidgets("functions as expected", (tester) async {
      final callback = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) {
              final colors = context.colorScheme();
              final fonts = context.textTheme();

              return ThemeCard(
                themeName: "test theme",
                colors: colors,
                fonts: fonts,
                onPressed: callback.call,
              );
            },
          ),
        ),
      );

      final cardFinder = find.byType(ThemeCard);

      expect(cardFinder, findsOneWidget);
      expect(find.text("test theme"), findsNWidgets(3));

      await tester.tap(cardFinder);

      verify(callback.call).called(1);
    });

    test("overrides are compared correctly", () {
      const overrides0 = ThemeCardOverrides(colorIconSize: 16.0);
      const overrides1 = ThemeCardOverrides(colorIconSize: 16.0);
      const overrides2 = ThemeCardOverrides(colorIconSize: 26.0);

      expect(overrides0 == overrides1, true);
      expect(overrides0 == overrides2, false);
    });
  });
}
