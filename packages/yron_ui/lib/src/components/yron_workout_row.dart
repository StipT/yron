import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';
import 'yron_icon_tile.dart';
import 'yron_list_card.dart';

/// Workout list item with caller-formatted date/duration in [summary].
class YronWorkoutRow extends StatelessWidget {
  const YronWorkoutRow({
    super.key,
    required this.title,
    required this.summary,
    this.icon = Icons.timer_outlined,
    this.status,
    this.metrics,
    this.onTap,
  });

  final String title;
  final String summary;
  final IconData icon;
  final Widget? status;
  final Widget? metrics;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return YronListCard(
      title: title,
      subtitle: summary,
      leading: YronIconTile(icon: icon, color: YronColors.secondary),
      trailing: status,
      footer: metrics,
      onTap: onTap,
    );
  }
}
