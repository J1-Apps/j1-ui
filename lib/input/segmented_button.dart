import "package:equatable/equatable.dart";
import "package:flutter/material.dart" hide SegmentedButton;
import "package:flutter/material.dart" as material show SegmentedButton, ButtonSegment;
import "package:j1_ui/j1_ui.dart";

class SegmentedButtonOverrides extends Equatable {
  final EdgeInsets? expandedPadding;

  final EdgeInsets? buttonPadding;
  final double? cornerRadius;
  final double? iconSize;

  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? overlayColor;
  final Color? outlineColor;
  final double? outlineWidth;

  final TextStyle? textStyle;

  const SegmentedButtonOverrides({
    this.expandedPadding,
    this.buttonPadding,
    this.cornerRadius,
    this.iconSize,
    this.foregroundColor,
    this.backgroundColor,
    this.overlayColor,
    this.outlineColor,
    this.outlineWidth,
    this.textStyle,
  });

  @override
  List<Object?> get props => [
        expandedPadding,
        buttonPadding,
        cornerRadius,
        iconSize,
        foregroundColor,
        backgroundColor,
        overlayColor,
        outlineColor,
        outlineWidth,
        textStyle,
      ];
}

class SegmentedButton extends StatelessWidget {
  final List<ButtonSegment> segments;
  final Set<String> selected;
  final void Function(Set<String>)? onSelected;
  final bool multiSelectEnabled;
  final bool emptySelectEnabled;
  final bool showSelectedIcon;
  final Widget? selectedIcon;
  final WidgetSize size;
  final WidgetColor color;
  final SegmentedButtonOverrides? overrides;

  const SegmentedButton({
    required this.segments,
    required this.selected,
    required this.onSelected,
    this.multiSelectEnabled = false,
    this.emptySelectEnabled = false,
    this.showSelectedIcon = false,
    this.selectedIcon,
    this.size = WidgetSize.medium,
    this.color = WidgetColor.surface,
    this.overrides,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return material.SegmentedButton(
      segments: segments.map((segment) => segment._toButtonSegment()).toList(),
      selected: selected,
      onSelectionChanged: onSelected,
      multiSelectionEnabled: multiSelectEnabled,
      emptySelectionAllowed: emptySelectEnabled,
      expandedInsets: overrides?.expandedPadding,
      style: _createStyle(context.theme()),
      showSelectedIcon: showSelectedIcon,
      selectedIcon: selectedIcon,
    );
  }
}

extension _CreateStyle on SegmentedButton {
  ButtonStyle _createStyle(ThemeData theme) {
    final colors = theme.colorScheme;
    final fonts = theme.textTheme;

    final (padding, iconSize, textStyle) = _createButtonParams(fonts);

    final (foregroundColor, backgroundColor) = switch (color) {
      WidgetColor.primary => (colors.onPrimary, colors.primary),
      WidgetColor.secondary => (colors.onSecondary, colors.secondary),
      WidgetColor.tertiary => (colors.onTertiary, colors.tertiary),
      WidgetColor.error => (colors.onError, colors.error),
      WidgetColor.surface => (colors.onSurface, colors.surface),
      WidgetColor.onSurface => (colors.surface, colors.onSurface),
    };

    final overlayColor = (overrides?.overlayColor ?? overrides?.foregroundColor ?? foregroundColor)
        .withOpacity(J1Config.buttonOverlayOpacity);

    return material.SegmentedButton.styleFrom(
      textStyle: overrides?.textStyle ?? textStyle,
      foregroundColor: overrides?.foregroundColor ?? foregroundColor,
      backgroundColor: overrides?.backgroundColor ?? backgroundColor,
      selectedForegroundColor: overrides?.foregroundColor ?? foregroundColor,
      selectedBackgroundColor: overlayColor,
      padding: overrides?.buttonPadding ?? padding,
      elevation: Dimens.elevation_none,
      minimumSize: Size.zero,
      side: BorderSide(
        color: overrides?.outlineColor ?? foregroundColor,
        width: overrides?.outlineWidth ?? Dimens.size_1,
      ),
      shape: _createBorder(),
    );
  }

  (EdgeInsets, double, TextStyle?) _createButtonParams(TextTheme fonts) {
    return switch (size) {
      WidgetSize.large => (
          const EdgeInsets.symmetric(horizontal: Dimens.spacing_s, vertical: Dimens.spacing_s),
          28,
          fonts.titleLarge
        ),
      WidgetSize.medium => (
          const EdgeInsets.symmetric(horizontal: Dimens.spacing_s, vertical: Dimens.spacing_s),
          24,
          fonts.titleMedium
        ),
      WidgetSize.small => (
          const EdgeInsets.symmetric(horizontal: Dimens.spacing_s, vertical: Dimens.spacing_s),
          20,
          fonts.titleSmall
        ),
    };
  }

  RoundedRectangleBorder _createBorder() {
    final cornerRadius = overrides?.cornerRadius ?? Dimens.radius_s;

    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(cornerRadius));
  }
}

class ButtonSegment {
  final String id;
  final Widget? icon;
  final Widget? label;
  final String? tooltip;
  final bool enabled;

  const ButtonSegment({
    required this.id,
    this.icon,
    this.label,
    this.tooltip,
    this.enabled = true,
  });

  material.ButtonSegment<String> _toButtonSegment() {
    return material.ButtonSegment(
      value: id,
      icon: icon,
      label: label,
      tooltip: tooltip,
      enabled: enabled,
    );
  }
}
