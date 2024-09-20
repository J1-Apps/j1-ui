import "dart:math";

import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";
import "package:shimmer/shimmer.dart";

class JLoadingProvider extends StatelessWidget {
  final Color? baseColor;
  final Color? highlightColor;
  final Widget child;

  const JLoadingProvider({
    super.key,
    this.baseColor,
    this.highlightColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme();

    return Shimmer.fromColors(
      baseColor: baseColor ?? theme.shimmerBase(),
      highlightColor: highlightColor ?? theme.shimmerHighlight(),
      child: child,
    );
  }
}

class JLoadingBox extends StatelessWidget {
  final double? cornerRadius;
  final double? width;
  final double? height;

  const JLoadingBox({
    super.key,
    this.cornerRadius,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(cornerRadius ?? JDimens.radius_s),
      ),
    );
  }
}

class JLoadingText extends StatelessWidget {
  final double? cornerRadius;
  final double? width;
  final TextStyle? style;

  const JLoadingText({
    super.key,
    this.cornerRadius,
    this.width,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final heightPadding = EdgeInsets.symmetric(
      vertical: max((style?.height ?? 0) - 1, 0) * (style?.fontSize ?? 0) / 2,
    );

    return Padding(
      padding: heightPadding,
      child: JLoadingBox(
        cornerRadius: cornerRadius ?? JDimens.radius_xs,
        width: width,
        height: style?.fontSize,
      ),
    );
  }
}
