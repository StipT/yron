import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';

/// Scrollable modal visual primitive. Presentation and dismissal remain with
/// the caller; supply localized action buttons in [actions].
class YronDialog extends StatelessWidget {
  const YronDialog({
    super.key,
    required this.title,
    required this.child,
    this.actions = const [],
    this.semanticLabel,
  });

  final String title;
  final Widget child;
  final List<Widget> actions;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: YronColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: YronRadii.card,
        side: BorderSide(color: YronColors.outline),
      ),
      scrollable: true,
      semanticLabel: semanticLabel ?? title,
      title: Text(title),
      content: child,
      actions: actions,
      titlePadding: const EdgeInsets.fromLTRB(
        YronSpacing.lg,
        YronSpacing.lg,
        YronSpacing.lg,
        YronSpacing.sm,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: YronSpacing.lg,
        vertical: YronSpacing.md,
      ),
      actionsPadding: const EdgeInsets.all(YronSpacing.md),
    );
  }
}
