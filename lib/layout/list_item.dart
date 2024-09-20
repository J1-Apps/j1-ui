import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class JListItem extends StatelessWidget {
  final EdgeInsets padding;
  final double spacing;
  final VoidCallback? onPressed;
  final List<Widget> children;

  const JListItem({
    this.padding = const EdgeInsets.all(JDimens.spacing_s),
    this.spacing = JDimens.spacing_xl,
    this.onPressed,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _getItems(children, spacing),
        ),
      ),
    );
  }
}

List<Widget> _getItems(List<Widget> items, double spacing) {
  final actions = <Widget>[];

  for (var i = 0; i < items.length; i++) {
    actions.add(items[i]);

    if (i < items.length - 1) {
      actions.add(SizedBox(width: spacing));
    }
  }

  return actions;
}
