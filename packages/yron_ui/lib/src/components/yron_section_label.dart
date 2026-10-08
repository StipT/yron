import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';

class YronSectionLabel extends StatelessWidget {
  const YronSectionLabel({
    super.key,
    required this.label,
    this.trailing,
    this.trailingColor = YronColors.textMuted,
  });

  final String label;
  final String? trailing;
  final Color trailingColor;

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall;

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: labelStyle?.copyWith(color: YronColors.textPrimary),
          ),
        ),
        if (trailing case final trailing?)
          Text(trailing, style: labelStyle?.copyWith(color: trailingColor)),
      ],
    );
  }
}
