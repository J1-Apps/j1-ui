import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";
import "package:mocktail/mocktail.dart";

import "../helpers/mock_callbacks.dart";
import "../helpers/test_wrapper.dart";

void main() {
  group("Font Card", () {
    testWidgets("functions as expected", (tester) async {
      final callback = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) {
              final fonts = context.textTheme();

              return FontCard(
                fontName: "test font",
                styles: [
                  fonts.headlineMedium,
                  fonts.titleMedium,
                  fonts.bodyMedium,
                ],
                onPressed: callback.call,
              );
            },
          ),
        ),
      );

      final cardFinder = find.byType(FontCard);

      expect(cardFinder, findsOneWidget);
      expect(find.text("test font"), findsNWidgets(3));

      await tester.tap(cardFinder);

      verify(callback.call).called(1);
    });

    test("overrides are compared correctly", () {
      const overrides0 = FontCardOverrides(foregroundColor: Colors.black);
      const overrides1 = FontCardOverrides(foregroundColor: Colors.black);
      const overrides2 = FontCardOverrides(foregroundColor: Colors.blue);

      expect(overrides0 == overrides1, true);
      expect(overrides0 == overrides2, false);
    });
  });
}
