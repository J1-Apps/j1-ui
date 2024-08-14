import "package:flutter/material.dart" hide Card;
import "package:catalog/catalog_list_widget.dart";
import "package:j1_ui/j1_ui.dart";

class MiscInputPage extends StatelessWidget {
  const MiscInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "switch button",
        child: SwitchButton(
          value: false,
          onChanged: (_) {},
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "switch button",
        child: SwitchButton(
          value: true,
          onChanged: (_) {},
        ),
      ),
    ];

    return CatalogListWidget(children);
  }
}