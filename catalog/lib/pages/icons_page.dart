import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

List<IconData> _icons = [
  JamIcons.unpinned,
  JamIcons.unorderedlist,
  JamIcons.video,
  JamIcons.strikethrough,
  JamIcons.trash,
  JamIcons.stats,
  JamIcons.textcolor,
  JamIcons.underline,
  JamIcons.tasklist,
  JamIcons.text,
  JamIcons.tag,
  JamIcons.star,
  JamIcons.starfilled,
  JamIcons.settings,
  JamIcons.paw,
  JamIcons.phone,
  JamIcons.refresh,
  JamIcons.plus,
  JamIcons.pinned,
  JamIcons.mic,
  JamIcons.pencil,
  JamIcons.language,
  JamIcons.paintbrush,
  JamIcons.italic,
  JamIcons.plug,
  JamIcons.help,
  JamIcons.orderedlist,
  JamIcons.infofilled,
  JamIcons.github,
  JamIcons.key,
  JamIcons.h2,
  JamIcons.pizza,
  JamIcons.mountain,
  JamIcons.google,
  JamIcons.link,
  JamIcons.search,
  JamIcons.info,
  JamIcons.h1,
  JamIcons.folder,
  JamIcons.home,
  JamIcons.folderfilled,
  JamIcons.eyedropper,
  JamIcons.close,
  JamIcons.eyeclosed,
  JamIcons.crown,
  JamIcons.homefilled,
  JamIcons.h3,
  JamIcons.email,
  JamIcons.chevronleft,
  JamIcons.chevrondown,
  JamIcons.creditcard,
  JamIcons.facebook,
  JamIcons.eye,
  JamIcons.coin,
  JamIcons.bold,
  JamIcons.book,
  JamIcons.camera,
  JamIcons.chevronup,
  JamIcons.check,
  JamIcons.brush,
  JamIcons.chevronright,
  JamIcons.bell,
  JamIcons.basketball,
  JamIcons.backgroundcolor,
  JamIcons.apple,
  JamIcons.animation,
  JamIcons.alarmclock,
  JamIcons.account,
];

class IconsPage extends StatelessWidget {
  const IconsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(JDimens.spacing_m),
      crossAxisSpacing: JDimens.spacing_s,
      mainAxisSpacing: JDimens.spacing_s,
      crossAxisCount: 6,
      children: _icons.map(_buildIconSquare).toList(),
    );
  }

  Widget _buildIconSquare(IconData icon) {
    return Center(child: Icon(icon));
  }
}
