import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";

import "../helpers/test_wrapper.dart";

void main() {
  group("Loading Indicator", () {
    testWidgets("renders as expected", (tester) async {
      await tester.pumpWidget(
        const TestWrapper(
          child: Center(
            child: LoadingIndicator(label: "test label"),
          ),
        ),
      );

      final indicator = find.byType(CircularProgressIndicator);

      expect(find.text("test label"), findsOneWidget);
      expect(indicator, findsOneWidget);
    });
  });
}
