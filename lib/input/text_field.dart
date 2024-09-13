import "package:equatable/equatable.dart";
import "package:flutter/material.dart" hide IconButton;
import "package:j1_ui/j1_ui.dart";

enum TextFieldType {
  outlined,
  underlined,
  flat,
}

class TextFieldOverrides extends Equatable {
  final EdgeInsets? padding;
  final double? cornerRadius;
  final double? iconSize;
  final double? iconButtonSize;
  final EdgeInsets? iconButtonPadding;
  final double? strokeWidth;

  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? errorColor;
  final double? hintOpacity;
  final double? disabledOpacity;

  final TextStyle? textStyle;
  final TextStyle? errorStyle;

  const TextFieldOverrides({
    this.padding,
    this.cornerRadius,
    this.iconSize,
    this.iconButtonSize,
    this.iconButtonPadding,
    this.strokeWidth,
    this.foregroundColor,
    this.backgroundColor,
    this.iconColor,
    this.errorColor,
    this.hintOpacity,
    this.disabledOpacity,
    this.textStyle,
    this.errorStyle,
  });

  @override
  List<Object?> get props => [
        padding,
        cornerRadius,
        iconSize,
        iconButtonSize,
        iconButtonPadding,
        strokeWidth,
        foregroundColor,
        backgroundColor,
        iconColor,
        errorColor,
        hintOpacity,
        disabledOpacity,
        textStyle,
        errorStyle,
      ];
}

class TextField extends StatelessWidget {
  final TextFieldType type;
  final WidgetSize size;
  final WidgetColor color;
  final FocusNode? focusNode;
  final String? name;
  final String? hint;
  final String? errorText;
  final bool showErrorText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool obscureText;
  final bool autocorrect;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final IconData? icon;
  final VoidCallback? onIconPressed;
  final TextFieldOverrides? overrides;

  const TextField({
    this.type = TextFieldType.outlined,
    this.size = WidgetSize.medium,
    this.color = WidgetColor.onSurface,
    this.focusNode,
    this.name,
    this.hint,
    this.errorText,
    this.showErrorText = false,
    this.controller,
    this.keyboardType,
    this.textCapitalization,
    this.textDirection,
    this.textAlign,
    this.textAlignVertical,
    this.obscureText = false,
    this.autocorrect = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.icon,
    this.onIconPressed,
    this.overrides,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme();

    final (style, rawDecoration) = _createStyle(theme.colorScheme, theme.textTheme);

    final resolvedErrorText = errorText != null
        ? showErrorText
            ? errorText
            : ""
        : null;

    final decoration = rawDecoration.copyWith(
      isDense: true,
      hintText: hint,
      errorText: resolvedErrorText,
    );

    return TextFormField(
      focusNode: focusNode,
      style: style,
      decoration: decoration,
      controller: controller,
      keyboardType: keyboardType,
      keyboardAppearance: theme.brightness,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      textDirection: textDirection,
      textAlign: textAlign ?? TextAlign.start,
      textAlignVertical: textAlignVertical,
      obscureText: obscureText,
      autocorrect: autocorrect,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      enabled: enabled,
    );
  }
}

extension _CreateStyle on TextField {
  (TextStyle?, InputDecoration) _createStyle(
    ColorScheme colors,
    TextTheme fonts,
  ) {
    return switch (type) {
      TextFieldType.outlined => _createOutlinedStyle(colors, fonts),
      TextFieldType.underlined => _createUnderlinedStyle(colors, fonts),
      TextFieldType.flat => _createFlatStyle(colors, fonts),
    };
  }

