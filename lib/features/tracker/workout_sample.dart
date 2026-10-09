import '../program_creator/program_draft.dart';

/// Session-only sample content; no persistence or workout service.
class WorkoutSample {
  const WorkoutSample({
    required this.title,
    required this.exercises,
  });

  final String title;
  final List<WorkoutExerciseSample> exercises;

  static const shoulders = WorkoutSample(
    title: 'SHOULDERS & ARMS HYPERTROPHY',
    exercises: [
      WorkoutExerciseSample(name: 'Seated Dumbbell Press', weight: 50, reps: 10),
      WorkoutExerciseSample(name: 'Dumbbell Lateral Raise', weight: 20, reps: 12),
      WorkoutExerciseSample(name: 'Cable Triceps Pushdown', weight: 40, reps: 12),
    ],
  );

  static WorkoutSample fromDay(ProgramDayDraft day) => WorkoutSample(
    title: day.title.toUpperCase(),
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
