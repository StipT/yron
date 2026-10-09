import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';
import 'yron_card.dart';

/// Reusable row surface for exercise, workout and history lists.
///
/// [leading], [trailing] and [footer] accept independent reusable widgets.
/// Leave [onTap] null when the slots contain their own interactive controls.
class YronListCard extends StatelessWidget {
  const YronListCard({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.footer,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Widget? footer;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return YronCard(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: YronSpacing.md),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: YronSpacing.xs),
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: YronColors.textMuted,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: YronSpacing.sm),
                Flexible(child: trailing!),
              ] else if (onTap != null) ...[
                const SizedBox(width: YronSpacing.sm),
                const Icon(
                  Icons.chevron_right,
                  color: YronColors.textMuted,
                  size: 20,
                ),
              ],
            ],
          ),
          if (footer != null) ...[
            const SizedBox(height: YronSpacing.md),
            footer!,
          ],
        ],
      ),
    );
  }
}
