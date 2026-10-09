import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';
import 'yron_card.dart';
import 'yron_icon_tile.dart';
import 'yron_metric_value.dart';
import 'yron_section_label.dart';

/// Record highlight. Exercise names, record labels and dates are formatted by
/// the caller rather than tied to a workout model or locale.
class YronPersonalBestCard extends StatelessWidget {
  const YronPersonalBestCard({
    super.key,
    required this.label,
    required this.exercise,
    required this.value,
    this.unit,
    this.detail,
    this.badge,
    this.onTap,
    this.accent = YronColors.primary,
  });

  final String label;
  final String exercise;
  final String value;
  final String? unit;
  final String? detail;
  final Widget? badge;
  final VoidCallback? onTap;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return YronCard(
      onTap: onTap,
      borderColor: accent.withValues(alpha: 0.35),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              YronIconTile(icon: Icons.emoji_events_outlined, color: accent),
              const SizedBox(width: YronSpacing.sm),
              Expanded(child: YronSectionLabel(label: label)),
              if (badge != null) ...[
                const SizedBox(width: YronSpacing.sm),
                Flexible(child: badge!),
              ],
            ],
          ),
          const SizedBox(height: YronSpacing.md),
          Text(exercise, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: YronSpacing.sm),
          YronMetricValue(value: value, unit: unit, color: accent),
          if (detail != null) ...[
            const SizedBox(height: YronSpacing.sm),
            Text(
              detail!,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: YronColors.textMuted),
            ),
          ],
        ],
      ),
    );
  }
}
