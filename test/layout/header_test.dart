import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";

void main() {
  testWidgets("Header renders with all elements", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: Header(
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

  testWidgets("Header renders with no leading", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: Header(
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

  testWidgets("Header renders with no actions", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: Header(
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

  test("Header dimens is compared correctly", () {
    const dimens0 = HeaderDimens.medium;
    const dimens1 = HeaderDimens.medium;
    final dimens2 = HeaderDimens.medium.copyWith(titleSpacing: Dimens.size_16);

    expect(dimens0 == dimens1, true);
    expect(dimens0 == dimens2, false);
  });
}
