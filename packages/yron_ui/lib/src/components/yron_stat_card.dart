import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';
import 'yron_card.dart';
import 'yron_metric_value.dart';
import 'yron_section_label.dart';

/// Reusable metric card, with optional comparison or progress in [footer].
class YronStatCard extends StatelessWidget {
  const YronStatCard({
    super.key,
    required this.label,
    required this.value,
    this.unit,
    this.icon,
    this.accent = YronColors.primary,
    this.footer,
    this.onTap,
    this.semanticValue,
  });

  final String label;
  final String value;
  final String? unit;
  final IconData? icon;
  final Color accent;
  final Widget? footer;
  final VoidCallback? onTap;
  final String? semanticValue;

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
              Expanded(child: YronSectionLabel(label: label)),
              if (icon != null) ...[
                const SizedBox(width: YronSpacing.sm),
                Icon(icon, color: accent, size: 18),
              ],
            ],
          ),
          const SizedBox(height: YronSpacing.md),
          YronMetricValue(
            value: value,
            unit: unit,
            color: accent,
            semanticLabel: semanticValue,
          ),
          if (footer != null) ...[
            const SizedBox(height: YronSpacing.sm),
            footer!,
          ],
        ],
      ),
    );
  }
}
