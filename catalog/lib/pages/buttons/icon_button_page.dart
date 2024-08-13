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
              size: IconButtonDimens.large,
              type: IconButtonType.filled,
              color: WidgetColor.primary,
            ),
            _buildItem(
              size: IconButtonDimens.medium,
              type: IconButtonType.filled,
              color: WidgetColor.secondary,
            ),
            _buildItem(
              size: IconButtonDimens.small,
              type: IconButtonType.filled,
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
              size: IconButtonDimens.large,
              type: IconButtonType.filled,
              color: WidgetColor.primary,
              outlineColor: colors.onSurface,
            ),
            _buildItem(
              size: IconButtonDimens.medium,
              type: IconButtonType.filled,
              color: WidgetColor.secondary,
              outlineColor: colors.onSurface,
            ),
            _buildItem(
              size: IconButtonDimens.small,
              type: IconButtonType.filled,
              color: WidgetColor.tertiary,
              outlineColor: colors.onSurface,
            ),
          ],
        ),
      ),
      CatalogListItem(
        label: "simple",
        type: CatalogListItemType.column,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItem(
              size: IconButtonDimens.large,
              type: IconButtonType.flat,
              color: WidgetColor.tertiary,
            ),
            _buildItem(
              size: IconButtonDimens.medium,
              type: IconButtonType.flat,
              color: WidgetColor.tertiary,
            ),
            _buildItem(
              size: IconButtonDimens.small,
              type: IconButtonType.flat,
              color: WidgetColor.tertiary,
            ),
          ],
        ),
      ),
      CatalogListItem(
        label: "simple outline",
        type: CatalogListItemType.column,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItem(
              size: IconButtonDimens.large,
              type: IconButtonType.flat,
              color: WidgetColor.tertiary,
              outlineColor: colors.onSurface,
            ),
            _buildItem(
              size: IconButtonDimens.medium,
              type: IconButtonType.flat,
              color: WidgetColor.tertiary,
              outlineColor: colors.onSurface,
            ),
            _buildItem(
              size: IconButtonDimens.small,
              type: IconButtonType.flat,
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
    required IconButtonType type,
    required IconButtonDimens size,
    required WidgetColor color,
    Color? outlineColor,
  }) {
    return IconButton(
      icon: JamIcons.pencil,
      type: type,
      size: size,
      color: color,
      onPressed: () => {},
      outlineColor: outlineColor,
    );
  }
}
