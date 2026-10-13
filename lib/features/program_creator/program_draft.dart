import '../../l10n/gen/app_localizations.dart';
import '../../l10n/l10n.dart';
import '../exercise_library/exercise_catalog.dart';

enum ProgramFocus { hypertrophy, strength, powerlifting, bodybuilding }

enum WorkoutTitleId {
  chestTriceps,
  backBiceps,
  rest,
  legsAbsQuadFocus,
  shoulders,
  fullBody,
}

List<String> localizedWeekdayNames(AppLocalizations l10n) => [
  l10n.dayMonday,
  l10n.dayTuesday,
  l10n.dayWednesday,
  l10n.dayThursday,
  l10n.dayFriday,
  l10n.daySaturday,
  l10n.daySunday,
];

List<String> localizedWeekdayShortNames(AppLocalizations l10n) => [
  l10n.dayMondayShort,
  l10n.dayTuesdayShort,
  l10n.dayWednesdayShort,
  l10n.dayThursdayShort,
  l10n.dayFridayShort,
  l10n.daySaturdayShort,
  l10n.daySundayShort,
];

List<String> localizedStepLabels(AppLocalizations l10n) => [
  l10n.stepSetup,
  l10n.stepWeeklySplit,
  l10n.stepBuild,
];

String programFocusLabel(AppLocalizations l10n, ProgramFocus focus) =>
    switch (focus) {
      ProgramFocus.hypertrophy => l10n.focusHypertrophy,
      ProgramFocus.strength => l10n.focusStrength,
      ProgramFocus.powerlifting => l10n.focusPowerlifting,
      ProgramFocus.bodybuilding => l10n.focusBodybuilding,
    };

String workoutTitleLabel(AppLocalizations l10n, WorkoutTitleId id) =>
    switch (id) {
      WorkoutTitleId.chestTriceps => l10n.workoutTitleChestTriceps,
      WorkoutTitleId.backBiceps => l10n.workoutTitleBackBiceps,
      WorkoutTitleId.rest => l10n.workoutTitleRest,
      WorkoutTitleId.legsAbsQuadFocus => l10n.workoutTitleLegsAbsQuadFocus,
      WorkoutTitleId.shoulders => l10n.workoutTitleShoulders,
      WorkoutTitleId.fullBody => l10n.workoutTitleFullBody,
    };

/// Mutable screen-local draft passed explicitly between creation routes.
class ProgramDraft {
  ProgramDraft({
    required this.name,
    required this.philosophy,
    required this.focus,
    required this.weeks,
    required List<LibraryExercise> catalog,
  }) : days = [
         ProgramDayDraft(
           weekdayIndex: 0,
           titleId: WorkoutTitleId.chestTriceps,
           catalog: catalog,
           exerciseIds: ['bench-press', 'incline-press', 'triceps-pushdown'],
         ),
         ProgramDayDraft(
           weekdayIndex: 1,
           titleId: WorkoutTitleId.backBiceps,
           catalog: catalog,
           exerciseIds: ['lat-pulldown', 'barbell-row', 'biceps-curl'],
         ),
         ProgramDayDraft(
           weekdayIndex: 2,
           titleId: WorkoutTitleId.rest,
           catalog: catalog,
           isRest: true,
         ),
         ProgramDayDraft(
           weekdayIndex: 3,
           titleId: WorkoutTitleId.legsAbsQuadFocus,
           catalog: catalog,
           exerciseIds: ['squat', 'leg-extension', 'plank'],
         ),
         ProgramDayDraft(
           weekdayIndex: 4,
           titleId: WorkoutTitleId.shoulders,
           catalog: catalog,
           exerciseIds: ['overhead-press', 'lateral-raise', 'face-pull'],
         ),
         ProgramDayDraft(
           weekdayIndex: 5,
           titleId: WorkoutTitleId.rest,
           catalog: catalog,
           isRest: true,
         ),
         ProgramDayDraft(
           weekdayIndex: 6,
           titleId: WorkoutTitleId.rest,
           catalog: catalog,
           isRest: true,
         ),
       ];

  final String name;
  final String philosophy;
  final ProgramFocus focus;
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
    required this.weekdayIndex,
    required this.titleId,
    this.customTitle,
    this.isRest = false,
    required List<LibraryExercise> catalog,
    List<String> exerciseIds = const [],
  }) : exercises = [
         for (final id in exerciseIds)
           ProgramExerciseDraft(
             exercise: catalog.firstWhere((item) => item.id == id),
           ),
       ];

  final int weekdayIndex;
  WorkoutTitleId titleId;
  String? customTitle;
  bool isRest;
  final List<ProgramExerciseDraft> exercises;

  String name(AppLocalizations l10n) =>
      localizedWeekdayNames(l10n)[weekdayIndex];

  String titleText(AppLocalizations l10n) {
    final custom = customTitle?.trim();
    if (custom != null && custom.isNotEmpty) return custom;
    return workoutTitleLabel(l10n, titleId);
  }

  String displayTitle(AppLocalizations l10n) =>
      isRest ? l10n.workoutTitleRestRecovery : titleText(l10n);

  void updateTitle(String value, AppLocalizations l10n) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;
    customTitle = trimmed == workoutTitleLabel(l10n, titleId) ? null : trimmed;
  }

  void activateWorkoutDefault() {
    isRest = false;
    if (titleId == WorkoutTitleId.rest &&
        (customTitle == null || customTitle!.trim().isEmpty)) {
      titleId = WorkoutTitleId.fullBody;
    }
  }
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

  String prescription(AppLocalizations l10n) => exercise.id == 'plank'
      ? l10n
            .programExercisePrescriptionHold(sets, reps, restSeconds)
            .replaceCountMarker(sets)
      : l10n
            .programExercisePrescriptionReps(sets, reps, restSeconds)
            .replaceCountMarker(sets);
}
