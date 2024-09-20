// TODO: Uncomment once version solving is resolved.
// import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:j1_ui/j1_ui.dart";

abstract class JImage<SourceType> extends StatelessWidget {
  final SourceType source;
  final BoxFit fit;
  final Alignment? alignment;
  final double opacity;
  final Color? color;

  const JImage({
    required super.key,
    required this.source,
    required this.fit,
    required this.alignment,
    required this.opacity,
    required this.color,
  });
}

// class JNetworkImage extends _Image<String> {
//   final int? imageWidth;
//   final int? imageHeight;

//   const JNetworkImage({
//     super.key,
//     required super.source,
//     required super.fit,
//     super.alignment,
//     super.opacity = 1,
//     super.color,
//     this.imageHeight,
//     this.imageWidth,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: source,
//       fit: fit,
//       memCacheWidth: imageWidth,
//       maxWidthDiskCache: imageWidth,
//       memCacheHeight: imageHeight,
//       maxHeightDiskCache: imageHeight,
//       alignment: alignment ?? Alignment.center,
//       color: opacity == 1 ? null : Color.fromRGBO(255, 255, 255, opacity),
//       colorBlendMode: opacity == 1 ? null : BlendMode.modulate,
//     );
//   }
// }

class JSvgImage extends JImage<String> {
  const JSvgImage({
    super.key,
    required super.source,
    required super.fit,
    super.alignment,
    super.opacity = 1,
    super.color,
  });

  @override
  Widget build(BuildContext context) {
    final filter = color == null ? null : ColorFilter.mode(color ?? context.colorScheme().onSurface, BlendMode.srcIn);

    return SvgPicture.asset(
      source,
      colorFilter: filter,
      fit: fit,
      alignment: alignment ?? Alignment.center,
    );
  }
}
