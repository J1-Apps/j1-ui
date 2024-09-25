import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:j1_ui/j1_ui.dart";

typedef FilterCallback<T> = List<T> Function(List<T>, String);
typedef SearchCallback<T> = int? Function(List<T>, String);

class JDropdownMenuOverrides extends Equatable {
  final double? width;
  final double? menuHeight;
  final double? elevation;
  final EdgeInsets? menuPadding;

  final AlignmentGeometry? alignment;
  final double? cornerRadius;
  final double? iconSize;
  final double? iconButtonSize;
  final double? strokeWidth;
  final double? menuStrokeWidth;

  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? menuStrokeColor;
  final Color? errorColor;
  final Color? iconColor;
  final double? hintOpacity;
  final double? disabledOpacity;

  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  const JDropdownMenuOverrides({
    this.width,
    this.menuHeight,
    this.menuPadding,
    this.elevation,
    this.alignment,
    this.cornerRadius,
    this.iconSize,
    this.iconButtonSize,
    this.strokeWidth,
    this.menuStrokeWidth,
    this.foregroundColor,
    this.backgroundColor,
    this.menuStrokeColor,
    this.errorColor,
    this.iconColor,
    this.hintOpacity,
    this.disabledOpacity,
    this.textStyle,
    this.hintStyle,
  });

  @override
  List<Object?> get props => [
        width,
        menuHeight,
        menuPadding,
        elevation,
        alignment,
        cornerRadius,
        iconSize,
        iconButtonSize,
        strokeWidth,
        menuStrokeWidth,
        errorColor,
        foregroundColor,
        backgroundColor,
        menuStrokeColor,
        iconColor,
        hintOpacity,
        disabledOpacity,
        textStyle,
        hintStyle,
      ];
}

class JDropdownMenuEntryOverrides extends Equatable {
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? overlayColor;
  final Color? iconColor;

  final EdgeInsets? padding;
  final double? iconSize;

  final TextStyle? textStyle;

  const JDropdownMenuEntryOverrides({
    this.foregroundColor,
    this.backgroundColor,
    this.overlayColor,
    this.iconColor,
    this.padding,
    this.iconSize,
    this.textStyle,
  });

  @override
  List<Object?> get props => [
        foregroundColor,
        backgroundColor,
        overlayColor,
        iconColor,
        padding,
        iconSize,
        textStyle,
      ];
}

class JDropdownMenu<T> extends StatelessWidget {
  final JTextFieldType type;
  final JWidgetSize size;
  final JWidgetColor color;
  final List<JDropdownMenuEntry<T>> entries;
  final JDropdownMenuOverrides? overrides;
  final JDropdownMenuEntryOverrides? entryOverrides;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Widget? selectedTrailingIcon;
  final Widget? label;
  final String? hintText;
  final T? initialSelection;
  final void Function(T?)? onSelected;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool requestFocusOnTap;
  final bool enabled;
  final TextAlign textAlign;
  final EdgeInsets? expandedInsets;
  final List<TextInputFormatter>? inputFormatters;
  final bool enableFilter;
  final bool enableSearch;
  final FilterCallback<JDropdownMenuEntry<T>>? filterCallback;
  final SearchCallback<JDropdownMenuEntry<T>>? searchCallback;

  const JDropdownMenu({
    this.type = JTextFieldType.outlined,
    this.size = JWidgetSize.medium,
    this.color = JWidgetColor.onSurface,
    required this.entries,
    this.overrides,
    this.entryOverrides,
    this.leadingIcon,
    this.trailingIcon,
    this.selectedTrailingIcon,
    this.label,
    this.hintText,
    this.initialSelection,
    this.onSelected,
    this.controller,
    this.focusNode,
    this.requestFocusOnTap = false,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.expandedInsets,
    this.inputFormatters,
    this.enableFilter = false,
    this.enableSearch = true,
    this.filterCallback,
    this.searchCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme();
    final filter = filterCallback;
    final search = searchCallback;

    final (textStyle, iconButtonSize, iconSize) = _createCommonSizes(theme.textTheme);
    final (foregroundColor, menuColor, fieldColor) = _createCommonColors(theme.colorScheme);

    return DropdownMenu<T>(
      dropdownMenuEntries: entries.map((entry) => _convertEntry(entry, textStyle, iconSize, foregroundColor)).toList(),
      menuStyle: _createMenuStyle(
        overrides?.foregroundColor ?? foregroundColor,
        overrides?.backgroundColor ?? menuColor,
      ),
      inputDecorationTheme: _createInputStyle(
        overrides?.foregroundColor ?? foregroundColor,
        overrides?.backgroundColor ?? fieldColor,
        overrides?.errorColor ?? theme.colorScheme.error,
        overrides?.textStyle ?? textStyle,
      ),
      width: overrides?.width,
      menuHeight: overrides?.menuHeight,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon ?? _createTrailingIcon(JamIcons.chevrondown, iconSize, foregroundColor),
      selectedTrailingIcon: selectedTrailingIcon ?? _createTrailingIcon(JamIcons.chevronup, iconSize, foregroundColor),
      label: label,
      hintText: hintText,
      initialSelection: initialSelection,
      onSelected: onSelected,
      controller: controller,
      focusNode: focusNode,
      requestFocusOnTap: requestFocusOnTap,
      enabled: enabled,
      textStyle: overrides?.textStyle ?? textStyle?.copyWith(color: overrides?.foregroundColor ?? foregroundColor),
      textAlign: textAlign,
      expandedInsets: expandedInsets,
      inputFormatters: inputFormatters,
      enableFilter: enableFilter,
      enableSearch: enableSearch,
      filterCallback: filter == null
          ? null
          : (entries, query) => filter(
                entries.map(_revertEntry<T>).toList(),
                query,
              ).map((entry) => _convertEntry(entry, textStyle, iconSize, foregroundColor)).toList(),
      searchCallback: search == null
          ? null
          : (entries, index) => search(
                entries.map(_revertEntry<T>).toList(),
                index,
              ),
    );
  }
}

class JDropdownMenuEntry<T> {
  final T value;
  final String label;
  final Widget? labelWidget;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool enabled;

