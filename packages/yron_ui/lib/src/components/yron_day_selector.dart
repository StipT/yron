import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';
import 'yron_choice_chip.dart';

/// Controlled, horizontally scrolling day/date selection.
class YronDaySelector extends StatelessWidget {
  const YronDaySelector({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  }) : assert(selectedIndex >= 0 && selectedIndex < labels.length);

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final (index, label) in labels.indexed)
            Padding(
              padding: const EdgeInsets.only(right: YronSpacing.sm),
              child: YronChoiceChip(
                label: label,
                selected: index == selectedIndex,
                onPressed: () => onSelected(index),
              ),
            ),
        ],
      ),
    );
  }
}
