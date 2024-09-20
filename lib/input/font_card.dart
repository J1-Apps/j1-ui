import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class JFontCardOverrides extends Equatable {
  final EdgeInsets? padding;
  final double? cornerRadius;
  final double? elevation;
  final double? spacing;

  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? outlineColor;
  final Color? selectedOutlineColor;
  final double? outlineWidth;
  final double? selectedOutlineWidth;

  const JFontCardOverrides({
    this.padding,
    this.cornerRadius,
    this.elevation,
    this.spacing,
    this.foregroundColor,
    this.backgroundColor,
    this.outlineColor,
    this.selectedOutlineColor,
    this.outlineWidth,
    this.selectedOutlineWidth,
  });

  @override
  List<Object?> get props => [
        padding,
        cornerRadius,
        elevation,
        spacing,
        foregroundColor,
        backgroundColor,
        outlineColor,
        selectedOutlineColor,
        outlineWidth,
        selectedOutlineWidth,
      ];
}

class JFontCard extends StatelessWidget {
  final String fontName;
  final List<TextStyle?> styles;
  final bool isSelected;
  final VoidCallback? onPressed;
  final JFontCardOverrides? overrides;

  const JFontCard({
    required this.fontName,
    required this.styles,
    this.isSelected = false,
    this.onPressed,
    this.overrides,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedWidth = overrides?.selectedOutlineWidth ?? J1Config.selectedStrokeWidth;

    return JCard(
      onPressed: onPressed,
      overrides: JCardOverrides(
        cornerRadius: overrides?.cornerRadius,
        strokeWidth: isSelected ? selectedWidth : overrides?.outlineWidth,
        elevation: overrides?.elevation,
        foregroundColor: overrides?.foregroundColor,
        backgroundColor: overrides?.backgroundColor,
      ),
      child: Padding(
        padding: overrides?.padding ?? const EdgeInsets.all(JDimens.spacing_s),
        child: JFontColumn(
          text: fontName,
          styles: styles,
          spacing: overrides?.spacing ?? JDimens.spacing_xxxs,
          color: overrides?.foregroundColor,
        ),
      ),
    );
  }
}

class JFontColumn extends StatelessWidget {
  final String text;
  final List<TextStyle?> styles;
  final double spacing;
  final Color? color;

  const JFontColumn({
    required this.text,
    required this.styles,
    required this.spacing,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < styles.length; i++) {
      children.add(Text(text, style: styles[i]?.copyWith(color: color)));

      if (i + 1 < styles.length) {
        children.add(SizedBox(height: spacing));
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
