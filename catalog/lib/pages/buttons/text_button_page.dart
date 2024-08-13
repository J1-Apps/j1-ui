import "package:catalog/catalog_list_widget.dart";
import "package:flutter/material.dart" hide TextButton;
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
              size: TextButtonDimens.large,
              type: TextButtonType.filled,
              color: WidgetColor.primary,
              icon: JamIcons.pencil,
            ),
            _buildItem(
              size: TextButtonDimens.medium,
              type: TextButtonType.filled,
              color: WidgetColor.secondary,
            ),
            _buildItem(
              size: TextButtonDimens.small,
              type: TextButtonType.filled,
              color: WidgetColor.tertiary,
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
              size: TextButtonDimens.large,
              type: TextButtonType.filled,
              color: WidgetColor.primary,
              outlineColor: colors.onSurface,
            ),
            _buildItem(
              size: TextButtonDimens.medium,
              type: TextButtonType.filled,
              color: WidgetColor.secondary,
              outlineColor: colors.onSurface,
              icon: JamIcons.pencil,
            ),
            _buildItem(
              size: TextButtonDimens.small,
              type: TextButtonType.filled,
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
              size: TextButtonDimens.large,
              type: TextButtonType.flat,
              color: WidgetColor.tertiary,
              icon: JamIcons.pencil,
            ),
            _buildItem(
              size: TextButtonDimens.medium,
              type: TextButtonType.flat,
              color: WidgetColor.tertiary,
            ),
            _buildItem(
              size: TextButtonDimens.small,
              type: TextButtonType.flat,
              color: WidgetColor.tertiary,
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
              size: TextButtonDimens.large,
              type: TextButtonType.flat,
              color: WidgetColor.tertiary,
              outlineColor: colors.onSurface,
            ),
            _buildItem(
              size: TextButtonDimens.medium,
              type: TextButtonType.flat,
              color: WidgetColor.tertiary,
              outlineColor: colors.onSurface,
              icon: JamIcons.pencil,
            ),
            _buildItem(
              size: TextButtonDimens.small,
              type: TextButtonType.flat,
              color: WidgetColor.tertiary,
              outlineColor: colors.onSurface,
            ),
          ],
        ),
      ),
    ];

    return CatalogListWidget(children);
  }

  TextButton _buildItem({
    required TextButtonType type,
    required TextButtonDimens size,
    required WidgetColor color,
    IconData? icon,
    Color? outlineColor,
  }) {
    return TextButton(
      text: "test",
      icon: icon,
      type: type,
      size: size,
      color: color,
      onPressed: () => {},
      outlineColor: outlineColor,
    );
  }
}
