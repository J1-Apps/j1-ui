import "package:catalog/pages/input/dropdown_menu_page.dart";
import "package:catalog/pages/input/icon_button_page.dart";
import "package:catalog/pages/input/misc_input_page.dart";
import "package:catalog/pages/input/segmented_button_page.dart";
import "package:catalog/pages/input/text_button_page.dart";
import "package:catalog/pages/icons_page.dart";
import "package:catalog/pages/images_page.dart";
import "package:catalog/pages/input/text_field_page.dart";
import "package:catalog/pages/layout/card_page.dart";
import "package:catalog/pages/layout/error_message_page.dart";
import "package:catalog/pages/layout/loading_page.dart";
import "package:catalog/pages/layout/modals_page.dart";
import "package:flutter/material.dart";

sealed class CatalogNode {
  final String title;

  CatalogNode({required this.title});
}

class CatalogBranch extends CatalogNode {
  final List<CatalogNode> children;

  CatalogBranch({required super.title, required this.children});
}

class CatalogLeaf extends CatalogNode {
  final Widget page;

  CatalogLeaf({required super.title, required this.page});
}

class CatalogContent {
  static final CatalogNode content = CatalogBranch(
    title: "catalog",
    children: [
      CatalogBranch(title: "input", children: [
        CatalogLeaf(title: "text buttons", page: const TextButtonPage()),
        CatalogLeaf(title: "icon buttons", page: const IconButtonPage()),
        CatalogLeaf(title: "text fields", page: const TextFieldPage()),
        CatalogLeaf(title: "segmented buttons", page: const SegmentedButtonPage()),
        CatalogLeaf(title: "dropdown menu", page: const DropdownMenuPage()),
        CatalogLeaf(title: "misc input", page: const MiscInputPage()),
      ]),
      CatalogBranch(title: "layout", children: [
        CatalogLeaf(title: "cards", page: const CardPage()),
        CatalogLeaf(title: "loading", page: const LoadingPage()),
        CatalogLeaf(title: "modals", page: const ModalsPage()),
        CatalogLeaf(title: "error message", page: const ErrorMessagePage()),
      ]),
      CatalogLeaf(title: "icons", page: const IconsPage()),
      CatalogLeaf(title: "images", page: const ImagesPage()),
    ],
  );
}
