import "package:catalog/catalog_list_widget.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class DropdownMenuPage extends StatefulWidget {
  const DropdownMenuPage({super.key});

  @override
  State<StatefulWidget> createState() => DropdownMenuPageState();
}

class DropdownMenuPageState extends State<DropdownMenuPage> {
  final controller0 = TextEditingController();
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  String? value0 = "0";
  String? value1 = "0";
  String? value2 = "0";

  @override
  Widget build(BuildContext context) {
    return CatalogListWidget(
      [
        CatalogListItem(
          label: "outlined small",
          type: CatalogListItemType.column,
          child: Row(
            children: [
              JDropdownMenu<String>(
                entries: const [
                  JDropdownMenuEntry(value: "0", label: "Zero"),
                  JDropdownMenuEntry(value: "1", label: "One"),
                  JDropdownMenuEntry(value: "2", label: "Two"),
                  JDropdownMenuEntry(value: "3", label: "Three"),
                  JDropdownMenuEntry(value: "4", label: "Four"),
                ],
                size: JWidgetSize.small,
                controller: controller0,
                initialSelection: "0",
                onSelected: (value) => setState(() => value0 = value),
                overrides: const JDropdownMenuOverrides(menuStrokeWidth: 2),
              ),
              const SizedBox(width: JDimens.spacing_m),
              Text("value: ${value0 ?? "empty"}"),
            ],
          ),
        ),
        CatalogListItem(
          label: "outlined medium",
          type: CatalogListItemType.column,
          child: Row(
            children: [
              JDropdownMenu<String>(
                entries: const [
                  JDropdownMenuEntry(value: "0", label: "Zero"),
                  JDropdownMenuEntry(value: "1", label: "One"),
                  JDropdownMenuEntry(value: "2", label: "Two"),
                  JDropdownMenuEntry(value: "3", label: "Three"),
                  JDropdownMenuEntry(value: "4", label: "Four"),
                ],
                controller: controller0,
                initialSelection: "0",
                onSelected: (value) => setState(() => value0 = value),
              ),
              const SizedBox(width: JDimens.spacing_m),
              Text("value: ${value0 ?? "empty"}"),
            ],
          ),
        ),
        CatalogListItem(
          label: "outlined large",
          type: CatalogListItemType.column,
          child: Row(
            children: [
              JDropdownMenu<String>(
                entries: const [
                  JDropdownMenuEntry(value: "0", label: "Zero"),
                  JDropdownMenuEntry(value: "1", label: "One"),
                  JDropdownMenuEntry(value: "2", label: "Two"),
                  JDropdownMenuEntry(value: "3", label: "Three"),
                  JDropdownMenuEntry(value: "4", label: "Four"),
                ],
                size: JWidgetSize.large,
                controller: controller0,
                initialSelection: "0",
                onSelected: (value) => setState(() => value0 = value),
              ),
              const SizedBox(width: JDimens.spacing_m),
              Text("value: ${value0 ?? "empty"}"),
            ],
          ),
        ),
        CatalogListItem(
          label: "underlined small",
          type: CatalogListItemType.column,
          child: Row(
            children: [
              JDropdownMenu<String>(
                entries: const [
                  JDropdownMenuEntry(value: "0", label: "Zero", leadingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "1", label: "One", leadingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "2", label: "Two", leadingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "3", label: "Three", leadingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "4", label: "Four", leadingIcon: Icon(JamIcons.basketball)),
                ],
                type: JTextFieldType.underlined,
                size: JWidgetSize.small,
                controller: controller1,
                requestFocusOnTap: true,
                initialSelection: "0",
                hintText: "Value",
                onSelected: (value) => setState(() => value1 = value),
              ),
              const SizedBox(width: JDimens.spacing_m),
              Text("value: ${value1 ?? "empty"}"),
            ],
          ),
        ),
        CatalogListItem(
          label: "underlined medium",
          type: CatalogListItemType.column,
          child: Row(
            children: [
              JDropdownMenu<String>(
                entries: const [
                  JDropdownMenuEntry(value: "0", label: "Zero", leadingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "1", label: "One", leadingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "2", label: "Two", leadingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "3", label: "Three", leadingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "4", label: "Four", leadingIcon: Icon(JamIcons.basketball)),
                ],
                type: JTextFieldType.underlined,
                controller: controller1,
                requestFocusOnTap: true,
                initialSelection: "0",
                hintText: "Value",
                onSelected: (value) => setState(() => value1 = value),
                overrides: const JDropdownMenuOverrides(menuStrokeWidth: 2),
              ),
              const SizedBox(width: JDimens.spacing_m),
              Text("value: ${value1 ?? "empty"}"),
            ],
          ),
        ),
        CatalogListItem(
          label: "underlined large",
          type: CatalogListItemType.column,
          child: Row(
            children: [
              JDropdownMenu<String>(
                entries: const [
                  JDropdownMenuEntry(value: "0", label: "Zero", leadingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "1", label: "One", leadingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "2", label: "Two", leadingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "3", label: "Three", leadingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "4", label: "Four", leadingIcon: Icon(JamIcons.basketball)),
                ],
                type: JTextFieldType.underlined,
                size: JWidgetSize.large,
                controller: controller1,
                requestFocusOnTap: true,
                initialSelection: "0",
                hintText: "Value",
                onSelected: (value) => setState(() => value1 = value),
              ),
              const SizedBox(width: JDimens.spacing_m),
              Text("value: ${value1 ?? "empty"}"),
            ],
          ),
        ),
        CatalogListItem(
          label: "flat small",
          type: CatalogListItemType.column,
          child: Row(
            children: [
              JDropdownMenu<String>(
                entries: const [
                  JDropdownMenuEntry(value: "0", label: "Zero", trailingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "1", label: "One", trailingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "2", label: "Two", trailingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "3", label: "Three", trailingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "4", label: "Four", trailingIcon: Icon(JamIcons.basketball)),
                ],
                type: JTextFieldType.flat,
                size: JWidgetSize.small,
                color: JWidgetColor.primary,
                controller: controller2,
                initialSelection: "0",
                onSelected: (value) => setState(() => value2 = value),
              ),
              const SizedBox(width: JDimens.spacing_m),
              Text("value: ${value2 ?? "empty"}"),
            ],
          ),
        ),
        CatalogListItem(
          label: "flat medium",
          type: CatalogListItemType.column,
          child: Row(
            children: [
              JDropdownMenu<String>(
                entries: const [
                  JDropdownMenuEntry(value: "0", label: "Zero", trailingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "1", label: "One", trailingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "2", label: "Two", trailingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "3", label: "Three", trailingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "4", label: "Four", trailingIcon: Icon(JamIcons.basketball)),
                ],
                type: JTextFieldType.flat,
                color: JWidgetColor.secondary,
                controller: controller2,
                initialSelection: "0",
                onSelected: (value) => setState(() => value2 = value),
              ),
              const SizedBox(width: JDimens.spacing_m),
              Text("value: ${value2 ?? "empty"}"),
            ],
          ),
        ),
        CatalogListItem(
          label: "flat large",
          type: CatalogListItemType.column,
          child: Row(
            children: [
              JDropdownMenu<String>(
                entries: const [
                  JDropdownMenuEntry(value: "0", label: "Zero", trailingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "1", label: "One", trailingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "2", label: "Two", trailingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "3", label: "Three", trailingIcon: Icon(JamIcons.basketball)),
                  JDropdownMenuEntry(value: "4", label: "Four", trailingIcon: Icon(JamIcons.basketball)),
                ],
                type: JTextFieldType.flat,
                size: JWidgetSize.large,
                color: JWidgetColor.tertiary,
                controller: controller2,
                initialSelection: "0",
                onSelected: (value) => setState(() => value2 = value),
                overrides: const JDropdownMenuOverrides(menuStrokeWidth: 2),
              ),
              const SizedBox(width: JDimens.spacing_m),
              Text("value: ${value2 ?? "empty"}"),
            ],
          ),
        ),
      ],
    );
  }
}
