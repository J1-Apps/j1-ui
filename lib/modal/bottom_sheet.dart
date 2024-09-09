import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class BottomSheetOverrides extends Equatable {
  final double? cornerRadius;
  final double? elevation;

  final Color? barrierColor;
  final Color? backgroundColor;
  final Color? outlineColor;
  final double? outlineWidth;

  const BottomSheetOverrides({
    this.cornerRadius,
    this.elevation,
    this.barrierColor,
    this.backgroundColor,
    this.outlineColor,
    this.outlineWidth,
  });

  @override
  List<Object?> get props => [
        cornerRadius,
        elevation,
        barrierColor,
        backgroundColor,
        outlineColor,
        outlineWidth,
      ];
}

extension BottomSheetExtension on BuildContext {
  Future<bool?> showBottomSheet({BottomSheetOverrides? overrides, required Widget? child}) {
    if (child == null) {
      return Future.value();
    }

    final colors = colorScheme();

    final cornerRadius = Radius.circular(overrides?.cornerRadius ?? Dimens.radius_m);
    final shape = RoundedRectangleBorder(
      side: BorderSide(
        color: overrides?.outlineColor ?? colors.onSurface,
        width: overrides?.outlineWidth ?? J1Config.strokeWidth,
      ),
      borderRadius: BorderRadius.only(topLeft: cornerRadius, topRight: cornerRadius),
    );

    return showModalBottomSheet<bool>(
      context: this,
      builder: (context) => child,
      constraints: const BoxConstraints(minWidth: double.infinity),
      backgroundColor: overrides?.backgroundColor ?? colors.surfaceContainer,
      elevation: overrides?.elevation ?? Dimens.elevation_m,
      shape: shape,
      barrierColor: overrides?.barrierColor,
    );
  }
}
