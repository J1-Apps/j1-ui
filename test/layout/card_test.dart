import "package:flutter/material.dart" hide Card;
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";
import "package:mocktail/mocktail.dart";

import "../helpers/mock_callbacks.dart";
import "../helpers/test_wrapper.dart";

void main() {
  group("Card", () {
    testWidgets("renders as expected", (tester) async {
      final onPressed = MockVoidCallback();
      const smallKey = Key("small");
      const mediumKey = Key("medium");
      const largeKey = Key("large");

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: Card(
                  key: smallKey,
                  size: WidgetSize.small,
                  onPressed: onPressed.call,
                ),
              ),
              const SizedBox(
                height: 80,
                child: Card(key: mediumKey),
              ),
              SizedBox(
                height: 80,
                child: Card(
                  key: largeKey,
                  size: WidgetSize.large,
                  onPressed: onPressed.call,
                ),
              ),
            ],
          ),
        ),
      );

      final smallFinder = find.byKey(smallKey);
      final mediumFinder = find.byKey(mediumKey);
      final largeFinder = find.byKey(largeKey);

      expect(smallFinder, findsOneWidget);
      expect(mediumFinder, findsOneWidget);
      expect(largeFinder, findsOneWidget);

      await tester.tap(smallFinder);
      await tester.tap(largeFinder);

      verify(onPressed.call).called(2);
    });

    test("overrides are compared correctly", () {
      const overrides0 = CardOverrides(cornerRadius: Dimens.radius_l);
      const overrides1 = CardOverrides(cornerRadius: Dimens.radius_l);
      const overrides2 = CardOverrides(cornerRadius: Dimens.radius_xl);

      expect(overrides0 == overrides1, true);
      expect(overrides0 == overrides2, false);
    });
  });
}
