import "package:catalog/catalog_list_widget.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

const _segments = <JButtonSegment>[
  JButtonSegment(id: "test-0", label: Text("0")),
  JButtonSegment(id: "test-1", label: Text("1")),
  JButtonSegment(id: "test-2", label: Text("2")),
  JButtonSegment(id: "test-3", label: Text("3")),
  JButtonSegment(id: "test-4", label: Text("4")),
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
          child: JSegmentedButton(
            segments: _segments,
            selected: selected,
            onSelected: _updateSelected,
            size: JWidgetSize.small,
            showSelectedIcon: true,
          ),
        ),
        CatalogListItem(
          label: "medium",
          type: CatalogListItemType.column,
          child: JSegmentedButton(
            segments: _segments,
            selected: selected,
            onSelected: _updateSelected,
          ),
        ),
        CatalogListItem(
          label: "large",
          type: CatalogListItemType.column,
          child: JSegmentedButton(
            segments: _segments,
            selected: selected,
            onSelected: _updateSelected,
            size: JWidgetSize.large,
          ),
        ),
      ],
    );
  }

  void _updateSelected(Set<String> selected) {
    setState(() => this.selected = selected);
  }
}
