import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class JSwitchButtonOverrides extends Equatable {
  final Color? thumbColor;
  final Color? activeColor;
  final Color? inactiveColor;

  final IconData? activeIcon;
  final IconData? inactiveIcon;

  const JSwitchButtonOverrides({
    this.thumbColor,
    this.activeColor,
    this.inactiveColor,
    this.activeIcon,
    this.inactiveIcon,
  });

  @override
  List<Object?> get props => [
        thumbColor,
        activeColor,
        inactiveColor,
        activeIcon,
        inactiveIcon,
      ];
}

class JSwitchButton extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final JSwitchButtonOverrides? overrides;

  const JSwitchButton({
    required this.value,
    required this.onChanged,
    this.overrides,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme();
    final colors = theme.colorScheme;

    final activeColor =
        overrides?.activeColor ?? (theme.brightness == Brightness.dark ? colors.onSurface : colors.tertiary);
    final inactiveColor =
        overrides?.inactiveColor ?? (theme.brightness == Brightness.dark ? colors.primary : colors.secondary);

    final thumbIcon = WidgetStateProperty.resolveWith<Icon?>(
      (Set<WidgetState> states) => states.contains(WidgetState.selected)
          ? Icon(JamIcons.check, color: activeColor)
          : Icon(JamIcons.close, color: inactiveColor),
    );

    return Switch(
      value: value,
      onChanged: onChanged,
      thumbIcon: thumbIcon,
      thumbColor: (overrides?.thumbColor ?? colors.surface).widgetState(),
      activeTrackColor: activeColor,
      inactiveTrackColor: inactiveColor,
      trackOutlineColor: Colors.transparent.widgetState(),
    );
  }
}
