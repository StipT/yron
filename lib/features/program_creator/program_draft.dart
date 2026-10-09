import '../exercise_library/exercise_catalog.dart';

/// Mutable screen-local draft passed explicitly between creation routes.
class ProgramDraft {
  ProgramDraft({
    required this.name,
    required this.philosophy,
    required this.focus,
    required this.weeks,
  }) : days = [
         ProgramDayDraft(
           name: 'Monday',
           title: 'Chest & Triceps',
           exerciseIds: ['bench-press', 'incline-press', 'triceps-pushdown'],
         ),
         ProgramDayDraft(
           name: 'Tuesday',
           title: 'Back & Biceps',
           exerciseIds: ['lat-pulldown', 'barbell-row', 'biceps-curl'],
         ),
         ProgramDayDraft(name: 'Wednesday', title: 'Rest', isRest: true),
         ProgramDayDraft(
           name: 'Thursday',
           title: 'Legs & Abs (Quad Focus)',
           exerciseIds: ['squat', 'leg-extension', 'plank'],
         ),
         ProgramDayDraft(
           name: 'Friday',
           title: 'Shoulders',
           exerciseIds: ['overhead-press', 'lateral-raise', 'face-pull'],
         ),
         ProgramDayDraft(name: 'Saturday', title: 'Rest', isRest: true),
         ProgramDayDraft(name: 'Sunday', title: 'Rest', isRest: true),
       ];

  final String name;
  final String philosophy;
  final String focus;
  final int weeks;
  final List<ProgramDayDraft> days;

  int get workoutCount => days.where((day) => !day.isRest).length;
  int get totalSets => days
      .where((day) => !day.isRest)
      .expand((day) => day.exercises)
      .fold(0, (total, exercise) => total + exercise.sets);

  bool get isComplete =>
      workoutCount > 0 &&
      days.where((day) => !day.isRest).every((day) => day.exercises.isNotEmpty);
}

class ProgramDayDraft {
  ProgramDayDraft({
    required this.name,
    required this.title,
    this.isRest = false,
    List<String> exerciseIds = const [],
  }) : exercises = [
         for (final id in exerciseIds)
           ProgramExerciseDraft(
             exercise: sampleExercises.firstWhere((item) => item.id == id),
           ),
       ];

  final String name;
  String title;
  bool isRest;
  final List<ProgramExerciseDraft> exercises;

  String get displayTitle => isRest ? 'Rest & Recovery' : title;
}

class ProgramExerciseDraft {
  ProgramExerciseDraft({
    required this.exercise,
    this.sets = 3,
    this.reps = 10,
    this.restSeconds = 90,
  });

  final LibraryExercise exercise;
  int sets;
  int reps;
  int restSeconds;

  String get prescription =>
      '$sets sets × $reps ${exercise.id == 'plank' ? 'sec hold' : 'reps'}'
      ' · ${restSeconds}s rest';
}
