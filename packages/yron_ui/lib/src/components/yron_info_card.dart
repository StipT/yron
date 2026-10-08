import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';

class YronInfoCard extends StatelessWidget {
  const YronInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: YronColors.surface,
        borderRadius: YronRadii.medium,
        border: Border.all(color: YronColors.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(YronSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: YronColors.limeSurface,
                borderRadius: YronRadii.small,
              ),
              child: SizedBox(
                width: 32,
                height: 32,
                child: Icon(icon, color: YronColors.primary, size: 18),
              ),
            ),
            const SizedBox(width: YronSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: YronColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: YronSpacing.xs),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: YronColors.textMuted,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
