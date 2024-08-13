import "package:catalog/catalog_content.dart";
import "package:catalog/catalog_renderer.dart";
import "package:catalog/catalog_theme.dart";
import "package:flutter/material.dart";

void main() {
  runApp(const CatalogApp());
}

class CatalogApp extends StatelessWidget {
  const CatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "J1 UI Catalog",
      theme: ThemeData(
        brightness: CatalogTheme.colorScheme.brightness,
        colorScheme: CatalogTheme.colorScheme,
        textTheme: CatalogTheme.textTheme,
        pageTransitionsTheme: CatalogTheme.transitions,
        useMaterial3: true,
      ),
      home: CatalogRenderer(CatalogContent.content, isRoot: true),
    );
  }
}
