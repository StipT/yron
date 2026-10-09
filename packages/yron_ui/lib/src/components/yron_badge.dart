import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';

/// Non-interactive status label. Supply localized [label] text.
class YronBadge extends StatelessWidget {
  const YronBadge({
    super.key,
    required this.label,
    this.icon,
    this.color = YronColors.primary,
  });

  final String label;
  final IconData? icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: YronRadii.small,
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: YronSpacing.sm,
          vertical: YronSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: color, size: 14),
              const SizedBox(width: YronSpacing.xs),
            ],
            Flexible(
              child: Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
