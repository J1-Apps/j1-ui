import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class Header extends AppBar {
  Header({
    HeaderDimens dimens = const HeaderDimens(),
    Widget? leadingAction,
    String? title,
    TextStyle? titleStyle,
    List<Widget> trailingActions = const [],
    super.primary,
    super.bottom,
    super.backgroundColor,
    super.key,
  }) : super(
          toolbarHeight: dimens.height,
          automaticallyImplyLeading: false,
          leadingWidth: dimens.leadingWidth + dimens.padding.left,
          leading: _getLeading(leadingAction, dimens.padding.left),
          titleSpacing: 0,
          title: _getTitle(title, leadingAction != null, dimens.padding.left, dimens.titleSpacing, titleStyle),
          actions: _getActions(trailingActions, dimens.actionSpacing, dimens.padding.right),
        );
}

Widget? _getLeading(Widget? leading, double padding) {
  if (leading == null) {
    return null;
  }

  return Padding(padding: EdgeInsets.only(left: padding), child: leading);
}

Widget? _getTitle(String? title, bool hasLeading, double padding, double spacing, TextStyle? titleStyle) {
  if (title == null) {
    return null;
  }

  return Padding(
    padding: EdgeInsets.only(left: hasLeading ? spacing : padding, right: spacing),
    child: Text(title, style: titleStyle),
  );
}

List<Widget> _getActions(List<Widget> trailingActions, double spacing, double padding) {
  final actions = <Widget>[];

  for (var i = 0; i < trailingActions.length; i++) {
    actions.add(trailingActions[i]);

    if (i < trailingActions.length - 1) {
      actions.add(SizedBox(width: spacing));
    }
  }

  actions.add(SizedBox(width: padding));
  return actions;
}

class HeaderDimens extends Equatable {
  final double height;
  final double leadingWidth;
  final double titleSpacing;
  final double actionSpacing;
  final EdgeInsets padding;

  const HeaderDimens({
    this.height = Dimens.defaultHeaderHeight,
    this.leadingWidth = 36,
    this.titleSpacing = 12,
    this.actionSpacing = 12,
    this.padding = const EdgeInsets.only(left: Dimens.defaultContentPadding, right: Dimens.defaultContentPadding),
  });

  @override
  List<Object?> get props => [height, leadingWidth, actionSpacing, padding];
}
