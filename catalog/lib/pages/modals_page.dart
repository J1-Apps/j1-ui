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
        label: "modal dialog",
        child: IconButton(
          icon: JamIcons.pencil,
          type: ButtonType.flat,
          onPressed: () => context.showModalDialog(
            child: const Padding(
              padding: EdgeInsets.all(Dimens.spacing_xl),
              child: Text("test dialog content"),
            ),
          ),
        ),
      ),
    ];

    return CatalogListWidget(children);
  }
}
