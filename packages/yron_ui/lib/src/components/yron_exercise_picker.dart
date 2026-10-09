import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';
import 'yron_button.dart';
import 'yron_choice_chip.dart';
import 'yron_empty_state.dart';
import 'yron_exercise_row.dart';
import 'yron_search_field.dart';

/// Presentation-only catalog item. Application models stay outside yron_ui.
class YronExercisePickerItem {
  const YronExercisePickerItem({
    required this.id,
    required this.name,
    required this.muscle,
    required this.equipment,
    required this.difficulty,
  });

  final String id;
  final String name;
  final String muscle;
  final String equipment;
  final String difficulty;
}

/// Scrollable catalog shared by full-screen, library and bottom-sheet hosts.
///
/// Hosts constrain its height and provide safe areas. Selection is local until
/// confirmation; dismissal never mutates the caller's exercise collection.
/// All visible labels are supplied by the caller for localization.
class YronExercisePicker extends StatefulWidget {
  const YronExercisePicker({
    super.key,
    required this.items,
    required this.searchLabel,
    required this.clearTooltip,
    required this.muscleLabel,
    required this.equipmentLabel,
    required this.difficultyLabel,
    required this.allLabel,
    required this.emptyTitle,
    required this.emptyDescription,
    required this.detailsTooltip,
    required this.selectedLabel,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.onDetails,
    this.onConfirm,
    this.onCancel,
    this.initialSelection = const {},
    this.unavailableIds = const {},
    this.showAdvancedFilters = true,
    this.selectable = true,
  });

  final List<YronExercisePickerItem> items;
  final String searchLabel;
  final String clearTooltip;
  final String muscleLabel;
  final String equipmentLabel;
  final String difficultyLabel;
  final String allLabel;
  final String emptyTitle;
  final String emptyDescription;
  final String detailsTooltip;
  final String Function(int count) selectedLabel;
  final String Function(int count) confirmLabel;
  final String cancelLabel;
  final ValueChanged<YronExercisePickerItem> onDetails;
  final ValueChanged<Set<String>>? onConfirm;
  final VoidCallback? onCancel;
  final Set<String> initialSelection;
  final Set<String> unavailableIds;
  final bool showAdvancedFilters;
  final bool selectable;

  @override
  State<YronExercisePicker> createState() => _YronExercisePickerState();
}

class _YronExercisePickerState extends State<YronExercisePicker> {
  final _search = TextEditingController();
  late final Set<String> _selected = {...widget.initialSelection}
    ..removeAll(widget.unavailableIds);
  String? _muscle;
  String? _equipment;
  String? _difficulty;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _search.text.trim().toLowerCase();
    final visible = widget.items.where((item) {
      return '${item.name} ${item.muscle} ${item.equipment}'
              .toLowerCase()
              .contains(query) &&
          (_muscle == null || item.muscle == _muscle) &&
          (_equipment == null || item.equipment == _equipment) &&
          (_difficulty == null || item.difficulty == _difficulty);
    }).toList();
    final muscles = widget.items.map((item) => item.muscle).toSet().toList()
      ..sort();
    final equipment =
        widget.items.map((item) => item.equipment).toSet().toList()..sort();
    final difficulties =
        widget.items.map((item) => item.difficulty).toSet().toList()..sort();

