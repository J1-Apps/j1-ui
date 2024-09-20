import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class JToastOverrides extends Equatable {
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

  const JToastOverrides({
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

class JToast {
  static SnackBar create({
    required BuildContext context,
    required Widget child,
    JToastOverrides? overrides,
  }) {
    final colors = context.colorScheme();

    return SnackBar(
      content: child,
      behavior: SnackBarBehavior.floating,
      backgroundColor: overrides?.backgroundColor ?? colors.surfaceContainer,
      elevation: overrides?.elevation ?? JDimens.elevation_m,
      padding: EdgeInsets.zero,
      margin: overrides?.insetPadding ??
          const EdgeInsets.symmetric(
            vertical: JDimens.spacing_xl,
            horizontal: JDimens.spacing_l,
          ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: overrides?.outlineColor ?? colors.onSurface,
          width: overrides?.outlineWidth ?? J1Config.strokeWidth,
        ),
        borderRadius: BorderRadius.circular(overrides?.cornerRadius ?? JDimens.radius_m),
      ),
    );
  }

  static SnackBar createWithClose({
    required BuildContext context,
    required Widget child,
    VoidCallback? onClose,
    JToastOverrides? overrides,
  }) {
    final closeButton = JIconButton(
      icon: JamIcons.close,
      type: JButtonType.flat,
      size: JWidgetSize.small,
      onPressed: onClose ?? () => ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar(),
      overrides: JIconButtonOverrides(
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
                horizontal: JDimens.spacing_xs,
                vertical: JDimens.spacing_xs - 2,
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
    JToastOverrides? overrides,
  }) {
    final theme = context.theme();

    final content = Padding(
      padding: overrides?.contentPadding ??
          const EdgeInsets.symmetric(
            horizontal: JDimens.spacing_m,
            vertical: JDimens.spacing_m - 2,
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

extension JToastExtension on BuildContext {
  void showJToast({
    required Widget child,
    JToastOverrides? overrides,
  }) {
    final state = ScaffoldMessenger.maybeOf(this);
    state?.showSnackBar(
      JToast.create(
        context: this,
        child: child,
        overrides: overrides,
      ),
    );
  }

  void showJToastWithClose({
    required Widget child,
    VoidCallback? onClose,
    JToastOverrides? overrides,
  }) {
    final state = ScaffoldMessenger.maybeOf(this);
    state?.showSnackBar(
      JToast.createWithClose(
        context: this,
        onClose: onClose,
        child: child,
        overrides: overrides,
      ),
    );
  }

  void showJToastWithText({
    required String text,
    bool hasClose = false,
    VoidCallback? onClose,
    JToastOverrides? overrides,
  }) {
    final state = ScaffoldMessenger.maybeOf(this);
    state?.showSnackBar(
      JToast.createWithText(
        context: this,
        text: text,
        hasClose: hasClose,
        onClose: onClose,
        overrides: overrides,
      ),
    );
  }
}
