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
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "loading placeholders",
        child: LoadingProvider(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoadingText(style: context.textTheme().bodyMedium, width: 80),
              const SizedBox(width: 12),
              const LoadingBox(height: 40, width: 80),
            ],
          ),
        ),
      ),
    ];

    return CatalogListWidget(children);
  }
}
