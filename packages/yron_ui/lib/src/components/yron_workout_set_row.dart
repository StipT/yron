import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';

/// A form-aware logging row. Values and completion are owned by the caller.
class YronWorkoutSetRow extends StatelessWidget {
  const YronWorkoutSetRow({
    super.key,
    required this.setLabel,
    required this.weightLabel,
    required this.repsLabel,
    required this.completeLabel,
    required this.weight,
    required this.reps,
    required this.completed,
    required this.onWeightChanged,
    required this.onRepsChanged,
    required this.onCompletedChanged,
    required this.weightValidator,
    required this.repsValidator,
  });

  final String setLabel;
  final String weightLabel;
  final String repsLabel;
  final String completeLabel;
  final String weight;
  final String reps;
  final bool completed;
  final ValueChanged<String> onWeightChanged;
  final ValueChanged<String> onRepsChanged;
  final ValueChanged<bool> onCompletedChanged;
  final FormFieldValidator<String> weightValidator;
  final FormFieldValidator<String> repsValidator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: YronSpacing.sm),
      child: Row(
        children: [
          SizedBox(
            width: 36,
            child: Text(
              setLabel,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Expanded(
            child: TextFormField(
              initialValue: weight,
              enabled: !completed,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: weightLabel),
              onChanged: onWeightChanged,
              validator: weightValidator,
            ),
          ),
          const SizedBox(width: YronSpacing.sm),
          Expanded(
            child: TextFormField(
              initialValue: reps,
              enabled: !completed,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: repsLabel),
              onChanged: onRepsChanged,
              validator: repsValidator,
            ),
          ),
          const SizedBox(width: YronSpacing.xs),
          Semantics(
            label: completeLabel,
            child: Checkbox(
              value: completed,
              onChanged: (value) => onCompletedChanged(value ?? false),
            ),
          ),
        ],
      ),
    );
  }
}
