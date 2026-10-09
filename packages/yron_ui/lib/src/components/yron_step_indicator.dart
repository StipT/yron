import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';

/// State of an individual step in a sequential flow.
enum YronStepState { upcoming, current, completed }

/// One reusable step marker, optionally actionable.
class YronStepMarker extends StatelessWidget {
  const YronStepMarker({
    super.key,
    required this.number,
    required this.label,
    required this.state,
    this.onPressed,
    this.semanticLabel,
  }) : assert(number > 0);

  final int number;
  final String label;
  final YronStepState state;
  final VoidCallback? onPressed;

  /// Localized description including step number and completion state.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final active = state != YronStepState.upcoming;
    final color = active ? YronColors.primary : YronColors.textMuted;
    final content = Padding(
      padding: const EdgeInsets.all(YronSpacing.sm),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExcludeSemantics(
            child: Container(
              alignment: Alignment.center,
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: active ? YronColors.limeSurface : YronColors.surface,
                borderRadius: YronRadii.small,
                border: Border.all(color: active ? color : YronColors.outline),
              ),
              child: state == YronStepState.completed
                  ? Icon(Icons.check, color: color, size: 18)
                  : Text(
                      '$number',
                      style: const TextStyle(
                        fontFamily: YronTypography.monoFamily,
                        package: 'yron_ui',
                      ).copyWith(color: color),
                    ),
            ),
          ),
          const SizedBox(width: YronSpacing.sm),
          Flexible(
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
    return Semantics(
      selected: state == YronStepState.current,
      button: onPressed != null,
      label: semanticLabel ?? '$number. $label',
      excludeSemantics: true,
      onTap: onPressed,
      child: Material(
        color: Colors.transparent,
        child: onPressed == null
            ? content
            : InkWell(
                onTap: onPressed,
                borderRadius: YronRadii.small,
                child: content,
              ),
      ),
    );
  }
}

/// Wrapping step sequence; no routing or flow state is owned by the widget.
class YronStepIndicator extends StatelessWidget {
  YronStepIndicator({
    super.key,
    required List<String> labels,
    required this.currentIndex,
    this.onStepSelected,
    this.semanticLabelBuilder,
  }) : labels = List.unmodifiable(labels),
       assert(labels.isNotEmpty),
       assert(currentIndex >= 0 && currentIndex < labels.length);

  final List<String> labels;
  final int currentIndex;
  final ValueChanged<int>? onStepSelected;

  /// Formats localized accessible descriptions including completion state.
  final String Function(int index, YronStepState state)? semanticLabelBuilder;

  YronStepState _stateFor(int index) {
    return index < currentIndex
        ? YronStepState.completed
        : index == currentIndex
        ? YronStepState.current
        : YronStepState.upcoming;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: YronSpacing.sm,
      runSpacing: YronSpacing.sm,
      children: [
        for (var index = 0; index < labels.length; index++)
          YronStepMarker(
            number: index + 1,
            label: labels[index],
            state: _stateFor(index),
            semanticLabel: semanticLabelBuilder?.call(index, _stateFor(index)),
            onPressed: onStepSelected == null
                ? null
                : () => onStepSelected!(index),
          ),
      ],
    );
  }
}
