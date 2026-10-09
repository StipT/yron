import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';

/// Section heading with optional supporting copy and a caller-owned action.
class YronSectionHeader extends StatelessWidget {
  const YronSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
  });

  final String title;
  final String? subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                header: true,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: YronSpacing.xs),
                Text(
                  subtitle!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: YronColors.textMuted),
                ),
              ],
            ],
          ),
        ),
        if (action != null) ...[const SizedBox(width: YronSpacing.sm), action!],
      ],
    );
  }
}
