import "dart:ui";

import "package:flutter/material.dart";

@immutable
class Dimens extends ThemeExtension<Dimens> {
  final EdgeInsets contentPadding;
  final double headerHeight;

  const Dimens({
    this.contentPadding = const EdgeInsets.all(defaultContentPadding),
    this.headerHeight = defaultHeaderHeight,
  });

  @override
  ThemeExtension<Dimens> copyWith({
    EdgeInsets? contentPadding,
    double? headerHeight,
  }) {
    return Dimens(
      contentPadding: contentPadding ?? this.contentPadding,
      headerHeight: headerHeight ?? this.headerHeight,
    );
  }

  @override
  ThemeExtension<Dimens> lerp(covariant ThemeExtension<Dimens>? other, double t) {
    if (other is! Dimens) {
      return this;
    }

    return Dimens(
      contentPadding: EdgeInsets.lerp(contentPadding, other.contentPadding, t) ?? contentPadding,
      headerHeight: lerpDouble(headerHeight, other.headerHeight, t) ?? headerHeight,
    );
  }

  static const defaultContentPadding = 16.0;
  static const defaultHeaderHeight = 72.0;
}
