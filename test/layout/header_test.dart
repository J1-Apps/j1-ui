import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";

import "../helpers/test_wrapper.dart";

void main() {
  group("Header", () {
    testWidgets("renders with all elements", (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: Scaffold(
            appBar: JAppBar(
              leadingAction: const Text("leading"),
              title: "test",
              trailingActions: const [Text("action"), Text("action"), Text("action")],
            ),
          ),
        ),
      );

      expect(find.text("leading"), findsOneWidget);
      expect(find.text("test"), findsOneWidget);
      expect(find.text("action"), findsNWidgets(3));
    });

    testWidgets("renders with no leading", (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: Scaffold(
            appBar: JAppBar(
              title: "test",
              trailingActions: const [Text("action"), Text("action"), Text("action")],
            ),
          ),
        ),
      );

      expect(find.text("leading"), findsNothing);
      expect(find.text("test"), findsOneWidget);
      expect(find.text("action"), findsNWidgets(3));
    });

    testWidgets("renders with no actions", (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: Scaffold(
            appBar: JAppBar(
              leadingAction: const Text("leading"),
              title: "test",
            ),
          ),
        ),
      );

      expect(find.text("leading"), findsOneWidget);
      expect(find.text("test"), findsOneWidget);
      expect(find.text("action"), findsNothing);
    });

    test("dimens is compared correctly", () {
      const dimens0 = JAppBarDimens.medium;
      final dimens1 = JAppBarDimens.medium.copyWith();
      final dimens2 = JAppBarDimens.medium.copyWith(titleSpacing: JDimens.size_16);

      expect(dimens0 == dimens1, true);
      expect(dimens0 == dimens2, false);
    });
  });
}
