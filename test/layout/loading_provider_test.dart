import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";
import "package:shimmer/shimmer.dart";

import "../helpers/test_wrapper.dart";

void main() {
  group("Loading Provider", () {
    testWidgets("renders as expected", (tester) async {
      await tester.pumpWidget(
        const TestWrapper(
          child: LoadingProvider(
            child: Column(
              children: [
                LoadingText(width: 100, style: TextStyle()),
                LoadingBox(width: 100, height: 50),
              ],
            ),
          ),
        ),
      );

      final indicator = find.byType(Shimmer);
      expect(indicator, findsOneWidget);
    });
  });
}