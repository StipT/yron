import '../program_creator/program_draft.dart';

/// Session-only sample content; no persistence or workout service.
class WorkoutSample {
  const WorkoutSample({required this.title, required this.exercises});

  final String title;
  final List<WorkoutExerciseSample> exercises;

  static const shoulders = WorkoutSample(
    title: 'SHOULDERS & ARMS HYPERTROPHY',
    exercises: [
      WorkoutExerciseSample(
        name: 'Seated Dumbbell Press',
        weight: 50,
        reps: 10,
      ),
      WorkoutExerciseSample(
        name: 'Dumbbell Lateral Raise',
        weight: 20,
        reps: 12,
      ),
      WorkoutExerciseSample(
        name: 'Cable Triceps Pushdown',
        weight: 40,
        reps: 12,
      ),
    ],
  );

  static WorkoutSample forSampleDay(int index) => switch (index) {
    0 => const WorkoutSample(
      title: 'CHEST & TRICEPS',
      exercises: [
        WorkoutExerciseSample(
          name: 'Barbell Bench Press',
          weight: 185,
          reps: 8,
        ),
        WorkoutExerciseSample(
          name: 'Incline Dumbbell Press',
          weight: 55,
          reps: 10,
        ),
        WorkoutExerciseSample(name: 'Cable Chest Fly', weight: 25, reps: 12),
        WorkoutExerciseSample(
          name: 'Triceps Rope Pushdown',
          weight: 40,
          reps: 12,
        ),
      ],
    ),
    1 => const WorkoutSample(
      title: 'BACK & BICEPS',
      exercises: [
        WorkoutExerciseSample(
          name: 'Bent-Over Barbell Row',
          weight: 135,
          reps: 8,
        ),
        WorkoutExerciseSample(name: 'Lat Pulldown', weight: 100, reps: 10),
        WorkoutExerciseSample(
          name: 'Dumbbell Biceps Curl',
          weight: 25,
          reps: 12,
        ),
      ],
    ),
    3 => const WorkoutSample(
      title: 'LEGS & ABS',
      exercises: [
        WorkoutExerciseSample(name: 'Barbell Squat', weight: 225, reps: 8),
        WorkoutExerciseSample(name: 'Leg Extension', weight: 90, reps: 12),
        WorkoutExerciseSample(name: 'Cable Crunch', weight: 40, reps: 15),
      ],
    ),
    4 => shoulders,
    5 => const WorkoutSample(
      title: 'FULL BODY',
      exercises: [
        WorkoutExerciseSample(name: 'Deadlift', weight: 275, reps: 5),
        WorkoutExerciseSample(
          name: 'Barbell Bench Press',
          weight: 185,
          reps: 8,
        ),
        WorkoutExerciseSample(name: 'Lat Pulldown', weight: 100, reps: 10),
      ],
    ),
    _ => throw ArgumentError.value(index, 'index', 'Not a workout day'),
  };

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
