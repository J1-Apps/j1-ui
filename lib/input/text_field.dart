import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:j1_ui/j1_ui.dart";

enum JTextFieldType {
  outlined,
  underlined,
  flat,
}

class JTextFieldOverrides extends Equatable {
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

  const JTextFieldOverrides({
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

class JTextField extends StatelessWidget {
  final JTextFieldType type;
  final JWidgetSize size;
  final JWidgetColor color;
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
  final ScrollPhysics? scrollPhysics;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool autocorrect;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final IconData? icon;
  final VoidCallback? onIconPressed;
  final JTextFieldOverrides? overrides;

  const JTextField({
    this.type = JTextFieldType.outlined,
    this.size = JWidgetSize.medium,
    this.color = JWidgetColor.onSurface,
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
    this.scrollPhysics,
    this.inputFormatters,
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
      scrollPhysics: scrollPhysics ?? const ClampingScrollPhysics(),
      inputFormatters: inputFormatters,
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

extension _CreateStyle on JTextField {
  (TextStyle?, InputDecoration) _createStyle(
    ColorScheme colors,
    TextTheme fonts,
  ) {
    return switch (type) {
      JTextFieldType.outlined => _createOutlinedStyle(colors, fonts),
      JTextFieldType.underlined => _createUnderlinedStyle(colors, fonts),
      JTextFieldType.flat => _createFlatStyle(colors, fonts),
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
      borderRadius: BorderRadius.circular(overrides?.cornerRadius ?? JDimens.radius_s),
    );

    final errorBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: overrides?.errorColor ?? colors.error,
        width: overrides?.strokeWidth ?? J1Config.strokeWidth,
      ),
      borderRadius: BorderRadius.circular(overrides?.cornerRadius ?? JDimens.radius_s),
    );

    final disabledBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: foregroundColor.withOpacity(overrides?.disabledOpacity ?? J1Config.disabledOpacity),
        width: overrides?.strokeWidth ?? J1Config.strokeWidth,
      ),
      borderRadius: BorderRadius.circular(overrides?.cornerRadius ?? JDimens.radius_s),
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
      JWidgetColor.primary => (colors.primary, Colors.transparent, colors.primary),
      JWidgetColor.secondary => (colors.secondary, Colors.transparent, colors.secondary),
      JWidgetColor.tertiary => (colors.tertiary, Colors.transparent, colors.tertiary),
      JWidgetColor.error => (colors.error, Colors.transparent, colors.error),
      JWidgetColor.surface => (colors.surface, Colors.transparent, colors.surface),
      JWidgetColor.onSurface => (colors.onSurface, Colors.transparent, colors.onSurface),
    };

    return (
      overrides?.foregroundColor ?? foreground,
      overrides?.backgroundColor ?? background,
      overrides?.iconColor ?? icon,
    );
  }

  (EdgeInsets, EdgeInsets, double, double) _createTextFieldDimens() {
    return switch (size) {
      JWidgetSize.large => (
          overrides?.padding ??
              const EdgeInsets.symmetric(
                horizontal: JDimens.spacing_m,
                vertical: JDimens.spacing_m - 2,
              ),
          overrides?.iconButtonPadding ?? const EdgeInsets.only(left: 8, right: 12),
          overrides?.iconButtonSize ?? 36,
          overrides?.iconSize ?? 28,
        ),
      JWidgetSize.medium => (
          overrides?.padding ??
              const EdgeInsets.symmetric(
                horizontal: JDimens.spacing_s,
                vertical: JDimens.spacing_s - 2,
              ),
          overrides?.iconButtonPadding ?? const EdgeInsets.only(left: 8, right: 8),
          overrides?.iconButtonSize ?? 32,
          overrides?.iconSize ?? 24,
        ),
      JWidgetSize.small => (
          overrides?.padding ??
              const EdgeInsets.symmetric(
                horizontal: JDimens.spacing_s,
                vertical: JDimens.spacing_s - 2,
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
          JWidgetSize.large => fonts.titleLarge,
          JWidgetSize.medium => fonts.titleMedium,
          JWidgetSize.small => fonts.titleSmall,
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
            child: JIconButton(
              type: JButtonType.flat,
              size: JWidgetSize.small,
              icon: icon,
              onPressed: onIconPressed,
              overrides: JIconButtonOverrides(
                buttonSize: buttonSize,
                iconSize: iconSize,
                iconColor: iconColor,
                backgroundColor: backgroundColor,
              ),
            ),
          );
  }
}
