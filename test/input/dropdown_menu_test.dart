import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";
import "package:mocktail/mocktail.dart";

import "../helpers/mock_callbacks.dart";
import "../helpers/test_wrapper.dart";

void main() {
  group("Dropdown Menu", () {
    testWidgets("outlined dropdown menu can be selected", (tester) async {
      final onSelected = MockCallback<String>();

      await tester.pumpWidget(
        TestWrapper(
          child: JDropdownMenu(
            entries: const [
              JDropdownMenuEntry(value: "0", label: "Zero", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "1", label: "One", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "2", label: "Two", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "3", label: "Three", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "4", label: "Four", leadingIcon: Icon(JamIcons.basketball)),
            ],
            size: JWidgetSize.small,
            onSelected: onSelected.call,
          ),
        ),
      );

      final expand = find.byIcon(JamIcons.chevrondown);
      final collapse = find.byIcon(JamIcons.chevronup);
      final option = find.text("Two");

      expect(expand, findsNWidgets(2));
      expect(collapse, findsNothing);
      await tester.tap(expand.first);
      await tester.pumpAndSettle();

      expect(expand, findsNothing);
      expect(collapse, findsNWidgets(2));

      await tester.tap(option.last);
      await tester.pumpAndSettle();

      verify(() => onSelected("2")).called(1);
    });

    testWidgets("underlined dropdown menu can be selected", (tester) async {
      final onSelected = MockCallback<String>();

      await tester.pumpWidget(
        TestWrapper(
          child: JDropdownMenu(
            entries: const [
              JDropdownMenuEntry(value: "0", label: "Zero", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "1", label: "One", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "2", label: "Two", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "3", label: "Three", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "4", label: "Four", leadingIcon: Icon(JamIcons.basketball)),
            ],
            type: JTextFieldType.underlined,
            overrides: const JDropdownMenuOverrides(menuStrokeWidth: 2),
            onSelected: onSelected.call,
          ),
        ),
      );

      final expand = find.byIcon(JamIcons.chevrondown);
      final collapse = find.byIcon(JamIcons.chevronup);
      final option = find.text("Two");

      expect(expand, findsNWidgets(2));
      expect(collapse, findsNothing);
      await tester.tap(expand.first);
      await tester.pumpAndSettle();

      expect(expand, findsNothing);
      expect(collapse, findsNWidgets(2));

      await tester.tap(option.last);
      await tester.pumpAndSettle();

      verify(() => onSelected("2")).called(1);
    });

    testWidgets("flat dropdown menu can be selected", (tester) async {
      final onSelected = MockCallback<String>();

      await tester.pumpWidget(
        TestWrapper(
          child: JDropdownMenu(
            entries: const [
              JDropdownMenuEntry(value: "0", label: "Zero", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "1", label: "One", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "2", label: "Two", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "3", label: "Three", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "4", label: "Four", leadingIcon: Icon(JamIcons.basketball)),
            ],
            type: JTextFieldType.flat,
            size: JWidgetSize.large,
            onSelected: onSelected.call,
          ),
        ),
      );

      final expand = find.byIcon(JamIcons.chevrondown);
      final collapse = find.byIcon(JamIcons.chevronup);
      final option = find.text("Two");

      expect(expand, findsNWidgets(2));
      expect(collapse, findsNothing);
      await tester.tap(expand.first);
      await tester.pumpAndSettle();

      expect(expand, findsNothing);
      expect(collapse, findsNWidgets(2));

      await tester.tap(option.last);
      await tester.pumpAndSettle();

      verify(() => onSelected("2")).called(1);
    });

    testWidgets("dropdown menu can be searched", (tester) async {
      final onSelected = MockCallback<String>();

      await tester.pumpWidget(
        TestWrapper(
          child: JDropdownMenu(
            entries: const [
              JDropdownMenuEntry(value: "0", label: "Zero", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "1", label: "One", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "2", label: "Two", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "3", label: "Three", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "4", label: "Four", leadingIcon: Icon(JamIcons.basketball)),
            ],
            requestFocusOnTap: true,
            onSelected: onSelected.call,
            searchCallback: (entries, quert) => 2,
          ),
        ),
      );

      final expand = find.byIcon(JamIcons.chevrondown);
      final field = find.byType(TextField);

      await tester.tap(expand.first);
      await tester.pumpAndSettle();

      await tester.enterText(field, "T");
    });

    testWidgets("dropdown menu can be filtered", (tester) async {
      final onSelected = MockCallback<String>();

      await tester.pumpWidget(
        TestWrapper(
          child: JDropdownMenu(
            entries: const [
              JDropdownMenuEntry(value: "0", label: "Zero", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "1", label: "One", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "2", label: "Two", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "3", label: "Three", leadingIcon: Icon(JamIcons.basketball)),
              JDropdownMenuEntry(value: "4", label: "Four", leadingIcon: Icon(JamIcons.basketball)),
            ],
            requestFocusOnTap: true,
            onSelected: onSelected.call,
            enableSearch: false,
            enableFilter: true,
            filterCallback: (entries, query) => entries.where((entry) => entry.label.contains(query)).toList(),
          ),
        ),
      );

      final expand = find.byIcon(JamIcons.chevrondown);
      final field = find.byType(TextField);

      await tester.tap(expand.first);
      await tester.pumpAndSettle();

      await tester.enterText(field, "T");
      await tester.pumpAndSettle();

      expect(find.text("Zero"), findsOneWidget);
      expect(find.text("One"), findsOneWidget);
      expect(find.text("Two"), findsNWidgets(2));
      expect(find.text("Three"), findsNWidgets(2));
      expect(find.text("Four"), findsOneWidget);
    });

    test("overrides are compared correctly", () {
      const overrides0 = JDropdownMenuOverrides(iconSize: JDimens.size_16);
      const overrides1 = JDropdownMenuOverrides(iconSize: JDimens.size_16);
      const overrides2 = JDropdownMenuOverrides(iconSize: JDimens.size_12);

      expect(overrides0 == overrides1, true);
      expect(overrides0 == overrides2, false);
    });

    test("entry overrides are compared correctly", () {
      const overrides0 = JDropdownMenuEntryOverrides(iconSize: JDimens.size_16);
      const overrides1 = JDropdownMenuEntryOverrides(iconSize: JDimens.size_16);
      const overrides2 = JDropdownMenuEntryOverrides(iconSize: JDimens.size_12);

      expect(overrides0 == overrides1, true);
      expect(overrides0 == overrides2, false);
    });
  });
}
