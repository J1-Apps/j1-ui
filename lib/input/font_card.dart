import "package:equatable/equatable.dart";
import "package:flutter/material.dart" hide Card;
import "package:j1_ui/j1_ui.dart";

class FontCardOverrides extends Equatable {
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

  const FontCardOverrides({
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

class FontCard extends StatelessWidget {
  final String fontName;
  final List<TextStyle?> styles;
  final bool isSelected;
  final VoidCallback? onPressed;
  final FontCardOverrides? overrides;

  const FontCard({
    required this.fontName,
    required this.styles,
    this.isSelected = false,
    this.onPressed,
    this.overrides,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < styles.length; i++) {
      children.add(Text(fontName, style: styles[i]?.copyWith(color: overrides?.foregroundColor)));

      if (i + 1 < styles.length) {
        children.add(SizedBox(height: overrides?.spacing ?? 2.0));
      }
    }

    return Card(
      onPressed: onPressed,
      overrides: CardOverrides(
        cornerRadius: overrides?.cornerRadius,
        strokeWidth: isSelected ? overrides?.selectedOutlineWidth : overrides?.outlineWidth,
        elevation: overrides?.elevation,
        foregroundColor: overrides?.foregroundColor,
        backgroundColor: overrides?.backgroundColor,
      ),
      child: Padding(
        padding: overrides?.padding ?? const EdgeInsets.all(Dimens.spacing_s),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: styles
              .map((textStyle) => Text(fontName, style: textStyle?.copyWith(color: overrides?.foregroundColor)))
              .toList(),
        ),
      ),
    );
  }
}
