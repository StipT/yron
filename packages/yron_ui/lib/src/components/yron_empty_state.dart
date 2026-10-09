import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';
import 'yron_icon_tile.dart';

/// Reusable no-data, no-results or error presentation with an optional action.
class YronEmptyState extends StatelessWidget {
  const YronEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.action,
  });

  final IconData icon;
  final String title;
  final String description;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(YronSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          YronIconTile(icon: icon, size: 48),
          const SizedBox(height: YronSpacing.md),
          Semantics(
            header: true,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: YronSpacing.sm),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: YronColors.textMuted),
          ),
          if (action != null) ...[
            const SizedBox(height: YronSpacing.lg),
            action!,
          ],
        ],
      ),
    );
  }
}
