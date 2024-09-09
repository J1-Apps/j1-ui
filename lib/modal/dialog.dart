import "package:equatable/equatable.dart";
import "package:flutter/material.dart" hide Dialog, showDialog;
import "package:flutter/material.dart" as material;
import "package:j1_ui/j1_ui.dart";

class DialogOverrides extends Equatable {
  final EdgeInsets? insetPadding;
  final double? cornerRadius;
  final double? elevation;

  final Color? backgroundColor;
  final Color? outlineColor;
  final double? outlineWidth;

  const DialogOverrides({
    this.insetPadding,
    this.cornerRadius,
    this.elevation,
    this.backgroundColor,
    this.outlineColor,
    this.outlineWidth,
  });

  @override
  List<Object?> get props => [
        insetPadding,
        cornerRadius,
        elevation,
        backgroundColor,
        outlineColor,
        outlineWidth,
      ];
}

class Dialog extends StatelessWidget {
  final DialogOverrides? overrides;
  final Widget? child;

  const Dialog({super.key, this.overrides, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme();

    return material.Dialog(
      backgroundColor: overrides?.backgroundColor ?? theme.colorScheme.surfaceContainer,
      elevation: overrides?.elevation ?? Dimens.elevation_m,
      insetPadding: overrides?.insetPadding ??
          const EdgeInsets.symmetric(
            horizontal: Dimens.spacing_m,
            vertical: Dimens.spacing_xxxl,
          ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: overrides?.outlineColor ?? theme.colorScheme.onSurface,
          width: overrides?.outlineWidth ?? J1Config.strokeWidth,
        ),
        borderRadius: BorderRadius.circular(overrides?.cornerRadius ?? Dimens.radius_m),
      ),
      child: child,
    );
  }
}

extension DialogExtension on BuildContext {
  Future<bool?> showDialog({DialogOverrides? overrides, required Widget? child}) {
    return material.showDialog<bool>(
      context: this,
      builder: (context) => Dialog(overrides: overrides, child: child),
    );
  }
}
