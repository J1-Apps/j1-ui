import "package:catalog/catalog_list_widget.dart";
import "package:flutter/material.dart" hide SegmentedButton, ButtonSegment;
import "package:j1_ui/j1_ui.dart";

const _segments = <ButtonSegment>[
  ButtonSegment(id: "test-0", label: Text("0")),
  ButtonSegment(id: "test-1", label: Text("1")),
  ButtonSegment(id: "test-2", label: Text("2")),
  ButtonSegment(id: "test-3", label: Text("3")),
  ButtonSegment(id: "test-4", label: Text("4")),
];

class SegmentedButtonPage extends StatefulWidget {
  const SegmentedButtonPage({super.key});

  @override
  State<StatefulWidget> createState() => SegmentedButtonPageState();
}

class SegmentedButtonPageState extends State<SegmentedButtonPage> {
  var selected = {"test-0"};

  @override
  Widget build(BuildContext context) {
    return CatalogListWidget(
      [
        CatalogListItem(
          label: "small",
          type: CatalogListItemType.column,
          child: SegmentedButton(
            segments: _segments,
            selected: selected,
            onSelected: _updateSelected,
            size: WidgetSize.small,
            showSelectedIcon: true,
          ),
        ),
        CatalogListItem(
          label: "medium",
          type: CatalogListItemType.column,
          child: SegmentedButton(
            segments: _segments,
            selected: selected,
            onSelected: _updateSelected,
          ),
        ),
        CatalogListItem(
          label: "large",
          type: CatalogListItemType.column,
          child: SegmentedButton(
            segments: _segments,
            selected: selected,
            onSelected: _updateSelected,
            size: WidgetSize.large,
          ),
        ),
      ],
    );
  }

  void _updateSelected(Set<String> selected) {
    setState(() => this.selected = selected);
  }
}
