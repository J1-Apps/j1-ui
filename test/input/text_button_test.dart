import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";
import "package:mocktail/mocktail.dart";

import "../helpers/mock_callbacks.dart";
import "../helpers/test_wrapper.dart";

void main() {
  group("Text Button", () {
    testWidgets("flat button functions as expected", (tester) async {
      final onPressed = MockVoidCallback();
      const smallKey = Key("small");
      const mediumKey = Key("medium");
      const largeKey = Key("large");

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              JTextButton(
                key: smallKey,
                text: "test",
                icon: JamIcons.h1,
                type: JButtonType.flat,
                size: JWidgetSize.small,
                onPressed: onPressed.call,
              ),
              JTextButton(
                key: mediumKey,
                text: "test",
                icon: JamIcons.h2,
                type: JButtonType.flat,
                color: JWidgetColor.secondary,
                onPressed: onPressed.call,
                overrides: const JTextButtonOverrides(
                  outlineColor: Colors.red,
                  outlineWidth: 1,
                ),
              ),
              JTextButton(
                key: largeKey,
                text: "test",
                icon: JamIcons.h3,
                type: JButtonType.flat,
                color: JWidgetColor.tertiary,
                size: JWidgetSize.large,
                onPressed: onPressed.call,
              ),
              JTextButton(
                text: "test",
                type: JButtonType.flat,
                color: JWidgetColor.error,
                onPressed: onPressed.call,
              ),
              JTextButton(
                text: "test",
                type: JButtonType.flat,
                color: JWidgetColor.surface,
                onPressed: onPressed.call,
              ),
              JTextButton(
                text: "test",
                type: JButtonType.flat,
                color: JWidgetColor.onSurface,
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
        TestWrapper(
          child: Column(
            children: [
              JTextButton(
                key: smallKey,
                text: "test",
                icon: JamIcons.h1,
                size: JWidgetSize.small,
                onPressed: onPressed.call,
              ),
              JTextButton(
                key: mediumKey,
                text: "test",
                icon: JamIcons.h2,
                color: JWidgetColor.secondary,
                onPressed: onPressed.call,
                overrides: const JTextButtonOverrides(
                  outlineColor: Colors.red,
                  outlineWidth: 1,
                ),
              ),
              JTextButton(
                key: largeKey,
                text: "test",
                icon: JamIcons.h3,
                color: JWidgetColor.tertiary,
                size: JWidgetSize.large,
                onPressed: onPressed.call,
              ),
              JTextButton(
                text: "test",
                color: JWidgetColor.error,
                onPressed: onPressed.call,
              ),
              JTextButton(
                text: "test",
                color: JWidgetColor.surface,
                onPressed: onPressed.call,
              ),
              JTextButton(
                text: "test",
                color: JWidgetColor.onSurface,
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

    test("overrides are compared correctly", () {
      const overrides0 = JTextButtonOverrides(iconSize: JDimens.size_16);
      const overrides1 = JTextButtonOverrides(iconSize: JDimens.size_16);
      const overrides2 = JTextButtonOverrides(iconSize: JDimens.size_12);

      expect(overrides0 == overrides1, true);
      expect(overrides0 == overrides2, false);
    });
  });
}
