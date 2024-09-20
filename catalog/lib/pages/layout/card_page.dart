import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";
import "package:catalog/catalog_list_widget.dart";

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      const CatalogListItem(
        type: CatalogListItemType.column,
        label: "card large",
        child: SizedBox(
          height: 80,
          child: JCard(
            size: JWidgetSize.large,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text("large card"),
            ),
          ),
        ),
      ),
      const CatalogListItem(
        type: CatalogListItemType.column,
        label: "card medium",
        child: SizedBox(
          height: 80,
          child: JCard(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text("medium card"),
            ),
          ),
        ),
      ),
      const CatalogListItem(
        type: CatalogListItemType.column,
        label: "card small",
        child: SizedBox(
          height: 80,
          child: JCard(
            size: JWidgetSize.small,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text("small card"),
            ),
          ),
        ),
      ),
    ];

    return CatalogListWidget(children);
  }
}