  const JDropdownMenuEntry({
    required this.value,
    required this.label,
    this.labelWidget,
    this.leadingIcon,
    this.trailingIcon,
    this.enabled = true,
  });
}

extension _CreateStyle on JDropdownMenu {
  DropdownMenuEntry<T> _convertEntry<T>(
    JDropdownMenuEntry<T> entry,
    TextStyle? textStyle,
    double iconSize,
    Color foregroundColor,
  ) {
    return DropdownMenuEntry<T>(
      value: entry.value,
      label: entry.label,
      labelWidget: entry.labelWidget,
      leadingIcon: entry.leadingIcon,
      trailingIcon: entry.trailingIcon,
      enabled: entry.enabled,
      style: _createEntryStyle(
        textStyle,
        iconSize,
        foregroundColor,
      ),
    );
  }

  JDropdownMenuEntry<T> _revertEntry<T>(DropdownMenuEntry entry) {
    return JDropdownMenuEntry<T>(
      value: entry.value,
      label: entry.label,
      labelWidget: entry.labelWidget,
      leadingIcon: entry.leadingIcon,
      trailingIcon: entry.trailingIcon,
      enabled: entry.enabled,
    );
  }

  Widget _createTrailingIcon(IconData icon, double iconSize, Color iconColor) {
    return Icon(
      icon,
      size: overrides?.iconSize ?? iconSize,
      color: overrides?.iconColor ?? iconColor,
    );
  }

  (TextStyle?, double, double) _createCommonSizes(TextTheme fonts) {
    return switch (size) {
      JWidgetSize.large => (
          fonts.titleLarge,
          JDimens.size_32 + 4,
          JDimens.size_24 + 4,
        ),
      JWidgetSize.medium => (
          fonts.titleMedium,
          JDimens.size_32,
          JDimens.size_24,
        ),
      JWidgetSize.small => (
          fonts.titleSmall,
          JDimens.size_24 + 4,
          JDimens.size_20,
        ),
    };
  }

  (Color, Color, Color) _createCommonColors(ColorScheme colors) {
    return switch (color) {
      JWidgetColor.primary => (colors.primary, colors.surfaceContainer, Colors.transparent),
      JWidgetColor.secondary => (colors.secondary, colors.surfaceContainer, Colors.transparent),
      JWidgetColor.tertiary => (colors.tertiary, colors.surfaceContainer, Colors.transparent),
      JWidgetColor.error => (colors.error, colors.surfaceContainer, Colors.transparent),
      JWidgetColor.surface => (colors.surface, colors.surfaceContainer, Colors.transparent),
      JWidgetColor.onSurface => (colors.onSurface, colors.surfaceContainer, Colors.transparent),
    };
  }

  InputDecorationTheme _createInputStyle(
    Color foregroundColor,
    Color backgroundColor,
    Color errorColor,
    TextStyle? textStyle,
  ) {
    return switch (type) {
      JTextFieldType.outlined => _createOutlinedStyle(foregroundColor, backgroundColor, errorColor, textStyle),
      JTextFieldType.underlined => _createUnderlinedStyle(foregroundColor, backgroundColor, errorColor, textStyle),
      JTextFieldType.flat => _createFlatStyle(foregroundColor, textStyle),
    };
  }

  InputDecorationTheme _createOutlinedStyle(
    Color foregroundColor,
    Color backgroundColor,
    Color errorColor,
    TextStyle? textStyle,
  ) {
    final defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(color: foregroundColor, width: overrides?.strokeWidth ?? J1Config.strokeWidth),
      borderRadius: BorderRadius.circular(overrides?.cornerRadius ?? JDimens.radius_s),
    );

