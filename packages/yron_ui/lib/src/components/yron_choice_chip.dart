import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';

class YronChoiceChip extends StatelessWidget {
  const YronChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = selected
        ? YronColors.canvas
        : YronColors.textPrimary;

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: Material(
        color: selected ? YronColors.primary : YronColors.surface,
        borderRadius: YronRadii.small,
        child: InkWell(
          onTap: onPressed,
          borderRadius: YronRadii.small,
          child: Container(
            constraints: const BoxConstraints(minHeight: 40),
            padding: const EdgeInsets.symmetric(
              horizontal: YronSpacing.md,
              vertical: YronSpacing.sm,
            ),
            decoration: BoxDecoration(
              borderRadius: YronRadii.small,
              border: Border.all(
                color: selected ? YronColors.primary : YronColors.outline,
              ),
            ),
            child: Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: foregroundColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
