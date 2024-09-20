import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class JErrorMessage extends StatelessWidget {
  final String? title;
  final String message;
  final String? cta;
  final void Function()? ctaAction;

  const JErrorMessage({
    this.title,
    required this.message,
    this.cta,
    this.ctaAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final fonts = context.textTheme();
    final hasTitle = title?.isNotEmpty ?? false;
    final hasCta = ctaAction != null;

    return Padding(
      padding: const EdgeInsets.all(JDimens.spacing_m),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasTitle) Text(title ?? "", style: fonts.headlineMedium),
          if (hasTitle) const SizedBox(height: JDimens.spacing_s),
          Text(message, style: fonts.bodyMedium),
          if (hasCta) const SizedBox(height: JDimens.spacing_s),
          if (hasCta) JTextButton(text: cta ?? "", onPressed: ctaAction),
        ],
      ),
    );
  }
}
