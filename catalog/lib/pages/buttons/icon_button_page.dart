import "package:catalog/catalog_list_widget.dart";
import "package:flutter/material.dart" hide IconButton;
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
              size: WidgetSize.large,
              type: ButtonType.filled,
              color: WidgetColor.primary,
            ),
            _buildItem(
              size: WidgetSize.medium,
              type: ButtonType.filled,
              color: WidgetColor.secondary,
            ),
            _buildItem(
              size: WidgetSize.small,
              type: ButtonType.filled,
              color: WidgetColor.tertiary,
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
              size: WidgetSize.large,
              type: ButtonType.filled,
              color: WidgetColor.primary,
              outlineColor: colors.onSurface,
            ),
            _buildItem(
              size: WidgetSize.medium,
              type: ButtonType.filled,
              color: WidgetColor.secondary,
              outlineColor: colors.onSurface,
            ),
            _buildItem(
              size: WidgetSize.small,
              type: ButtonType.filled,
              color: WidgetColor.tertiary,
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
              size: WidgetSize.large,
              type: ButtonType.flat,
              color: WidgetColor.tertiary,
            ),
            _buildItem(
              size: WidgetSize.medium,
              type: ButtonType.flat,
              color: WidgetColor.tertiary,
            ),
            _buildItem(
              size: WidgetSize.small,
              type: ButtonType.flat,
              color: WidgetColor.tertiary,
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
              size: WidgetSize.large,
              type: ButtonType.flat,
              color: WidgetColor.tertiary,
              outlineColor: colors.onSurface,
            ),
            _buildItem(
              size: WidgetSize.medium,
              type: ButtonType.flat,
              color: WidgetColor.tertiary,
              outlineColor: colors.onSurface,
            ),
            _buildItem(
              size: WidgetSize.small,
              type: ButtonType.flat,
              color: WidgetColor.tertiary,
              outlineColor: colors.onSurface,
            ),
          ],
        ),
      ),
    ];

    return CatalogListWidget(children);
  }

  IconButton _buildItem({
    required ButtonType type,
    required WidgetSize size,
    required WidgetColor color,
    Color? outlineColor,
  }) {
    return IconButton(
      icon: JamIcons.pencil,
      type: type,
      size: size,
      color: color,
      onPressed: () => {},
      overrides: IconButtonOverrides(outlineColor: outlineColor),
    );
  }
}
