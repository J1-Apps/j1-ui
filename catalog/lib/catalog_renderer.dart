import "package:catalog/catalog_content.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class CatalogRenderer extends StatelessWidget {
  final CatalogNode node;
  final bool isRoot;

  const CatalogRenderer(this.node, {this.isRoot = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: node.title,
        leadingAction: isRoot ? null : Container(),
      ),
      body: switch (node) {
        final CatalogBranch branch => _buildBranch(branch, context),
        final CatalogLeaf leaf => leaf.page
      },
    );
  }

  Widget _buildBranch(CatalogBranch branch, BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: Dimens.defaultContentPadding),
      itemBuilder: (context, index) => _buildBranchRow(context, branch.children[index]),
      itemCount: branch.children.length,
    );
  }

  Widget _buildBranchRow(BuildContext context, CatalogNode node) {
    return ListTile(
      onTap: () => _navigateToNode(context, node),
      title: Text(node.title, style: Theme.of(context).textTheme.bodyLarge),
      trailing: node is CatalogBranch ? const Icon(JamIcons.chevronright) : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: Dimens.defaultContentPadding),
    );
  }

  void _navigateToNode(BuildContext context, CatalogNode node) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CatalogRenderer(node)));
  }
}
