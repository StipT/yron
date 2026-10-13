import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import '../../l10n/l10n.dart';
import 'exercise_catalog.dart';

/// Independently routable sample library, also used by the day builder.
class ExerciseLibraryScreen extends StatelessWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog = buildExerciseCatalog(context.l10n);
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.exerciseLibraryTitle)),
      body: SafeArea(
        top: false,
        child: ExerciseCatalogView(
          catalog: catalog,
          selectable: false,
          onDetails: (exercise) => showExerciseDetails(context, exercise),
        ),
      ),
    );
  }
}

class ExerciseCatalogView extends StatelessWidget {
  const ExerciseCatalogView({
    super.key,
    required this.catalog,
    required this.onDetails,
    this.selectable = true,
    this.showAdvancedFilters = true,
    this.unavailableIds = const {},
    this.onConfirm,
    this.onCancel,
  });

  final List<LibraryExercise> catalog;
  final ValueChanged<LibraryExercise> onDetails;
  final bool selectable;
  final bool showAdvancedFilters;
  final Set<String> unavailableIds;
  final ValueChanged<List<LibraryExercise>>? onConfirm;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return YronExercisePicker(
      items: [
        for (final exercise in catalog)
          YronExercisePickerItem(
            id: exercise.id,
            name: exercise.name,
            muscle: exercise.muscle,
            equipment: exercise.equipment,
            difficulty: exercise.difficulty,
          ),
      ],
      searchLabel: l10n.exercisePickerSearchLabel,
      clearTooltip: l10n.exercisePickerClearTooltip,
      muscleLabel: l10n.exercisePickerMuscleLabel,
      equipmentLabel: l10n.exercisePickerEquipmentLabel,
      difficultyLabel: l10n.exercisePickerDifficultyLabel,
      allLabel: l10n.commonAll,
      emptyTitle: l10n.exercisePickerEmptyTitle,
      emptyDescription: l10n.exercisePickerEmptyDescription,
      detailsTooltip: l10n.exercisePickerDetailsTooltip,
      selectedLabel: (count) =>
          l10n.exercisePickerSelectedLabel(count).replaceCountMarker(count),
      confirmLabel: l10n.exercisePickerConfirmLabel,
      cancelLabel: l10n.commonCancel,
      selectable: selectable,
      showAdvancedFilters: showAdvancedFilters,
      unavailableIds: unavailableIds,
      onDetails: (item) =>
          onDetails(catalog.firstWhere((exercise) => exercise.id == item.id)),
      onCancel: onCancel,
      onConfirm: onConfirm == null
          ? null
          : (ids) => onConfirm!(
              catalog.where((exercise) => ids.contains(exercise.id)).toList(),
            ),
    );
  }
}

Future<void> showExerciseDetails(
  BuildContext context,
  LibraryExercise exercise,
) async {
  final l10n = context.l10n;
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
        YronButton(
          label: l10n.commonDone,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          YronSectionLabel(label: l10n.exerciseDetailsTechniqueLabel),
          const SizedBox(height: YronSpacing.sm),
          Text(
            exercise.instructions,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: YronSpacing.md),
          YronInfoCard(
            icon: Icons.self_improvement,
            title: l10n.exerciseDetailsInfoTitle,
            description: l10n.exerciseDetailsInfoDescription,
          ),
        ],
      ),
    ),
  );
}
