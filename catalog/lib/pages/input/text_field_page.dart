import "package:catalog/catalog_list_widget.dart";
import "package:flutter/material.dart" hide TextField;
import "package:j1_ui/j1_ui.dart";

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "outlined large",
        child: TextField(
          hint: "test",
          size: WidgetSize.large,
          icon: JamIcons.pencil,
          onIconPressed: () {},
        ),
      ),
      const CatalogListItem(
        type: CatalogListItemType.column,
        label: "outlined medium",
        child: TextField(
          hint: "test",
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "outlined small",
        child: TextField(
          hint: "test",
          size: WidgetSize.small,
          icon: JamIcons.pencil,
          onIconPressed: () {},
        ),
      ),
      const CatalogListItem(
        type: CatalogListItemType.column,
        label: "underlined large",
        child: TextField(
          type: TextFieldType.underlined,
          hint: "test",
          size: WidgetSize.large,
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "underlined medium",
        child: TextField(
          type: TextFieldType.underlined,
          hint: "test",
          icon: JamIcons.pencil,
          onIconPressed: () {},
        ),
      ),
      const CatalogListItem(
        type: CatalogListItemType.column,
        label: "underlined small",
        child: TextField(
          type: TextFieldType.underlined,
          hint: "test",
          size: WidgetSize.small,
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "flat large",
        child: TextField(
          type: TextFieldType.flat,
          hint: "test",
          size: WidgetSize.large,
          icon: JamIcons.pencil,
          onIconPressed: () {},
        ),
      ),
      const CatalogListItem(
        type: CatalogListItemType.column,
        label: "flat medium",
        child: TextField(
          type: TextFieldType.flat,
          hint: "test",
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "flat small",
        child: TextField(
          type: TextFieldType.flat,
          hint: "test",
          size: WidgetSize.small,
          icon: JamIcons.pencil,
          onIconPressed: () {},
        ),
      ),
    ];

    return CatalogListWidget(children);
  }
}
