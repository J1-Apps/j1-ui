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
  String? value0;

  @override
  Widget build(BuildContext context) {
    return CatalogListWidget(
      [
        CatalogListItem(
          label: "dropdown menu",
          child: Column(
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
              const SizedBox(height: JDimens.spacing_s),
              Text("value: ${value0 ?? "empty"}"),
            ],
          ),
        ),
      ],
    );
  }
}
