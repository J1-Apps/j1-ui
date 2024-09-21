import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";
import "package:catalog/catalog_list_widget.dart";

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CatalogListWidget(
      [
        const CatalogListItem(
          type: CatalogListItemType.column,
          label: "loading indicator",
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JLoadingIndicator(),
              SizedBox(width: 12),
              JLoadingIndicator(label: "loading text"),
            ],
          ),
        ),
        CatalogListItem(
          type: CatalogListItemType.column,
          label: "loading placeholders",
          child: JLoadingProvider(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                JLoadingText(style: context.textTheme().bodyMedium, width: 80),
                const SizedBox(width: 12),
                const JLoadingBox(height: 40, width: 80),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
