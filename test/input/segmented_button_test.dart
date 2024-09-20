import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";
import "package:mocktail/mocktail.dart";

import "../helpers/mock_callbacks.dart";
import "../helpers/test_wrapper.dart";

const _segments = <JButtonSegment>[
  JButtonSegment(id: "test-0", label: Text("0")),
  JButtonSegment(id: "test-1", label: Text("1")),
  JButtonSegment(id: "test-2", label: Text("2")),
  JButtonSegment(id: "test-3", label: Text("3")),
  JButtonSegment(id: "test-4", label: Text("4")),
];

void main() {
  group("Segmented Button", () {
    testWidgets("handles selection events", (tester) async {
      final onSelected = MockCallback<Set<String>>();

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              JSegmentedButton(
                segments: _segments,
                selected: const {"test-0"},
                onSelected: onSelected.call,
                size: JWidgetSize.small,
              ),
              JSegmentedButton(
                segments: _segments,
                selected: const {"test-0"},
                onSelected: onSelected.call,
              ),
              JSegmentedButton(
                segments: _segments,
                selected: const {"test-0"},
                onSelected: onSelected.call,
                size: JWidgetSize.large,
                color: JWidgetColor.onSurface,
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
      const overrides0 = JSegmentedButtonOverrides(iconSize: JDimens.size_16);
      const overrides1 = JSegmentedButtonOverrides(iconSize: JDimens.size_16);
      const overrides2 = JSegmentedButtonOverrides(iconSize: JDimens.size_12);

      expect(overrides0 == overrides1, true);
      expect(overrides0 == overrides2, false);
    });
  });
}
