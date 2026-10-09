import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';

/// A caller-formatted number with a quieter unit, in JetBrains Mono.
class YronMetricValue extends StatelessWidget {
  const YronMetricValue({
    super.key,
    required this.value,
    this.unit,
    this.color = YronColors.textPrimary,
    this.fontSize = 28,
    this.semanticLabel,
  }) : assert(fontSize > 0);

  final String value;
  final String? unit;
  final Color color;
  final double fontSize;

  /// Optional localized expansion, for example "80 kilograms".
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: value,
        children: [
          if (unit != null)
            TextSpan(
              text: ' $unit',
              style: TextStyle(
                fontSize: fontSize * 0.5,
                color: YronColors.textMuted,
              ),
            ),
        ],
      ),
      semanticsLabel: semanticLabel,
      style: TextStyle(
        fontFamily: YronTypography.monoFamily,
        package: 'yron_ui',
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }
}
