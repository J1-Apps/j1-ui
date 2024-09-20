import "package:catalog/catalog_list_widget.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class ImagesPage extends StatelessWidget {
  const ImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      // TODO: Uncomment once version solving is resolved.
      // const CatalogListItem(
      //   type: CatalogListItemType.column,
      //   label: "network image",
      //   child: SizedBox(
      //     width: 200,
      //     height: 200,
      //     child: JNetworkImage(
      //       source:
      //           "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/Los_Angeles_Dodgers_Logo.svg/1976px-Los_Angeles_Dodgers_Logo.svg.png",
      //       fit: BoxFit.contain,
      //       imageWidth: 400,
      //       imageHeight: 400,
      //     ),
      //   ),
      // ),
      const CatalogListItem(
        type: CatalogListItemType.column,
        label: "svg image",
        child: SizedBox(
          width: 200,
          height: 200,
          child: JSvgImage(
            source: "assets/image/dodgers.svg",
            fit: BoxFit.contain,
          ),
        ),
      ),
    ];

    return CatalogListWidget(children);
  }
}
