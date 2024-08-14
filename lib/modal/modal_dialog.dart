import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class ModalDialogOverrides extends Equatable {
  final EdgeInsets? insetPadding;
  final double? cornerRadius;
  final double? elevation;

  final Color? backgroundColor;
  final Color? outlineColor;
  final double? outlineWidth;

  const ModalDialogOverrides({
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

class ModalDialog extends StatelessWidget {
  final ModalDialogOverrides? overrides;
  final Widget? child;

  const ModalDialog({super.key, this.overrides, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme();

    return Dialog(
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
          width: overrides?.outlineWidth ?? 2.0,
        ),
        borderRadius: BorderRadius.circular(overrides?.cornerRadius ?? Dimens.radius_m),
      ),
      child: child,
    );
  }
}

extension ModalDialogExtension on BuildContext {
  Future<bool?> showModalDialog({ModalDialogOverrides? overrides, required Widget? child}) {
    return showDialog<bool>(
      context: this,
      builder: (context) => ModalDialog(overrides: overrides, child: child),
    );
  }
}
