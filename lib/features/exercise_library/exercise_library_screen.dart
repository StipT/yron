import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import 'exercise_catalog.dart';

/// Independently routable sample library, also used by the day builder.
class ExerciseLibraryScreen extends StatelessWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EXERCISE LIBRARY')),
      body: SafeArea(
        top: false,
        child: ExerciseCatalogView(
          selectable: false,
          onDetails: (exercise) => showExerciseDetails(context, exercise),
        ),
      ),
    );
  }
}

/// Application adapter from the mock catalog to the shared picker organism.
class ExerciseCatalogView extends StatelessWidget {
  const ExerciseCatalogView({
    super.key,
    required this.onDetails,
    this.selectable = true,
    this.showAdvancedFilters = true,
    this.unavailableIds = const {},
    this.onConfirm,
    this.onCancel,
  });

  final ValueChanged<LibraryExercise> onDetails;
  final bool selectable;
  final bool showAdvancedFilters;
  final Set<String> unavailableIds;
  final ValueChanged<List<LibraryExercise>>? onConfirm;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return YronExercisePicker(
      items: [
        for (final exercise in sampleExercises)
          YronExercisePickerItem(
            id: exercise.id,
            name: exercise.name,
            muscle: exercise.muscle,
            equipment: exercise.equipment,
            difficulty: exercise.difficulty,
          ),
      ],
      searchLabel: 'Search exercises',
      clearTooltip: 'Clear search',
      muscleLabel: 'MUSCLE GROUP',
      equipmentLabel: 'Equipment',
      difficultyLabel: 'Difficulty',
      allLabel: 'All',
      emptyTitle: 'No matching exercises',
      emptyDescription: 'Try a different search or change your filters.',
      detailsTooltip: 'Exercise details',
      selectedLabel: (count) => '$count exercises selected',
      confirmLabel: (count) => 'ADD $count EXERCISES',
      cancelLabel: 'CANCEL',
      selectable: selectable,
      showAdvancedFilters: showAdvancedFilters,
      unavailableIds: unavailableIds,
      onDetails: (item) => onDetails(
        sampleExercises.firstWhere((exercise) => exercise.id == item.id),
      ),
      onCancel: onCancel,
      onConfirm: onConfirm == null
          ? null
          : (ids) => onConfirm!(
              sampleExercises
                  .where((exercise) => ids.contains(exercise.id))
                  .toList(),
            ),
    );
  }
}

Future<void> showExerciseDetails(
  BuildContext context,
  LibraryExercise exercise,
) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: false,
    constraints: const BoxConstraints(maxWidth: 640),
    builder: (context) => YronSheet(
      title: exercise.name,
      subtitle:
          '${exercise.muscle} · ${exercise.equipment} · ${exercise.difficulty}',
      actions: [
        YronButton(label: 'DONE', onPressed: () => Navigator.pop(context)),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const YronSectionLabel(label: 'TECHNIQUE'),
          const SizedBox(height: YronSpacing.sm),
          Text(
            exercise.instructions,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: YronSpacing.md),
          const YronInfoCard(
            icon: Icons.self_improvement,
            title: 'CONTROL EVERY REP',
            description:
                'Choose a load that lets you keep good form. Stop if '
                'you feel pain and ask a qualified coach for help.',
          ),
        ],
      ),
    ),
  );
}
