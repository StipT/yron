import 'package:flutter/material.dart';

import 'yron_icon_tile.dart';
import 'yron_list_card.dart';

/// Exercise list item; [summary] can describe muscle group, equipment or sets.
class YronExerciseRow extends StatelessWidget {
  const YronExerciseRow({
    super.key,
    required this.name,
    required this.summary,
    this.icon = Icons.fitness_center,
    this.trailing,
    this.onTap,
  });

  final String name;
  final String summary;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return YronListCard(
      title: name,
      subtitle: summary,
      leading: YronIconTile(icon: icon),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
