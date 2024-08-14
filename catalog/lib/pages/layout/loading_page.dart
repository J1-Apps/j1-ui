import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";
import "package:catalog/catalog_list_widget.dart";

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      const CatalogListItem(
        type: CatalogListItemType.column,
        label: "loading indicator",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoadingIndicator(),
            SizedBox(width: 12),
            LoadingIndicator(label: "loading text"),
          ],
        ),
      ),
    ];

    return CatalogListWidget(children);
  }
}
