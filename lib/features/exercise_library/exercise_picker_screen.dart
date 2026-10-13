import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import '../../l10n/l10n.dart';
import 'exercise_catalog.dart';
import 'exercise_library_screen.dart';

class ExercisePickerScreen extends StatelessWidget {
  const ExercisePickerScreen({
    super.key,
    required this.dayName,
    this.unavailableIds = const {},
  });

  final String dayName;
  final Set<String> unavailableIds;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final catalog = buildExerciseCatalog(l10n);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.exercisePickerTitle),
        leading: IconButton(
          tooltip: l10n.exercisePickerCancelTooltip,
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(YronSpacing.md),
              child: Text(
                l10n.exercisePickerAddToDay(dayName),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: ExerciseCatalogView(
                catalog: catalog,
                unavailableIds: unavailableIds,
                onDetails: (exercise) => showExerciseDetails(context, exercise),
                onCancel: () => Navigator.pop(context),
                onConfirm: (exercises) => Navigator.pop(context, exercises),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<LibraryExercise>?> showDayExercisePicker(
  BuildContext context, {
  required String dayName,
  Set<String> unavailableIds = const {},
}) {
  final l10n = context.l10n;
  final catalog = buildExerciseCatalog(l10n);
  return showModalBottomSheet<List<LibraryExercise>>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    constraints: const BoxConstraints(maxWidth: 720),
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: FractionallySizedBox(
        heightFactor: .9,
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(YronSpacing.md),
                child: Text(
                  l10n.exercisePickerAddToDayTitle(dayName),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: ExerciseCatalogView(
                  catalog: catalog,
                  showAdvancedFilters: false,
                  unavailableIds: unavailableIds,
                  onDetails: (exercise) =>
                      showExerciseDetails(context, exercise),
                  onCancel: () => Navigator.pop(context),
                  onConfirm: (exercises) => Navigator.pop(context, exercises),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
