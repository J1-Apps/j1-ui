import "package:catalog/catalog_content.dart";
import "package:flutter/material.dart" hide IconButton;
import "package:j1_ui/j1_ui.dart";

class CatalogRenderer extends StatelessWidget {
  final CatalogNode node;
  final bool isRoot;

  const CatalogRenderer(this.node, {this.isRoot = false, super.key});

  @override
  Widget build(BuildContext context) {
    final backButton = isRoot
        ? null
        : IconButton(
            icon: JamIcons.chevronleft,
            onPressed: () => Navigator.of(context).maybePop(),
          );

    return Scaffold(
      appBar: Header(
        title: node.title,
        leadingAction: backButton,
      ),
      body: switch (node) {
        final CatalogBranch branch => _buildBranch(branch, context),
        final CatalogLeaf leaf => leaf.page
      },
    );
  }

  Widget _buildBranch(CatalogBranch branch, BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: Dimens.spacing_m),
      itemBuilder: (context, index) => _buildBranchRow(context, branch.children[index]),
      itemCount: branch.children.length,
    );
  }

  Widget _buildBranchRow(BuildContext context, CatalogNode node) {
    return ListTile(
      onTap: () => _navigateToNode(context, node),
      title: Text(node.title, style: Theme.of(context).textTheme.bodyLarge),
      trailing: node is CatalogBranch ? const Icon(JamIcons.chevronright) : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: Dimens.spacing_m),
    );
  }

  void _navigateToNode(BuildContext context, CatalogNode node) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CatalogRenderer(node)));
  }
}
