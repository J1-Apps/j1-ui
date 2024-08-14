import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart" hide NetworkImage;
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";

import "../helpers/test_wrapper.dart";

void main() {
  group("Image", () {
    testWidgets("renders from network as expected", (tester) async {
      await tester.pumpWidget(
        const TestWrapper(
          child: NetworkImage(
            source: "test.com",
            fit: BoxFit.cover,
          ),
        ),
      );

      final networkFinder = find.byType(CachedNetworkImage);
      expect(networkFinder, findsOneWidget);
    });

    testWidgets("renders from svg as expected", (tester) async {
      await tester.pumpWidget(
        const TestWrapper(
          child: SvgImage(
            source: "assets/j1_logo.svg",
            fit: BoxFit.cover,
          ),
        ),
      );

      final networkFinder = find.byType(SvgImage);
      expect(networkFinder, findsOneWidget);
    });
  });
}
