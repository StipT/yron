import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';

/// Compact numbered instruction used in onboarding and setup summaries.
class YronOnboardingStep extends StatelessWidget {
  const YronOnboardingStep({
    super.key,
    required this.number,
    required this.label,
  });

  final String number;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: YronColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: YronSpacing.xs),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: YronColors.textMuted),
        ),
      ],
    );
  }
}
