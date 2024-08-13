import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";
import "package:mocktail/mocktail.dart";

import "../helpers/mock_callbacks.dart";

void main() {
  group("List Item", () {
    testWidgets("renders with no elements", (tester) async {
      final onPressed = MockVoidCallback();
      const key = Key("test");

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListItem(
              key: key,
              onPressed: onPressed.call,
              children: const [],
            ),
          ),
        ),
      );

      final finder = find.byKey(key);

      await tester.tap(finder);

      expect(find.text("0"), findsNothing);
      verify(onPressed.call).called(1);
    });

    testWidgets("renders with one element", (tester) async {
      final onPressed = MockVoidCallback();
      const key = Key("test");

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListItem(
              key: key,
              onPressed: onPressed.call,
              children: const [
                Text("0"),
              ],
            ),
          ),
        ),
      );

      final finder = find.byKey(key);

      await tester.tap(finder);

      expect(find.text("0"), findsOneWidget);
      verify(onPressed.call).called(1);
    });

    testWidgets("renders with two elements", (tester) async {
      final onPressed = MockVoidCallback();
      const key = Key("test");

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListItem(
              key: key,
              onPressed: onPressed.call,
              children: const [
                Text("0"),
                Text("1"),
              ],
            ),
          ),
        ),
      );

      final finder = find.byKey(key);

      await tester.tap(finder);

      expect(find.text("0"), findsOneWidget);
      expect(find.text("1"), findsOneWidget);
      verify(onPressed.call).called(1);
    });
  });
}