    final errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: errorColor, width: overrides?.strokeWidth ?? J1Config.strokeWidth),
      borderRadius: BorderRadius.circular(overrides?.cornerRadius ?? JDimens.radius_s),
    );

    final disabledBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: foregroundColor.withOpacity(overrides?.disabledOpacity ?? J1Config.disabledOpacity),
        width: overrides?.strokeWidth ?? J1Config.strokeWidth,
      ),
      borderRadius: BorderRadius.circular(overrides?.cornerRadius ?? JDimens.radius_s),
    );

    final hintStyle = overrides?.hintStyle ??
        textStyle?.copyWith(color: foregroundColor.withOpacity(overrides?.hintOpacity ?? J1Config.hintOpacity));

    return InputDecorationTheme(
      errorBorder: errorBorder,
      focusedBorder: defaultBorder,
      focusedErrorBorder: errorBorder,
      disabledBorder: disabledBorder,
      enabledBorder: defaultBorder,
      hintStyle: hintStyle,
    );
  }

  InputDecorationTheme _createUnderlinedStyle(
    Color foregroundColor,
    Color backgroundColor,
    Color errorColor,
    TextStyle? textStyle,
  ) {
    final defaultBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: foregroundColor, width: overrides?.strokeWidth ?? J1Config.strokeWidth),
    );

    final errorBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: errorColor, width: overrides?.strokeWidth ?? J1Config.strokeWidth),
    );

    final disabledBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: foregroundColor.withOpacity(overrides?.disabledOpacity ?? J1Config.disabledOpacity),
        width: overrides?.strokeWidth ?? J1Config.strokeWidth,
      ),
    );

    final hintStyle = overrides?.hintStyle ??
        textStyle?.copyWith(color: foregroundColor.withOpacity(overrides?.hintOpacity ?? J1Config.hintOpacity));

    return InputDecorationTheme(
      errorBorder: errorBorder,
      focusedBorder: defaultBorder,
      focusedErrorBorder: errorBorder,
      disabledBorder: disabledBorder,
      enabledBorder: defaultBorder,
      hintStyle: hintStyle,
    );
  }

  InputDecorationTheme _createFlatStyle(
    Color foregroundColor,
    TextStyle? textStyle,
  ) {
    const border = OutlineInputBorder(borderSide: BorderSide.none);
    final hintStyle = overrides?.hintStyle ??
        textStyle?.copyWith(color: foregroundColor.withOpacity(overrides?.hintOpacity ?? J1Config.hintOpacity));

    return InputDecorationTheme(
      border: border,
      hintStyle: hintStyle,
    );
  }

  MenuStyle _createMenuStyle(Color foregroundColor, Color menuColor) {
    final (padding, cornerRadius) = switch (size) {
      JWidgetSize.small => (const EdgeInsets.symmetric(vertical: JDimens.spacing_xs), JDimens.radius_s),
      JWidgetSize.medium => (const EdgeInsets.symmetric(vertical: JDimens.spacing_s), JDimens.radius_m),
      JWidgetSize.large => (const EdgeInsets.symmetric(vertical: JDimens.spacing_m), JDimens.radius_l),
    };

    final side = overrides?.menuStrokeWidth == null
        ? null
        : BorderSide(color: overrides?.menuStrokeColor ?? foregroundColor, width: overrides?.menuStrokeWidth ?? 0);

    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(overrides?.cornerRadius ?? cornerRadius));

    return MenuStyle(
      backgroundColor: menuColor.widgetState(),
      elevation: (overrides?.elevation ?? JDimens.elevation_s).widgetState(),
      padding: (overrides?.menuPadding ?? padding).widgetState(),
      side: side?.widgetState(),
      shape: shape.widgetState(),
      alignment: overrides?.alignment,
    );
  }

  ButtonStyle _createEntryStyle(
    TextStyle? textStyle,
    double iconSize,
    Color foregroundColor,
  ) {
    final padding = switch (size) {
      JWidgetSize.large => const EdgeInsets.symmetric(horizontal: JDimens.spacing_m, vertical: JDimens.spacing_m),
      JWidgetSize.medium => const EdgeInsets.symmetric(horizontal: JDimens.spacing_s, vertical: JDimens.spacing_s),
      JWidgetSize.small => const EdgeInsets.symmetric(horizontal: JDimens.spacing_xs, vertical: JDimens.spacing_xs),
    };

    final overlayColor = (entryOverrides?.foregroundColor ?? foregroundColor).withOpacity(
      J1Config.buttonOverlayOpacity,
    );

    return ButtonStyle(
      textStyle: (entryOverrides?.textStyle ?? textStyle)?.widgetState(),
      iconColor: (entryOverrides?.foregroundColor ?? foregroundColor).widgetState(),
      foregroundColor: (entryOverrides?.foregroundColor ?? foregroundColor).widgetState(),
      backgroundColor: (entryOverrides?.backgroundColor ?? Colors.transparent).widgetState(),
      overlayColor: overlayColor.widgetState(),
      padding: (entryOverrides?.padding ?? padding).widgetState(),
      iconSize: (entryOverrides?.iconSize ?? iconSize).widgetState(),
      minimumSize: Size.zero.widgetState(),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
