import "package:flutter/material.dart" hide IconButton;
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";

import "../helpers/test_wrapper.dart";

void main() {
  group("Bottom Sheet", () {
    testWidgets("renders child", (tester) async {
      tester.view.physicalSize = const Size(600, 1200);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => IconButton(
              icon: JamIcons.pencil,
              type: ButtonType.flat,
              onPressed: () => context.showBottomSheet(
                overrides: const BottomSheetOverrides(),
                child: const Text("test bottom sheet content"),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(BottomSheet), findsNothing);
      expect(find.text("test bottom sheet content"), findsNothing);

      await tester.tap(find.byIcon(JamIcons.pencil));
      await tester.pumpAndSettle();

      expect(find.byType(BottomSheet), findsOneWidget);
      expect(find.text("test bottom sheet content"), findsOneWidget);
    });

    testWidgets("doesn't render with no child", (tester) async {
      tester.view.physicalSize = const Size(600, 1200);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => IconButton(
              icon: JamIcons.pencil,
              type: ButtonType.flat,
              onPressed: () => context.showBottomSheet(child: null),
            ),
          ),
        ),
      );

      expect(find.byType(BottomSheet), findsNothing);

      await tester.tap(find.byIcon(JamIcons.pencil));
      await tester.pumpAndSettle();

      expect(find.byType(BottomSheet), findsNothing);
    });

    test("overrides are compared correctly", () {
      const overrides0 = BottomSheetOverrides(cornerRadius: Dimens.radius_l);
      const overrides1 = BottomSheetOverrides(cornerRadius: Dimens.radius_l);
      const overrides2 = BottomSheetOverrides(cornerRadius: Dimens.radius_xl);

      expect(overrides0 == overrides1, true);
      expect(overrides0 == overrides2, false);
    });
  });
}
