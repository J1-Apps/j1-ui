import "package:catalog/catalog_list_widget.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class IconButtonPage extends StatelessWidget {
  const IconButtonPage({super.key});

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
              color: JWidgetColor.tertiary,
            ),
            _buildItem(
              size: JWidgetSize.medium,
              type: JButtonType.flat,
              color: JWidgetColor.tertiary,
            ),
            _buildItem(
              size: JWidgetSize.small,
              type: JButtonType.flat,
              color: JWidgetColor.tertiary,
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
              color: JWidgetColor.tertiary,
              outlineColor: colors.onSurface,
            ),
            _buildItem(
              size: JWidgetSize.medium,
              type: JButtonType.flat,
              color: JWidgetColor.tertiary,
              outlineColor: colors.onSurface,
            ),
            _buildItem(
              size: JWidgetSize.small,
              type: JButtonType.flat,
              color: JWidgetColor.tertiary,
              outlineColor: colors.onSurface,
            ),
          ],
        ),
      ),
    ];

    return CatalogListWidget(children);
  }

  JIconButton _buildItem({
    required JButtonType type,
    required JWidgetSize size,
    required JWidgetColor color,
    Color? outlineColor,
  }) {
    return JIconButton(
      icon: JamIcons.pencil,
      type: type,
      size: size,
      color: color,
      onPressed: () => {},
      overrides: JIconButtonOverrides(outlineColor: outlineColor),
    );
  }
}
