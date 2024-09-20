import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";
import "package:mocktail/mocktail.dart";

import "../helpers/mock_callbacks.dart";
import "../helpers/test_wrapper.dart";

void main() {
  group("Toast", () {
    testWidgets("is created with simple content", (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: Scaffold(
            body: Builder(
              builder: (context) => JIconButton(
                icon: JamIcons.pencil,
                type: JButtonType.flat,
                onPressed: () => context.showJToast(
                  child: const Text("test snackbar content"),
                  overrides: const JToastOverrides(elevation: 4),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(JamIcons.pencil));
      await tester.pumpAndSettle();

      expect(find.text("test snackbar content"), findsOneWidget);
    });

    testWidgets("is created with close button", (tester) async {
      final close = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Scaffold(
            body: Builder(
              builder: (context) => JIconButton(
                icon: JamIcons.pencil,
                type: JButtonType.flat,
                onPressed: () => context.showJToastWithClose(
                  child: const Text("test snackbar content"),
                  onClose: close.call,
                  overrides: const JToastOverrides(elevation: 4),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(JamIcons.pencil));
      await tester.pumpAndSettle();

      final closeButton = find.byIcon(JamIcons.close);

      expect(find.text("test snackbar content"), findsOneWidget);
      expect(closeButton, findsOneWidget);

      await tester.tap(find.byIcon(JamIcons.close));
      await tester.pumpAndSettle();

      verify(close.call).called(1);
    });

    testWidgets("is created with text content", (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: Scaffold(
            body: Builder(
              builder: (context) => JIconButton(
                icon: JamIcons.pencil,
                type: JButtonType.flat,
                onPressed: () => context.showJToastWithText(
                  text: "test snackbar content",
                  overrides: const JToastOverrides(elevation: 4),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(JamIcons.pencil));
      await tester.pumpAndSettle();

      expect(find.text("test snackbar content"), findsOneWidget);
    });

    testWidgets("is created with text and close content", (tester) async {
      final close = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Scaffold(
            body: Builder(
              builder: (context) => JIconButton(
                icon: JamIcons.pencil,
                type: JButtonType.flat,
                onPressed: () => context.showJToastWithText(
                  text: "test snackbar content",
                  hasClose: true,
                  onClose: close.call,
                  overrides: const JToastOverrides(elevation: 4),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(JamIcons.pencil));
      await tester.pumpAndSettle();

      final closeButton = find.byIcon(JamIcons.close);

      expect(find.text("test snackbar content"), findsOneWidget);
      expect(closeButton, findsOneWidget);

      await tester.tap(find.byIcon(JamIcons.close));
      await tester.pumpAndSettle();

      verify(close.call).called(1);
    });

    testWidgets("closes by default", (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: Scaffold(
            body: Builder(
              builder: (context) => JIconButton(
                icon: JamIcons.pencil,
                type: JButtonType.flat,
                onPressed: () => context.showJToastWithClose(
                  child: const Text("test snackbar content"),
                  overrides: const JToastOverrides(elevation: 4),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(JamIcons.pencil));
      await tester.pumpAndSettle();

      final closeButton = find.byIcon(JamIcons.close);

      expect(find.text("test snackbar content"), findsOneWidget);
      expect(closeButton, findsOneWidget);

      await tester.tap(find.byIcon(JamIcons.close));
      await tester.pumpAndSettle();

      expect(find.text("test snackbar content"), findsNothing);
      expect(closeButton, findsNothing);
    });

    test("overrides are compared correctly", () {
      const overrides0 = JToastOverrides(cornerRadius: JDimens.radius_l);
      const overrides1 = JToastOverrides(cornerRadius: JDimens.radius_l);
      const overrides2 = JToastOverrides(cornerRadius: JDimens.radius_xl);

      expect(overrides0 == overrides1, true);
      expect(overrides0 == overrides2, false);
    });
  });
}
