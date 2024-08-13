import "package:catalog/pages/buttons/icon_button_page.dart";
import "package:catalog/pages/buttons/text_button_page.dart";
import "package:catalog/pages/icons_page.dart";
import "package:catalog/pages/images_page.dart";
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
      CatalogBranch(title: "buttons", children: [
        CatalogLeaf(title: "text buttons", page: const TextButtonPage()),
        CatalogLeaf(title: "icon buttons", page: const IconButtonPage()),
      ]),
      CatalogLeaf(title: "icons", page: const IconsPage()),
      CatalogLeaf(title: "images", page: const ImagesPage()),
    ],
  );
}
