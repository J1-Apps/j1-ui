import "package:catalog/catalog_list_widget.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "outlined large",
        child: JTextField(
          hint: "test",
          size: JWidgetSize.large,
          icon: JamIcons.pencil,
          onIconPressed: () {},
        ),
      ),
      const CatalogListItem(
        type: CatalogListItemType.column,
        label: "outlined medium",
        child: JTextField(
          hint: "test",
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "outlined small",
        child: JTextField(
          hint: "test",
          size: JWidgetSize.small,
          icon: JamIcons.pencil,
          onIconPressed: () {},
        ),
      ),
      const CatalogListItem(
        type: CatalogListItemType.column,
        label: "underlined large",
        child: JTextField(
          type: JTextFieldType.underlined,
          hint: "test",
          size: JWidgetSize.large,
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "underlined medium",
        child: JTextField(
          type: JTextFieldType.underlined,
          hint: "test",
          icon: JamIcons.pencil,
          onIconPressed: () {},
        ),
      ),
      const CatalogListItem(
        type: CatalogListItemType.column,
        label: "underlined small",
        child: JTextField(
          type: JTextFieldType.underlined,
          hint: "test",
          size: JWidgetSize.small,
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "flat large",
        child: JTextField(
          type: JTextFieldType.flat,
          hint: "test",
          size: JWidgetSize.large,
          icon: JamIcons.pencil,
          onIconPressed: () {},
        ),
      ),
      const CatalogListItem(
        type: CatalogListItemType.column,
        label: "flat medium",
        child: JTextField(
          type: JTextFieldType.flat,
          hint: "test",
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "flat small",
        child: JTextField(
          type: JTextFieldType.flat,
          hint: "test",
          size: JWidgetSize.small,
          icon: JamIcons.pencil,
          onIconPressed: () {},
        ),
      ),
    ];

    return CatalogListWidget(children);
  }
}
