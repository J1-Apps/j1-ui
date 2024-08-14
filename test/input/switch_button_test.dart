import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/input/switch_button.dart";
import "package:mocktail/mocktail.dart";

import "../helpers/mock_callbacks.dart";
import "../helpers/test_wrapper.dart";

void main() {
  group("Switch Button", () {
    testWidgets("functions as expected", (tester) async {
      const trueKey = Key("true");
      const falseKey = Key("false");

      final trueCallback = MockCallback<bool>();
      final falseCallback = MockCallback<bool>();

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              SwitchButton(
                key: trueKey,
                value: true,
                onChanged: trueCallback.call,
              ),
              SwitchButton(
                key: falseKey,
                value: false,
                onChanged: falseCallback.call,
              ),
            ],
          ),
        ),
      );

      final trueFinder = find.byKey(trueKey);
      final falseFinder = find.byKey(falseKey);

      expect(trueFinder, findsOneWidget);
      expect(falseFinder, findsOneWidget);

      await tester.tap(trueFinder);
      await tester.tap(falseFinder);

      verify(() => trueCallback(false)).called(1);
      verify(() => falseCallback(true)).called(1);
    });

    test("overrides are compared correctly", () {
      const overrides0 = SwitchButtonOverrides(activeColor: Colors.black);
      const overrides1 = SwitchButtonOverrides(activeColor: Colors.black);
      const overrides2 = SwitchButtonOverrides(activeColor: Colors.blue);

      expect(overrides0 == overrides1, true);
      expect(overrides0 == overrides2, false);
    });
  });
}
