import "package:flutter/material.dart";
import "package:catalog/catalog_list_widget.dart";
import "package:j1_ui/j1_ui.dart";

class MiscInputPage extends StatelessWidget {
  const MiscInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fonts = context.textTheme();

    return CatalogListWidget(
      [
        CatalogListItem(
          type: CatalogListItemType.column,
          label: "switch button",
          child: JSwitchButton(
            value: false,
            onChanged: (_) {},
          ),
        ),
        CatalogListItem(
          type: CatalogListItemType.column,
          label: "switch button",
          child: JSwitchButton(
            value: true,
            onChanged: (_) {},
          ),
        ),
        CatalogListItem(
          type: CatalogListItemType.column,
          label: "font card",
          child: JFontCard(
            fontName: "test font",
            styles: [fonts.headlineMedium, fonts.titleMedium, fonts.bodyMedium],
          ),
        ),
        CatalogListItem(
          type: CatalogListItemType.column,
          label: "theme card",
          child: JThemeCard(
            themeName: "test theme",
            colors: context.colorScheme(),
            fonts: context.textTheme(),
          ),
        ),
      ],
    );
  }
}
