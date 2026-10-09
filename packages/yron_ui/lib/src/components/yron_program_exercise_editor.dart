import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/yron_theme.dart';
import 'yron_card.dart';
import 'yron_section_header.dart';

/// Form-aware prescription card, independent of draft models and routing.
///
/// Values initialize the fields once; use a stable exercise key when reordering.
/// Invalid input remains in the form and is never emitted to the application.
class YronProgramExerciseEditor extends StatelessWidget {
  const YronProgramExerciseEditor({
    super.key,
    required this.name,
    required this.subtitle,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    required this.setsLabel,
    required this.repsLabel,
    required this.restLabel,
    required this.rangeError,
    required this.onSetsChanged,
    required this.onRepsChanged,
    required this.onRestChanged,
    required this.deleteTooltip,
    required this.moveUpTooltip,
    required this.moveDownTooltip,
    required this.onDelete,
    this.onMoveUp,
    this.onMoveDown,
    this.onDetails,
    this.detailsTooltip,
    this.dragHandle,
  });

  final String name;
  final String subtitle;
  final int sets;
  final int reps;
  final int restSeconds;
  final String setsLabel;
  final String repsLabel;
  final String restLabel;
  final String Function(int min, int max) rangeError;
  final ValueChanged<int> onSetsChanged;
  final ValueChanged<int> onRepsChanged;
  final ValueChanged<int> onRestChanged;
  final String deleteTooltip;
  final String moveUpTooltip;
  final String moveDownTooltip;
  final VoidCallback onDelete;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;
  final VoidCallback? onDetails;
  final String? detailsTooltip;
  final Widget? dragHandle;

  @override
  Widget build(BuildContext context) {
    final fields = [
      (setsLabel, sets, 1, 20, onSetsChanged),
      (repsLabel, reps, 1, 999, onRepsChanged),
      (restLabel, restSeconds, 0, 1800, onRestChanged),
    ];
    return YronCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          YronSectionHeader(
            title: name,
            subtitle: subtitle,
            action: dragHandle,
          ),
          const SizedBox(height: YronSpacing.md),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth < 360
                  ? constraints.maxWidth
                  : (constraints.maxWidth - YronSpacing.sm * 2) / 3;
              return Wrap(
                spacing: YronSpacing.sm,
                runSpacing: YronSpacing.sm,
                children: [
                  for (final (label, value, min, max, onChanged) in fields)
                    SizedBox(
                      width: width,
                      child: TextFormField(
                        key: ValueKey(label),
                        initialValue: '$value',
                        decoration: InputDecoration(labelText: label),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (text) {
                          final parsed = int.tryParse(text ?? '');
                          return parsed == null || parsed < min || parsed > max
                              ? rangeError(min, max)
                              : null;
                        },
                        onChanged: (text) {
                          final parsed = int.tryParse(text);
                          if (parsed != null &&
                              parsed >= min &&
                              parsed <= max) {
                            onChanged(parsed);
                          }
                        },
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: YronSpacing.sm),
          Wrap(
            spacing: YronSpacing.xs,
            alignment: WrapAlignment.end,
            children: [
              if (onDetails != null)
                IconButton(
                  tooltip: detailsTooltip,
                  icon: const Icon(Icons.info_outline),
                  onPressed: onDetails,
                ),
              IconButton(
                tooltip: moveUpTooltip,
                icon: const Icon(Icons.arrow_upward),
                onPressed: onMoveUp,
              ),
              IconButton(
                tooltip: moveDownTooltip,
                icon: const Icon(Icons.arrow_downward),
                onPressed: onMoveDown,
              ),
              IconButton(
                tooltip: deleteTooltip,
                icon: const Icon(Icons.delete_outline),
                color: YronColors.tertiary,
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
