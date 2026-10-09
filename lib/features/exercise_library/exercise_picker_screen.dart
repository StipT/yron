import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import 'exercise_catalog.dart';
import 'exercise_library_screen.dart';

/// Full-screen modal picker with muscle, equipment and difficulty filters.
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('SELECT EXERCISES'),
        leading: IconButton(
          tooltip: 'Cancel exercise selection',
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
                'Add exercises to $dayName',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: ExerciseCatalogView(
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

/// Keyboard-aware, tablet-width-constrained quick picker.
Future<List<LibraryExercise>?> showDayExercisePicker(
  BuildContext context, {
  required String dayName,
  Set<String> unavailableIds = const {},
}) {
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
                  'Add Exercises to $dayName',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: ExerciseCatalogView(
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
