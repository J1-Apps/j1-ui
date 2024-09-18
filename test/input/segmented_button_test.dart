import "package:flutter/material.dart" hide SegmentedButton, ButtonSegment;
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";
import "package:mocktail/mocktail.dart";

import "../helpers/mock_callbacks.dart";
import "../helpers/test_wrapper.dart";

const _segments = <ButtonSegment>[
  ButtonSegment(id: "test-0", label: Text("0")),
  ButtonSegment(id: "test-1", label: Text("1")),
  ButtonSegment(id: "test-2", label: Text("2")),
  ButtonSegment(id: "test-3", label: Text("3")),
  ButtonSegment(id: "test-4", label: Text("4")),
];

void main() {
  group("Segmented Button", () {
    testWidgets("handles selection events", (tester) async {
      final onSelected = MockCallback<Set<String>>();

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              SegmentedButton(
                segments: _segments,
                selected: const {"test-0"},
                onSelected: onSelected.call,
                size: WidgetSize.small,
              ),
              SegmentedButton(
                segments: _segments,
                selected: const {"test-0"},
                onSelected: onSelected.call,
              ),
              SegmentedButton(
                segments: _segments,
                selected: const {"test-0"},
                onSelected: onSelected.call,
                size: WidgetSize.large,
                color: WidgetColor.onSurface,
              ),
            ],
          ),
        ),
      );

      final zeroFinder = find.text("0");
      final oneFinder = find.text("1");
      final twoFinder = find.text("2");
      final threeFinder = find.text("3");
      final fourFinder = find.text("4");

      expect(zeroFinder, findsNWidgets(3));
      expect(oneFinder, findsNWidgets(3));
      expect(twoFinder, findsNWidgets(3));
      expect(threeFinder, findsNWidgets(3));
      expect(fourFinder, findsNWidgets(3));

      await tester.tap(oneFinder.at(1));

      verify(() => onSelected.call(const {"test-1"})).called(1);
    });

    test("overrides are compared correctly", () {
      const overrides0 = SegmentedButtonOverrides(iconSize: Dimens.size_16);
      const overrides1 = SegmentedButtonOverrides(iconSize: Dimens.size_16);
      const overrides2 = SegmentedButtonOverrides(iconSize: Dimens.size_12);

      expect(overrides0 == overrides1, true);
      expect(overrides0 == overrides2, false);
    });
  });
}
