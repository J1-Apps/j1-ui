import "package:flutter/material.dart";
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
        child: JIconButton(
          icon: JamIcons.pencil,
          type: JButtonType.flat,
          onPressed: () => context.showJDialog(
            child: const Padding(
              padding: EdgeInsets.all(JDimens.spacing_xl),
              child: Text("test dialog content"),
            ),
          ),
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "toast",
        child: JIconButton(
          icon: JamIcons.pencil,
          type: JButtonType.flat,
          onPressed: () => context.showJToastWithText(
            text: "test toast content",
            hasClose: true,
          ),
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "bottom sheet",
        child: JIconButton(
          icon: JamIcons.pencil,
          type: JButtonType.flat,
          onPressed: () => context.showJBottomSheet(
            child: const Padding(
              padding: EdgeInsets.all(JDimens.spacing_xl),
              child: Text("test bottom sheet content"),
            ),
          ),
        ),
      ),
    ];

    return CatalogListWidget(children);
  }
}
