import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:j1_ui/j1_ui.dart";

typedef FilterCallback<T> = List<T> Function(List<T>, String);
typedef SearchCallback<T> = int? Function(List<T>, String);

class JDropdownMenuOverrides extends Equatable {
  final double? width;
  final double? menuHeight;

  final EdgeInsets? padding;
  final double? cornerRadius;
  final double? iconSize;
  final double? iconButtonSize;
  final EdgeInsets? iconButtonPadding;
  final double? strokeWidth;

  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? hintOpacity;
  final double? disabledOpacity;

  final TextStyle? textStyle;

  const JDropdownMenuOverrides({
    this.width,
    this.menuHeight,
    this.padding,
    this.cornerRadius,
    this.iconSize,
    this.iconButtonSize,
    this.iconButtonPadding,
    this.strokeWidth,
    this.foregroundColor,
    this.backgroundColor,
    this.iconColor,
    this.hintOpacity,
    this.disabledOpacity,
    this.textStyle,
  });

  @override
  List<Object?> get props => [
        width,
        menuHeight,
        padding,
        cornerRadius,
        iconSize,
        iconButtonSize,
        iconButtonPadding,
        strokeWidth,
        foregroundColor,
        backgroundColor,
        iconColor,
        hintOpacity,
        disabledOpacity,
        textStyle,
      ];
}

class JDropdownMenuEntryOverrides extends Equatable {
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? overlayColor;
  final Color? iconColor;

  final EdgeInsetsGeometry? padding;
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
  final JDropdownMenuEntryOverrides entryOverrides;
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
    this.entryOverrides = const JDropdownMenuEntryOverrides(),
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

    return DropdownMenu<T>(
      dropdownMenuEntries: entries
          .map(
            (entry) => _convertEntry(
              entry,
              entryOverrides,
              size,
              color,
              theme,
            ),
          )
          .toList(),
      menuStyle: const MenuStyle(),
      inputDecorationTheme: const InputDecorationTheme(),
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      selectedTrailingIcon: selectedTrailingIcon,
      label: label,
      hintText: hintText,
      initialSelection: initialSelection,
      onSelected: onSelected,
      controller: controller,
      focusNode: focusNode,
      requestFocusOnTap: requestFocusOnTap,
      enabled: enabled,
      textAlign: textAlign,
      expandedInsets: expandedInsets,
      inputFormatters: inputFormatters,
      enableFilter: enableFilter,
      enableSearch: enableSearch,
      filterCallback: filter == null
          ? null
          : (entries, query) => filter(entries.map(_revertEntry<T>).toList(), query)
              .map(
                (entry) => _convertEntry(
                  entry,
                  entryOverrides,
                  size,
                  color,
                  theme,
                ),
              )
              .toList(),
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

DropdownMenuEntry<T> _convertEntry<T>(
  JDropdownMenuEntry<T> entry,
  JDropdownMenuEntryOverrides overrides,
  JWidgetSize size,
  JWidgetColor color,
  ThemeData theme,
) {
  return DropdownMenuEntry<T>(
    value: entry.value,
    label: entry.label,
    labelWidget: entry.labelWidget,
    leadingIcon: entry.leadingIcon,
    trailingIcon: entry.trailingIcon,
    enabled: entry.enabled,
    style: _createEntryStyle(size, color, theme.colorScheme, theme.textTheme, overrides),
  );
}

JDropdownMenuEntry<T> _revertEntry<T>(DropdownMenuEntry entry) {
  return JDropdownMenuEntry<T>(
    value: entry.value,
    label: entry.label,
    enabled: entry.enabled,
  );
}

ButtonStyle _createEntryStyle(
  JWidgetSize size,
  JWidgetColor color,
  ColorScheme colors,
  TextTheme fonts,
  JDropdownMenuEntryOverrides overrides,
) {
  final (padding, iconSize, textStyle) = _createButtonParams(size, fonts);

  final (foregroundColor, backgroundColor) = switch (color) {
    JWidgetColor.primary => (colors.primary, Colors.transparent),
    JWidgetColor.secondary => (colors.secondary, Colors.transparent),
    JWidgetColor.tertiary => (colors.tertiary, Colors.transparent),
    JWidgetColor.error => (colors.error, Colors.transparent),
    JWidgetColor.surface => (colors.surface, Colors.transparent),
    JWidgetColor.onSurface => (colors.onSurface, Colors.transparent),
  };

  final overlayColor = (overrides.foregroundColor ?? foregroundColor).withOpacity(J1Config.buttonOverlayOpacity);

  return ButtonStyle(
    textStyle: (overrides.textStyle ?? textStyle)?.widgetState(),
    iconColor: (overrides.foregroundColor ?? foregroundColor).widgetState(),
    foregroundColor: (overrides.foregroundColor ?? foregroundColor).widgetState(),
    backgroundColor: (overrides.backgroundColor ?? backgroundColor).widgetState(),
    overlayColor: overlayColor.widgetState(),
    padding: (overrides.padding ?? padding).widgetState(),
    iconSize: (overrides.iconSize ?? iconSize).widgetState(),
    minimumSize: Size.zero.widgetState(),
  );
}

(EdgeInsets, double, TextStyle?) _createButtonParams(JWidgetSize size, TextTheme fonts) {
  return switch (size) {
    JWidgetSize.large => (
        const EdgeInsets.symmetric(horizontal: JDimens.spacing_s + 2, vertical: JDimens.spacing_s),
        28,
        fonts.titleLarge,
      ),
    JWidgetSize.medium => (
        const EdgeInsets.symmetric(horizontal: JDimens.spacing_s + 2, vertical: JDimens.spacing_s),
        24,
        fonts.titleMedium,
      ),
    JWidgetSize.small => (
        const EdgeInsets.symmetric(horizontal: JDimens.spacing_s + 2, vertical: JDimens.spacing_s),
        20,
        fonts.titleSmall,
      ),
  };
}
