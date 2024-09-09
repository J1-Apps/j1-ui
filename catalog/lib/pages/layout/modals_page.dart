import "package:flutter/material.dart" hide IconButton;
import "package:j1_ui/j1_ui.dart";
import "package:catalog/catalog_list_widget.dart";

class ModalsPage extends StatelessWidget {
  const ModalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "dialog",
        child: IconButton(
          icon: JamIcons.pencil,
          type: ButtonType.flat,
          onPressed: () => context.showDialog(
            child: const Padding(
              padding: EdgeInsets.all(Dimens.spacing_xl),
              child: Text("test dialog content"),
            ),
          ),
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "toast",
        child: IconButton(
          icon: JamIcons.pencil,
          type: ButtonType.flat,
          onPressed: () => context.showToastWithText(
            text: "test toast content",
            hasClose: true,
          ),
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "bottom sheet",
        child: IconButton(
          icon: JamIcons.pencil,
          type: ButtonType.flat,
          onPressed: () => context.showBottomSheet(
            child: const Padding(
              padding: EdgeInsets.all(Dimens.spacing_xl),
              child: Text("test bottom sheet content"),
            ),
          ),
        ),
      ),
    ];

    return CatalogListWidget(children);
  }
}