    final catalog = <Widget>[
      Padding(
        padding: const EdgeInsets.all(YronSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            YronSearchField(
              key: const ValueKey('exercise-search'),
              label: widget.searchLabel,
              controller: _search,
              clearTooltip: widget.clearTooltip,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: YronSpacing.md),
            Text(
              widget.muscleLabel,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: YronSpacing.xs),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: YronSpacing.sm),
                    child: YronChoiceChip(
                      label: widget.allLabel,
                      selected: _muscle == null,
                      onPressed: () => setState(() => _muscle = null),
                    ),
                  ),
                  for (final muscle in muscles)
                    Padding(
                      padding: const EdgeInsets.only(right: YronSpacing.sm),
                      child: YronChoiceChip(
                        key: ValueKey('muscle-$muscle'),
                        label: muscle,
                        selected: muscle == _muscle,
                        onPressed: () => setState(() => _muscle = muscle),
                      ),
                    ),
                ],
              ),
            ),
            if (widget.showAdvancedFilters) ...[
              const SizedBox(height: YronSpacing.sm),
              Wrap(
                spacing: YronSpacing.md,
                runSpacing: YronSpacing.sm,
                children: [
                  SizedBox(
                    width: 180,
                    child: DropdownButtonFormField<String>(
                      key: const ValueKey('equipment-filter'),
                      initialValue: _equipment,
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: widget.equipmentLabel,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: null,
                          child: Text(widget.allLabel),
                        ),
                        for (final value in equipment)
                          DropdownMenuItem(value: value, child: Text(value)),
                      ],
                      onChanged: (value) => setState(() => _equipment = value),
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: DropdownButtonFormField<String>(
                      key: const ValueKey('difficulty-filter'),
                      initialValue: _difficulty,
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: widget.difficultyLabel,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: null,
                          child: Text(widget.allLabel),
                        ),
                        for (final value in difficulties)
                          DropdownMenuItem(value: value, child: Text(value)),
                      ],
                      onChanged: (value) => setState(() => _difficulty = value),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
      if (visible.isEmpty)
        Padding(
          padding: const EdgeInsets.all(YronSpacing.md),
          child: YronEmptyState(
            title: widget.emptyTitle,
            description: widget.emptyDescription,
            icon: Icons.search_off,
          ),
        ),
      for (final item in visible)
        Padding(
          padding: const EdgeInsets.fromLTRB(
            YronSpacing.md,
            0,
            YronSpacing.md,
            YronSpacing.sm,
          ),
          child: Builder(
            builder: (context) {
              final disabled = widget.unavailableIds.contains(item.id);
              void toggle() {
                if (disabled) return;
                setState(() {
                  if (!_selected.remove(item.id)) _selected.add(item.id);
                });
              }

              return YronExerciseRow(
                key: ValueKey('exercise-${item.id}'),
                name: item.name,
                summary:
                    '${item.muscle} · ${item.equipment} · ${item.difficulty}',
                onTap: widget.selectable
                    ? (disabled ? null : toggle)
                    : () => widget.onDetails(item),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: '${widget.detailsTooltip}: ${item.name}',
                      onPressed: () => widget.onDetails(item),
                      icon: const Icon(Icons.info_outline),
                    ),
                    if (widget.selectable)
                      Checkbox(
                        value: disabled || _selected.contains(item.id),
                        semanticLabel: item.name,
                        onChanged: disabled ? null : (_) => toggle(),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
    ];
    final footer = Padding(
      padding: const EdgeInsets.all(YronSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.selectedLabel(_selected.length),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: YronSpacing.sm),
          Wrap(
            spacing: YronSpacing.sm,
            runSpacing: YronSpacing.sm,
            alignment: WrapAlignment.end,
            children: [
              YronButton(
                label: widget.cancelLabel,
                variant: YronButtonVariant.quiet,
                onPressed: widget.onCancel,
              ),
              YronButton(
                key: const ValueKey('confirm-exercises'),
                label: widget.confirmLabel(_selected.length),
                onPressed: _selected.isEmpty || widget.onConfirm == null
                    ? null
                    : () => widget.onConfirm!(Set.unmodifiable(_selected)),
              ),
            ],
          ),
        ],
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        // On short viewports (keyboard/landscape) or large accessibility text,
        // scroll everything instead of allowing a fixed footer to overflow.
        if (constraints.maxHeight < 360 ||
            MediaQuery.textScalerOf(context).scale(14) > 21) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [...catalog, if (widget.selectable) footer],
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: catalog,
                ),
              ),
            ),
            if (widget.selectable) footer,
          ],
        );
      },
    );
  }
}
