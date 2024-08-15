import "package:equatable/equatable.dart";
import "package:flutter/material.dart" hide IconButton;
import "package:j1_ui/j1_ui.dart";

class ToastOverrides extends Equatable {
  final EdgeInsets? insetPadding;
  final EdgeInsets? contentPadding;
  final EdgeInsets? iconPadding;
  final double? cornerRadius;
  final double? elevation;

  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? outlineColor;
  final Color? iconColor;
  final double? outlineWidth;
  final TextStyle? textStyle;

  final IconData? closeIcon;

  const ToastOverrides({
    this.insetPadding,
    this.contentPadding,
    this.iconPadding,
    this.cornerRadius,
    this.elevation,
    this.foregroundColor,
    this.backgroundColor,
    this.iconColor,
    this.outlineColor,
    this.outlineWidth,
    this.textStyle,
    this.closeIcon,
  });

  @override
  List<Object?> get props => [
        insetPadding,
        contentPadding,
        insetPadding,
        cornerRadius,
        elevation,
        foregroundColor,
        backgroundColor,
        outlineColor,
        outlineWidth,
        textStyle,
        closeIcon,
      ];
}

class Toast {
  static SnackBar create({
    required BuildContext context,
    required Widget child,
    ToastOverrides? overrides,
  }) {
    final colors = context.colorScheme();

    return SnackBar(
      content: child,
      behavior: SnackBarBehavior.floating,
      backgroundColor: overrides?.backgroundColor ?? colors.surfaceContainer,
      elevation: overrides?.elevation ?? Dimens.elevation_m,
      padding: EdgeInsets.zero,
      margin: overrides?.insetPadding ??
          const EdgeInsets.symmetric(
            vertical: Dimens.spacing_xl,
            horizontal: Dimens.spacing_l,
          ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: overrides?.outlineColor ?? colors.onSurface,
          width: overrides?.outlineWidth ?? 2.0,
        ),
        borderRadius: BorderRadius.circular(overrides?.cornerRadius ?? Dimens.radius_m),
      ),
    );
  }

  static SnackBar createWithClose({
    required BuildContext context,
    required Widget child,
    VoidCallback? onClose,
    ToastOverrides? overrides,
  }) {
    final closeButton = IconButton(
      icon: JamIcons.close,
      type: ButtonType.flat,
      size: WidgetSize.small,
      onPressed: onClose ?? () => ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar(),
      overrides: IconButtonOverrides(
        iconColor: overrides?.iconColor ?? overrides?.foregroundColor ?? context.colorScheme().onSurface,
      ),
    );

    final contentRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: child),
        Padding(
          padding: overrides?.iconPadding ??
              const EdgeInsets.symmetric(
                horizontal: Dimens.spacing_xs,
                vertical: Dimens.spacing_xs - 2,
              ),
          child: closeButton,
        ),
      ],
    );

    return create(context: context, child: contentRow);
  }

  static SnackBar createWithText({
    required BuildContext context,
    required String text,
    bool hasClose = false,
    VoidCallback? onClose,
    ToastOverrides? overrides,
  }) {
    final theme = context.theme();

    final content = Padding(
      padding: overrides?.contentPadding ??
          const EdgeInsets.symmetric(
            horizontal: Dimens.spacing_m,
            vertical: Dimens.spacing_m - 2,
          ),
      child: Text(
        text,
        style: (overrides?.textStyle ?? theme.textTheme.bodyMedium)?.copyWith(
          color: overrides?.foregroundColor ?? theme.colorScheme.onSurface,
        ),
      ),
    );

    return hasClose
        ? createWithClose(
            context: context,
            child: content,
            onClose: onClose,
          )
        : create(
            context: context,
            child: content,
          );
  }
}

extension ToastExtension on BuildContext {
  void showToast({
    required Widget child,
    ToastOverrides? overrides,
  }) {
    final state = ScaffoldMessenger.maybeOf(this);
    state?.showSnackBar(
      Toast.create(
        context: this,
        child: child,
        overrides: overrides,
      ),
    );
  }

  void showToastWithClose({
    required Widget child,
    VoidCallback? onClose,
    ToastOverrides? overrides,
  }) {
    final state = ScaffoldMessenger.maybeOf(this);
    state?.showSnackBar(
      Toast.createWithClose(
        context: this,
        onClose: onClose,
        child: child,
        overrides: overrides,
      ),
    );
  }

  void showToastWithText({
    required String text,
    bool hasClose = false,
    VoidCallback? onClose,
    ToastOverrides? overrides,
  }) {
    final state = ScaffoldMessenger.maybeOf(this);
    state?.showSnackBar(
      Toast.createWithText(
        context: this,
        text: text,
        hasClose: hasClose,
        onClose: onClose,
        overrides: overrides,
      ),
    );
  }
}
