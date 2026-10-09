import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';

/// Linear completion indicator. Null [value] represents indeterminate work;
/// determinate values must be between zero and one.
class YronProgressBar extends StatelessWidget {
  const YronProgressBar({
    super.key,
    required this.value,
    required this.semanticLabel,
    this.semanticValue,
    this.color = YronColors.primary,
  }) : assert(value == null || (value >= 0 && value <= 1));

  final double? value;
  final String semanticLabel;
  final String? semanticValue;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      minHeight: YronSpacing.sm,
      borderRadius: YronRadii.small,
      color: color,
      backgroundColor: YronColors.outline,
      semanticsLabel: semanticLabel,
      semanticsValue: semanticValue,
    );
  }
}

/// Circular completion indicator with optional center content.
class YronProgressRing extends StatelessWidget {
  const YronProgressRing({
    super.key,
    required this.value,
    required this.semanticLabel,
    this.semanticValue,
    this.child,
    this.size = 80,
    this.color = YronColors.primary,
  }) : assert(value == null || (value >= 0 && value <= 1)),
       assert(size >= 24);

  final double? value;
  final String semanticLabel;
  final String? semanticValue;
  final Widget? child;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CircularProgressIndicator(
              value: value,
              strokeWidth: YronSpacing.xs,
              strokeCap: StrokeCap.round,
              color: color,
              backgroundColor: YronColors.outline,
              semanticsLabel: semanticLabel,
              semanticsValue: semanticValue,
            ),
          ),
          if (child != null)
            Padding(
              padding: const EdgeInsets.all(YronSpacing.sm),
              child: child,
            ),
        ],
      ),
    );
  }
}
