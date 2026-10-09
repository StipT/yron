import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';

/// Decorative icon container; actionable icons should use a button instead.
class YronIconTile extends StatelessWidget {
  const YronIconTile({
    super.key,
    required this.icon,
    this.color = YronColors.primary,
    this.size = 40,
  }) : assert(size >= 24);

  final IconData icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: YronRadii.medium,
        ),
        child: Icon(icon, size: size / 2, color: color),
      ),
    );
  }
}
