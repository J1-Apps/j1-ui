import "package:catalog/catalog_list_widget.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class ErrorMessagePage extends StatelessWidget {
  const ErrorMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CatalogListWidget(
      [
        CatalogListItem(
          type: CatalogListItemType.column,
          label: "error message",
          child: JErrorMessage(
            title: "Test Error",
            message: "Test error message.",
            cta: "action",
            ctaAction: () {},
          ),
        ),
        const CatalogListItem(
          type: CatalogListItemType.column,
          label: "error message",
          child: JErrorMessage(
            message: "Test error message.",
          ),
        ),
      ],
    );
  }
}
