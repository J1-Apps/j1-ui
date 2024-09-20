import "package:catalog/catalog_list_widget.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class TextButtonPage extends StatelessWidget {
  const TextButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final children = [
      CatalogListItem(
        label: "filled",
        type: CatalogListItemType.column,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItem(
              size: JWidgetSize.large,
              type: JButtonType.filled,
              color: JWidgetColor.primary,
              icon: JamIcons.pencil,
            ),
            _buildItem(
              size: JWidgetSize.medium,
              type: JButtonType.filled,
              color: JWidgetColor.secondary,
            ),
            _buildItem(
              size: JWidgetSize.small,
              type: JButtonType.filled,
              color: JWidgetColor.tertiary,
              icon: JamIcons.pencil,
            ),
          ],
        ),
      ),
      CatalogListItem(
        label: "filled outlined",
        type: CatalogListItemType.column,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItem(
              size: JWidgetSize.large,
              type: JButtonType.filled,
              color: JWidgetColor.primary,
              outlineColor: colors.onSurface,
            ),
            _buildItem(
              size: JWidgetSize.medium,
              type: JButtonType.filled,
              color: JWidgetColor.secondary,
              outlineColor: colors.onSurface,
              icon: JamIcons.pencil,
            ),
            _buildItem(
              size: JWidgetSize.small,
              type: JButtonType.filled,
              color: JWidgetColor.tertiary,
              outlineColor: colors.onSurface,
            ),
          ],
        ),
      ),
      CatalogListItem(
        label: "flat",
        type: CatalogListItemType.column,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItem(
              size: JWidgetSize.large,
              type: JButtonType.flat,
              color: JWidgetColor.onSurface,
              icon: JamIcons.pencil,
            ),
            _buildItem(
              size: JWidgetSize.medium,
              type: JButtonType.flat,
              color: JWidgetColor.onSurface,
            ),
            _buildItem(
              size: JWidgetSize.small,
              type: JButtonType.flat,
              color: JWidgetColor.onSurface,
              icon: JamIcons.pencil,
            ),
          ],
        ),
      ),
      CatalogListItem(
        label: "flat outline",
        type: CatalogListItemType.column,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItem(
              size: JWidgetSize.large,
              type: JButtonType.flat,
              color: JWidgetColor.onSurface,
            ),
            _buildItem(
              size: JWidgetSize.medium,
              type: JButtonType.flat,
              color: JWidgetColor.onSurface,
              icon: JamIcons.pencil,
            ),
            _buildItem(
              size: JWidgetSize.small,
              type: JButtonType.flat,
              color: JWidgetColor.onSurface,
            ),
          ],
        ),
      ),
    ];

    return CatalogListWidget(children);
  }

  JTextButton _buildItem({
    required JButtonType type,
    required JWidgetSize size,
    required JWidgetColor color,
    IconData? icon,
    Color? outlineColor,
  }) {
    return JTextButton(
      text: "test",
      icon: icon,
      type: type,
      size: size,
      color: color,
      onPressed: () => {},
      overrides: JTextButtonOverrides(outlineColor: outlineColor),
    );
  }
}