  (TextStyle?, InputDecoration) _createOutlinedStyle(
    ColorScheme colors,
    TextTheme fonts,
  ) {
    final (padding, iconPadding, buttonSize, iconSize) = _createTextFieldDimens();
    final (foregroundColor, backgroundColor, iconColor) = _createFieldColors(colors);
    final (textStyle, hintStyle, errorStyle) = _createTextFieldStyle(colors, fonts, foregroundColor);
    final suffix = _createTrailingButton(iconPadding, buttonSize, iconSize, iconColor, backgroundColor);
    final suffixConstraints = BoxConstraints.tight(
      Size(buttonSize + iconPadding.left + iconPadding.right, buttonSize + iconPadding.top + iconPadding.bottom),
    );

    final defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: foregroundColor,
        width: overrides?.strokeWidth ?? J1Config.strokeWidth,
      ),
      borderRadius: BorderRadius.circular(overrides?.cornerRadius ?? Dimens.radius_s),
    );

    final errorBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: overrides?.errorColor ?? colors.error,
        width: overrides?.strokeWidth ?? J1Config.strokeWidth,
      ),
      borderRadius: BorderRadius.circular(overrides?.cornerRadius ?? Dimens.radius_s),
    );

    final disabledBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: foregroundColor.withOpacity(overrides?.disabledOpacity ?? J1Config.disabledOpacity),
        width: overrides?.strokeWidth ?? J1Config.strokeWidth,
      ),
      borderRadius: BorderRadius.circular(overrides?.cornerRadius ?? Dimens.radius_s),
    );

    return (
      textStyle,
      InputDecoration(
        contentPadding: padding,
        errorBorder: errorBorder,
        focusedBorder: defaultBorder,
        focusedErrorBorder: errorBorder,
        disabledBorder: disabledBorder,
        enabledBorder: defaultBorder,
        hintStyle: hintStyle,
        labelStyle: hintStyle,
        errorStyle: errorStyle,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
      ),
    );
  }

  (TextStyle?, InputDecoration) _createUnderlinedStyle(
    ColorScheme colors,
    TextTheme fonts,
  ) {
    final (padding, iconPadding, buttonSize, iconSize) = _createTextFieldDimens();
    final (foregroundColor, backgroundColor, iconColor) = _createFieldColors(colors);
    final (textStyle, hintStyle, errorStyle) = _createTextFieldStyle(colors, fonts, foregroundColor);
    final suffix = _createTrailingButton(iconPadding, buttonSize, iconSize, iconColor, backgroundColor);
    final suffixConstraints = BoxConstraints.tight(
      Size(buttonSize + iconPadding.left + iconPadding.right, buttonSize + iconPadding.top + iconPadding.bottom),
    );

    final defaultBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: foregroundColor,
        width: overrides?.strokeWidth ?? J1Config.strokeWidth,
      ),
    );

    final errorBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: overrides?.errorColor ?? colors.error,
        width: overrides?.strokeWidth ?? J1Config.strokeWidth,
      ),
    );

    final disabledBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: foregroundColor.withOpacity(overrides?.disabledOpacity ?? J1Config.disabledOpacity),
        width: overrides?.strokeWidth ?? J1Config.strokeWidth,
      ),
    );

    return (
      textStyle,
      InputDecoration(
        contentPadding: padding,
        errorBorder: errorBorder,
        focusedBorder: defaultBorder,
        focusedErrorBorder: errorBorder,
        disabledBorder: disabledBorder,
        enabledBorder: defaultBorder,
        hintStyle: hintStyle,
        labelStyle: hintStyle,
        errorStyle: errorStyle,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
      ),
    );
  }

  (TextStyle?, InputDecoration) _createFlatStyle(
    ColorScheme colors,
    TextTheme fonts,
  ) {
    final (padding, iconPadding, buttonSize, iconSize) = _createTextFieldDimens();
    final (foregroundColor, backgroundColor, iconColor) = _createFieldColors(colors);
    final (textStyle, hintStyle, errorStyle) = _createTextFieldStyle(colors, fonts, foregroundColor);
    final suffix = _createTrailingButton(iconPadding, buttonSize, iconSize, iconColor, backgroundColor);
    final suffixConstraints = BoxConstraints.tight(
      Size(buttonSize + iconPadding.left + iconPadding.right, buttonSize + iconPadding.top + iconPadding.bottom),
    );

    const border = OutlineInputBorder(borderSide: BorderSide.none);

    return (
      textStyle,
      InputDecoration(
        contentPadding: padding,
        border: border,
        hintStyle: hintStyle,
        labelStyle: hintStyle,
        errorStyle: errorStyle,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
      ),
    );
  }

  (Color, Color, Color) _createFieldColors(ColorScheme colors) {
    final (foreground, background, icon) = switch (color) {
      WidgetColor.primary => (colors.primary, Colors.transparent, colors.primary),
      WidgetColor.secondary => (colors.secondary, Colors.transparent, colors.secondary),
      WidgetColor.tertiary => (colors.tertiary, Colors.transparent, colors.tertiary),
      WidgetColor.error => (colors.error, Colors.transparent, colors.error),
      WidgetColor.surface => (colors.surface, Colors.transparent, colors.surface),
      WidgetColor.onSurface => (colors.onSurface, Colors.transparent, colors.onSurface),
    };

    return (
      overrides?.foregroundColor ?? foreground,
      overrides?.backgroundColor ?? background,
      overrides?.iconColor ?? icon,
    );
  }

  (EdgeInsets, EdgeInsets, double, double) _createTextFieldDimens() {
    return switch (size) {
      WidgetSize.large => (
          overrides?.padding ??
              const EdgeInsets.symmetric(
                horizontal: Dimens.spacing_m,
                vertical: Dimens.spacing_m - 2,
              ),
          overrides?.iconButtonPadding ?? const EdgeInsets.only(left: 8, right: 12),
          overrides?.iconButtonSize ?? 36,
          overrides?.iconSize ?? 28,
        ),
      WidgetSize.medium => (
          overrides?.padding ??
              const EdgeInsets.symmetric(
                horizontal: Dimens.spacing_s,
                vertical: Dimens.spacing_s - 2,
              ),
          overrides?.iconButtonPadding ?? const EdgeInsets.only(left: 8, right: 8),
          overrides?.iconButtonSize ?? 32,
          overrides?.iconSize ?? 24,
        ),
      WidgetSize.small => (
          overrides?.padding ??
              const EdgeInsets.symmetric(
                horizontal: Dimens.spacing_s,
                vertical: Dimens.spacing_s - 2,
              ),
          overrides?.iconButtonPadding ?? const EdgeInsets.only(left: 8, right: 6),
          overrides?.iconButtonSize ?? 28,
          overrides?.iconSize ?? 20,
        ),
    };
  }

  (TextStyle?, TextStyle?, TextStyle?) _createTextFieldStyle(
    ColorScheme colors,
    TextTheme fonts,
    Color foregroundColor,
  ) {
    final style = overrides?.textStyle ??
        switch (size) {
          WidgetSize.large => fonts.titleLarge,
          WidgetSize.medium => fonts.titleMedium,
          WidgetSize.small => fonts.titleSmall,
        };

    return (
      style?.copyWith(color: foregroundColor),
      style?.copyWith(color: foregroundColor.withOpacity(overrides?.hintOpacity ?? J1Config.hintOpacity)),
      showErrorText
          ? overrides?.errorStyle ?? fonts.labelSmall?.copyWith(color: colors.error)
          : const TextStyle(height: 0),
    );
  }

  Widget? _createTrailingButton(
    EdgeInsets iconButtonPadding,
    double buttonSize,
    double iconSize,
    Color iconColor,
    Color backgroundColor,
  ) {
    return icon == null
        ? null
        : Padding(
            padding: iconButtonPadding,
            child: IconButton(
              type: ButtonType.flat,
              size: WidgetSize.small,
              icon: icon,
              onPressed: onIconPressed,
              overrides: IconButtonOverrides(
                buttonSize: buttonSize,
                iconSize: iconSize,
                iconColor: iconColor,
                backgroundColor: backgroundColor,
              ),
            ),
          );
  }
}
