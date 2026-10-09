import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';

/// Shared surface primitive. An optional tap callback adds keyboard-accessible
/// ink interaction; nested actions should instead use a non-interactive card.
class YronCard extends StatelessWidget {
  const YronCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(YronSpacing.md),
    this.color = YronColors.surfaceLow,
    this.borderColor = YronColors.outline,
    this.onTap,
    this.semanticLabel,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Color borderColor;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final content = Padding(padding: padding, child: child);
    return Semantics(
      label: semanticLabel,
      button: onTap == null ? null : true,
      child: Material(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: YronRadii.card,
          side: BorderSide(color: borderColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: onTap == null
            ? content
            : InkWell(
                onTap: onTap,
                borderRadius: YronRadii.card,
                child: content,
              ),
      ),
    );
  }
}
