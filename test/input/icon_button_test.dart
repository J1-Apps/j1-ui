import "package:flutter/material.dart" hide IconButton;
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";
import "package:mocktail/mocktail.dart";

import "../helpers/mock_callbacks.dart";

void main() {
  group("Icon Button", () {
    testWidgets("flat button functions as expected", (tester) async {
      final onPressed = MockVoidCallback();
      const smallKey = Key("small");
      const mediumKey = Key("medium");
      const largeKey = Key("large");

      await tester.pumpWidget(
        MaterialApp(
          home: Column(
            children: [
              IconButton(
                key: smallKey,
                icon: JamIcons.h1,
                type: ButtonType.flat,
                size: WidgetSize.small,
                onPressed: onPressed.call,
              ),
              IconButton(
                key: mediumKey,
                icon: JamIcons.h2,
                type: ButtonType.flat,
                color: WidgetColor.secondary,
                onPressed: onPressed.call,
                overrides: const IconButtonOverrides(
                  outlineColor: Colors.red,
                  outlineWidth: 1,
                ),
              ),
              IconButton(
                key: largeKey,
                icon: JamIcons.h3,
                type: ButtonType.flat,
                color: WidgetColor.tertiary,
                size: WidgetSize.large,
                onPressed: onPressed.call,
              ),
              IconButton(
                icon: JamIcons.text,
                type: ButtonType.flat,
                color: WidgetColor.error,
                onPressed: onPressed.call,
              ),
              IconButton(
                icon: JamIcons.text,
                type: ButtonType.flat,
                color: WidgetColor.surface,
                onPressed: onPressed.call,
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

      expect(find.byIcon(JamIcons.h1), findsOneWidget);
      expect(find.byIcon(JamIcons.h2), findsOneWidget);
      expect(find.byIcon(JamIcons.h3), findsOneWidget);

      await tester.tap(smallFinder);
      await tester.tap(mediumFinder);
      await tester.tap(largeFinder);

      verify(onPressed.call).called(3);
    });

    testWidgets("filled button functions as expected", (tester) async {
      final onPressed = MockVoidCallback();
      const smallKey = Key("small");
      const mediumKey = Key("medium");
      const largeKey = Key("large");

      await tester.pumpWidget(
        MaterialApp(
          home: Column(
            children: [
              IconButton(
                key: smallKey,
                icon: JamIcons.h1,
                size: WidgetSize.small,
                onPressed: onPressed.call,
              ),
              IconButton(
                key: mediumKey,
                icon: JamIcons.h2,
                color: WidgetColor.secondary,
                onPressed: onPressed.call,
                overrides: const IconButtonOverrides(
                  outlineColor: Colors.red,
                  outlineWidth: 1,
                ),
              ),
              IconButton(
                key: largeKey,
                icon: JamIcons.h3,
                color: WidgetColor.tertiary,
                size: WidgetSize.large,
                onPressed: onPressed.call,
              ),
              IconButton(
                icon: JamIcons.text,
                color: WidgetColor.error,
                onPressed: onPressed.call,
              ),
              IconButton(
                icon: JamIcons.text,
                color: WidgetColor.surface,
                onPressed: onPressed.call,
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

      expect(find.byIcon(JamIcons.h1), findsOneWidget);
      expect(find.byIcon(JamIcons.h2), findsOneWidget);
      expect(find.byIcon(JamIcons.h3), findsOneWidget);

      await tester.tap(smallFinder);
      await tester.tap(mediumFinder);
      await tester.tap(largeFinder);

      verify(onPressed.call).called(3);
    });

    test("overrides is compared correctly", () {
      const overrides0 = IconButtonOverrides(iconSize: Dimens.size_16);
      const overrides1 = IconButtonOverrides(iconSize: Dimens.size_16);
      const overrides2 = IconButtonOverrides(iconSize: Dimens.size_12);

      expect(overrides0 == overrides1, true);
      expect(overrides0 == overrides2, false);
    });
  });
}
