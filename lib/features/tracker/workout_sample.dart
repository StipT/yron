import '../../l10n/gen/app_localizations.dart';
import '../program_creator/program_draft.dart';

/// Session-only sample content; no persistence or workout service.
class WorkoutSample {
  const WorkoutSample({required this.title, required this.exercises});

  final String title;
  final List<WorkoutExerciseSample> exercises;

  static WorkoutSample shoulders(AppLocalizations l10n) => WorkoutSample(
    title: l10n.workoutTitleShouldersArmsHypertrophy.toUpperCase(),
    exercises: [
      WorkoutExerciseSample(
        name: l10n.exerciseSeatedDumbbellPressName,
        weight: 50,
        reps: 10,
      ),
      WorkoutExerciseSample(
        name: l10n.exerciseLateralRaiseName,
        weight: 20,
        reps: 12,
      ),
      WorkoutExerciseSample(
        name: l10n.exerciseCableTricepsPushdownName,
        weight: 40,
        reps: 12,
      ),
    ],
  );

  static WorkoutSample forSampleDay(int index, AppLocalizations l10n) =>
      switch (index) {
        0 => WorkoutSample(
          title: l10n.workoutTitleChestTriceps.toUpperCase(),
          exercises: [
            WorkoutExerciseSample(
              name: l10n.exerciseBenchPressName,
              weight: 185,
              reps: 8,
            ),
            WorkoutExerciseSample(
              name: l10n.exerciseInclinePressName,
              weight: 55,
              reps: 10,
            ),
            WorkoutExerciseSample(
              name: l10n.exerciseCableFlyName,
              weight: 25,
              reps: 12,
            ),
            WorkoutExerciseSample(
              name: l10n.exerciseTricepsPushdownName,
              weight: 40,
              reps: 12,
            ),
          ],
        ),
        1 => WorkoutSample(
          title: l10n.workoutTitleBackBiceps.toUpperCase(),
          exercises: [
            WorkoutExerciseSample(
              name: l10n.exerciseBarbellRowName,
              weight: 135,
              reps: 8,
            ),
            WorkoutExerciseSample(
              name: l10n.exerciseLatPulldownName,
              weight: 100,
              reps: 10,
            ),
            WorkoutExerciseSample(
              name: l10n.exerciseBicepsCurlName,
              weight: 25,
              reps: 12,
            ),
          ],
        ),
        3 => WorkoutSample(
          title: l10n.workoutTitleLegsAbs.toUpperCase(),
          exercises: [
            WorkoutExerciseSample(
              name: l10n.exerciseBarbellSquatName,
              weight: 225,
              reps: 8,
            ),
            WorkoutExerciseSample(
              name: l10n.exerciseLegExtensionName,
              weight: 90,
              reps: 12,
            ),
            WorkoutExerciseSample(
              name: l10n.exerciseCableCrunchName,
              weight: 40,
              reps: 15,
            ),
          ],
        ),
        4 => shoulders(l10n),
        5 => WorkoutSample(
          title: l10n.workoutTitleFullBody.toUpperCase(),
          exercises: [
            WorkoutExerciseSample(
              name: l10n.exerciseDeadliftName,
              weight: 275,
              reps: 5,
            ),
            WorkoutExerciseSample(
              name: l10n.exerciseBenchPressName,
              weight: 185,
              reps: 8,
            ),
            WorkoutExerciseSample(
              name: l10n.exerciseLatPulldownName,
              weight: 100,
              reps: 10,
            ),
          ],
        ),
        _ => throw ArgumentError.value(index, 'index', 'Not a workout day'),
      };

  static WorkoutSample fromDay(ProgramDayDraft day, AppLocalizations l10n) =>
      WorkoutSample(
        title: day.titleText(l10n).toUpperCase(),
        exercises: [
          for (final item in day.exercises)
            WorkoutExerciseSample(
              name: item.exercise.name,
              weight: 45,
              reps: item.reps,
              sets: item.sets,
              restSeconds: item.restSeconds,
            ),
        ],
      );
}

class WorkoutExerciseSample {
  const WorkoutExerciseSample({
    required this.name,
    required this.weight,
    required this.reps,
    this.sets = 3,
    this.restSeconds = 90,
  });

  final String name;
  final double weight;
  final int reps;
  final int sets;
  final int restSeconds;
}

class WorkoutSessionSummary {
  const WorkoutSessionSummary({
    required this.title,
    required this.completedSets,
    required this.volume,
  });

  final String title;
  final int completedSets;
  final double volume;
}
