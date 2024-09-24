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

  final AlignmentGeometry? alignment;
  final EdgeInsets? padding;
  final double? cornerRadius;
  final double? iconSize;
  final double? iconButtonSize;
  final EdgeInsets? iconButtonPadding;
  final double? strokeWidth;
  final double? menuStrokeWidth;

  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? menuStrokColor;
  final Color? iconColor;
  final double? hintOpacity;
  final double? disabledOpacity;

  final TextStyle? textStyle;

  const JDropdownMenuOverrides({
    this.width,
    this.menuHeight,
    this.elevation,
    this.alignment,
    this.padding,
    this.cornerRadius,
    this.iconSize,
    this.iconButtonSize,
    this.iconButtonPadding,
    this.strokeWidth,
    this.menuStrokeWidth,
    this.foregroundColor,
    this.backgroundColor,
    this.menuStrokColor,
    this.iconColor,
    this.hintOpacity,
    this.disabledOpacity,
    this.textStyle,
  });

  @override
  List<Object?> get props => [
        width,
        menuHeight,
        elevation,
        alignment,
        padding,
        cornerRadius,
        iconSize,
        iconButtonSize,
        iconButtonPadding,
        strokeWidth,
        menuStrokeWidth,
        foregroundColor,
        backgroundColor,
        menuStrokColor,
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

    return DropdownMenu<T>(
      dropdownMenuEntries: entries.map((entry) => _convertEntry(entry, theme)).toList(),
      menuStyle: _createMenuStyle(theme.colorScheme),
      inputDecorationTheme: _createInputStyle(theme.colorScheme),
      menuHeight: overrides?.menuHeight,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon ?? const Icon(JamIcons.chevrondown),
      selectedTrailingIcon: selectedTrailingIcon ?? const Icon(JamIcons.chevronup),
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
          : (entries, query) => filter(
                entries.map(_revertEntry<T>).toList(),
                query,
              ).map((entry) => _convertEntry(entry, theme)).toList(),
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
  DropdownMenuEntry<T> _convertEntry<T>(JDropdownMenuEntry<T> entry, ThemeData theme) {
    return DropdownMenuEntry<T>(
      value: entry.value,
      label: entry.label,
      labelWidget: entry.labelWidget,
      leadingIcon: entry.leadingIcon,
      trailingIcon: entry.trailingIcon,
      enabled: entry.enabled,
      style: _createEntryStyle(theme.colorScheme, theme.textTheme),
    );
  }

  JDropdownMenuEntry<T> _revertEntry<T>(DropdownMenuEntry entry) {
    return JDropdownMenuEntry<T>(
      value: entry.value,
      label: entry.label,
      enabled: entry.enabled,
    );
  }

  InputDecorationTheme _createInputStyle(ColorScheme colors) {
    return const InputDecorationTheme();
  }

  MenuStyle _createMenuStyle(ColorScheme colors) {
    final (foregroundColor, backgroundColor) = switch (color) {
      JWidgetColor.primary => (colors.primary, colors.surfaceContainer),
      JWidgetColor.secondary => (colors.secondary, colors.surfaceContainer),
      JWidgetColor.tertiary => (colors.tertiary, colors.surfaceContainer),
      JWidgetColor.error => (colors.error, colors.surfaceContainer),
      JWidgetColor.surface => (colors.surface, colors.onSurface),
      JWidgetColor.onSurface => (colors.onSurface, colors.surfaceContainer),
    };

    final (padding, cornerRadius) = switch (size) {
      JWidgetSize.small => (const EdgeInsets.symmetric(vertical: JDimens.spacing_xs), JDimens.radius_s),
      JWidgetSize.medium => (const EdgeInsets.symmetric(vertical: JDimens.spacing_s), JDimens.radius_m),
      JWidgetSize.large => (const EdgeInsets.symmetric(vertical: JDimens.spacing_m), JDimens.radius_l),
    };

    final strokeWidth = overrides?.strokeWidth;

    final side = strokeWidth == null
        ? null
        : BorderSide(color: overrides?.menuStrokColor ?? foregroundColor, width: strokeWidth);

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(overrides?.cornerRadius ?? cornerRadius),
    );

    return MenuStyle(
      backgroundColor: (overrides?.backgroundColor ?? backgroundColor).widgetState(),
      elevation: (overrides?.elevation ?? JDimens.elevation_s).widgetState(),
      padding: (overrides?.padding ?? padding).widgetState(),
      side: side?.widgetState(),
      shape: shape.widgetState(),
      alignment: overrides?.alignment,
    );
  }

  ButtonStyle _createEntryStyle(ColorScheme colors, TextTheme fonts) {
    final (padding, iconSize, textStyle) = _createEntryParams(fonts);

    final (foregroundColor, backgroundColor) = switch (color) {
      JWidgetColor.primary => (colors.primary, Colors.transparent),
      JWidgetColor.secondary => (colors.secondary, Colors.transparent),
      JWidgetColor.tertiary => (colors.tertiary, Colors.transparent),
      JWidgetColor.error => (colors.error, Colors.transparent),
      JWidgetColor.surface => (colors.surface, Colors.transparent),
      JWidgetColor.onSurface => (colors.onSurface, Colors.transparent),
    };

    final overlayColor = (entryOverrides?.foregroundColor ?? foregroundColor).withOpacity(
      J1Config.buttonOverlayOpacity,
    );

    return ButtonStyle(
      textStyle: (entryOverrides?.textStyle ?? textStyle)?.widgetState(),
      iconColor: (entryOverrides?.foregroundColor ?? foregroundColor).widgetState(),
      foregroundColor: (entryOverrides?.foregroundColor ?? foregroundColor).widgetState(),
      backgroundColor: (entryOverrides?.backgroundColor ?? backgroundColor).widgetState(),
      overlayColor: overlayColor.widgetState(),
      padding: (entryOverrides?.padding ?? padding).widgetState(),
      iconSize: (entryOverrides?.iconSize ?? iconSize).widgetState(),
      minimumSize: Size.zero.widgetState(),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  (EdgeInsets, double, TextStyle?) _createEntryParams(TextTheme fonts) {
    return switch (size) {
      JWidgetSize.large => (
          const EdgeInsets.symmetric(horizontal: JDimens.spacing_m, vertical: JDimens.spacing_m),
          28,
          fonts.titleLarge,
        ),
      JWidgetSize.medium => (
          const EdgeInsets.symmetric(horizontal: JDimens.spacing_s, vertical: JDimens.spacing_s),
          24,
          fonts.titleMedium,
        ),
      JWidgetSize.small => (
          const EdgeInsets.symmetric(horizontal: JDimens.spacing_xs, vertical: JDimens.spacing_xs),
          20,
          fonts.titleSmall,
        ),
    };
  }
}
