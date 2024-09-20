import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class JSegmentedButtonOverrides extends Equatable {
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

  const JSegmentedButtonOverrides({
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

class JSegmentedButton extends StatelessWidget {
  final List<JButtonSegment> segments;
  final Set<String> selected;
  final void Function(Set<String>)? onSelected;
  final bool multiSelectEnabled;
  final bool emptySelectEnabled;
  final bool showSelectedIcon;
  final Widget? selectedIcon;
  final JWidgetSize size;
  final JWidgetColor color;
  final JSegmentedButtonOverrides? overrides;

  const JSegmentedButton({
    required this.segments,
    required this.selected,
    required this.onSelected,
    this.multiSelectEnabled = false,
    this.emptySelectEnabled = false,
    this.showSelectedIcon = false,
    this.selectedIcon,
    this.size = JWidgetSize.medium,
    this.color = JWidgetColor.surface,
    this.overrides,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
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

extension _CreateStyle on JSegmentedButton {
  ButtonStyle _createStyle(ThemeData theme) {
    final colors = theme.colorScheme;
    final fonts = theme.textTheme;

    final (padding, iconSize, textStyle) = _createButtonParams(fonts);

    final (foregroundColor, backgroundColor) = switch (color) {
      JWidgetColor.primary => (colors.onPrimary, colors.primary),
      JWidgetColor.secondary => (colors.onSecondary, colors.secondary),
      JWidgetColor.tertiary => (colors.onTertiary, colors.tertiary),
      JWidgetColor.error => (colors.onError, colors.error),
      JWidgetColor.surface => (colors.onSurface, colors.surface),
      JWidgetColor.onSurface => (colors.surface, colors.onSurface),
    };

    final overlayColor = (overrides?.overlayColor ?? overrides?.foregroundColor ?? foregroundColor)
        .withOpacity(J1Config.buttonOverlayOpacity);

    return SegmentedButton.styleFrom(
      textStyle: overrides?.textStyle ?? textStyle,
      foregroundColor: overrides?.foregroundColor ?? foregroundColor,
      backgroundColor: overrides?.backgroundColor ?? backgroundColor,
      selectedForegroundColor: overrides?.foregroundColor ?? foregroundColor,
      selectedBackgroundColor: overlayColor,
      padding: overrides?.buttonPadding ?? padding,
      elevation: JDimens.elevation_none,
      minimumSize: Size.zero,
      side: BorderSide(
        color: overrides?.outlineColor ?? foregroundColor,
        width: overrides?.outlineWidth ?? JDimens.size_1,
      ),
      shape: _createBorder(),
    );
  }

  (EdgeInsets, double, TextStyle?) _createButtonParams(TextTheme fonts) {
    return switch (size) {
      JWidgetSize.large => (
          const EdgeInsets.symmetric(horizontal: JDimens.spacing_s, vertical: JDimens.spacing_s),
          28,
          fonts.titleLarge
        ),
      JWidgetSize.medium => (
          const EdgeInsets.symmetric(horizontal: JDimens.spacing_s, vertical: JDimens.spacing_s),
          24,
          fonts.titleMedium
        ),
      JWidgetSize.small => (
          const EdgeInsets.symmetric(horizontal: JDimens.spacing_s, vertical: JDimens.spacing_s),
          20,
          fonts.titleSmall
        ),
    };
  }

  RoundedRectangleBorder _createBorder() {
    final cornerRadius = overrides?.cornerRadius ?? JDimens.radius_s;

    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(cornerRadius));
  }
}

class JButtonSegment {
  final String id;
  final Widget? icon;
  final Widget? label;
  final String? tooltip;
  final bool enabled;

  const JButtonSegment({
    required this.id,
    this.icon,
    this.label,
    this.tooltip,
    this.enabled = true,
  });

  ButtonSegment<String> _toButtonSegment() {
    return ButtonSegment(
      value: id,
      icon: icon,
      label: label,
      tooltip: tooltip,
      enabled: enabled,
    );
  }
}
