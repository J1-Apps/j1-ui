import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/layout/error_message.dart";
import "package:mocktail/mocktail.dart";

import "../helpers/mock_callbacks.dart";
import "../helpers/test_wrapper.dart";

void main() {
  group("Error Message", () {
    testWidgets("renders with all elements", (tester) async {
      final mockCallback = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: JErrorMessage(
            title: "title",
            message: "test",
            cta: "action",
            ctaAction: mockCallback.call,
          ),
        ),
      );

      final ctaFinder = find.text("ACTION");

      expect(find.text("title"), findsOneWidget);
      expect(find.text("test"), findsOneWidget);
      expect(ctaFinder, findsOneWidget);

      await tester.tap(ctaFinder);

      verify(mockCallback.call).called(1);
    });

    testWidgets("renders with message only", (tester) async {
      await tester.pumpWidget(
        const TestWrapper(
          child: JErrorMessage(
            message: "test",
          ),
        ),
      );

      final ctaFinder = find.text("action");

      expect(find.text("title"), findsNothing);
      expect(find.text("test"), findsOneWidget);
      expect(ctaFinder, findsNothing);
    });
  });
}
