import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class JAppBar extends AppBar {
  JAppBar({
    JAppBarDimens dimens = JAppBarDimens.medium,
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

class JAppBarDimens extends Equatable {
  final double height;
  final double leadingWidth;
  final double titleSpacing;
  final double actionSpacing;
  final EdgeInsets padding;

  static const medium = JAppBarDimens._(
    height: 72,
    leadingWidth: 36,
    titleSpacing: JDimens.spacing_s,
    actionSpacing: JDimens.spacing_s,
    padding: EdgeInsets.only(left: JDimens.spacing_m, right: JDimens.spacing_m),
  );

  const JAppBarDimens._({
    required this.height,
    required this.leadingWidth,
    required this.titleSpacing,
    required this.actionSpacing,
    required this.padding,
  });

  JAppBarDimens copyWith({
    double? height,
    double? leadingWidth,
    double? titleSpacing,
    double? actionSpacing,
    EdgeInsets? padding,
  }) {
    return JAppBarDimens._(
      height: height ?? this.height,
      leadingWidth: leadingWidth ?? this.leadingWidth,
      titleSpacing: titleSpacing ?? this.titleSpacing,
      actionSpacing: actionSpacing ?? this.actionSpacing,
      padding: padding ?? this.padding,
    );
  }

  @override
  List<Object?> get props => [
        height,
        leadingWidth,
        titleSpacing,
        actionSpacing,
        padding,
      ];
}
