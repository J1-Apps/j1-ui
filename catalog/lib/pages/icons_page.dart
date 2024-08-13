import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

List<IconData> _icons = [
  JamIcons.chevronright,
  JamIcons.chevronleft,
  JamIcons.chevrondown,
  JamIcons.chevronup,
];

class IconsPage extends StatelessWidget {
  const IconsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      crossAxisCount: 6,
      children: _icons.map(_buildIconSquare).toList(),
    );
  }

  Widget _buildIconSquare(IconData icon) {
    return Center(child: Icon(icon));
  }
}
