import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class LoadingIndicator extends StatelessWidget {
  final String? label;
  final double? size;
  final double? spacing;
  final double? strokeWidth;
  final Color? color;
  final TextStyle? textStyle;

  const LoadingIndicator({
    this.label,
    this.size,
    this.spacing,
    this.strokeWidth,
    this.color,
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme();

    final indicatorSize = size ?? 24.0;

    final progress = SizedBox(
      width: indicatorSize,
      height: indicatorSize,
      child: CircularProgressIndicator(
        color: color ?? theme.colorScheme.tertiary,
        strokeWidth: strokeWidth ?? 2.0,
        semanticsLabel: label,
      ),
    );

    if (label == null) {
      return progress;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label!, style: textStyle ?? theme.textTheme.bodyMedium),
        SizedBox(height: spacing ?? Dimens.spacing_m),
        progress,
      ],
    );
  }
}