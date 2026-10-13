import '../../l10n/gen/app_localizations.dart';

/// Local sample catalog; no persistence or network access.
class LibraryExercise {
  const LibraryExercise({
    required this.id,
    required this.name,
    required this.muscle,
    required this.equipment,
    required this.difficulty,
    required this.instructions,
  });

  final String id;
  final String name;
  final String muscle;
  final String equipment;
  final String difficulty;
  final String instructions;
}

List<LibraryExercise> buildExerciseCatalog(AppLocalizations l10n) => [
  LibraryExercise(
    id: 'bench-press',
    name: l10n.exerciseBenchPressName,
    muscle: l10n.muscleChest,
    equipment: l10n.equipmentBarbell,
    difficulty: l10n.difficultyIntermediate,
    instructions: l10n.exerciseBenchPressInstructions,
  ),
  LibraryExercise(
    id: 'incline-press',
    name: l10n.exerciseInclinePressName,
    muscle: l10n.muscleChest,
    equipment: l10n.equipmentDumbbell,
    difficulty: l10n.difficultyBeginner,
    instructions: l10n.exerciseInclinePressInstructions,
  ),
  LibraryExercise(
    id: 'cable-fly',
    name: l10n.exerciseCableFlyName,
    muscle: l10n.muscleChest,
    equipment: l10n.equipmentCable,
    difficulty: l10n.difficultyBeginner,
    instructions: l10n.exerciseCableFlyInstructions,
  ),
  LibraryExercise(
    id: 'triceps-pushdown',
    name: l10n.exerciseTricepsPushdownName,
    muscle: l10n.muscleTriceps,
    equipment: l10n.equipmentCable,
    difficulty: l10n.difficultyBeginner,
    instructions: l10n.exerciseTricepsPushdownInstructions,
  ),
  LibraryExercise(
    id: 'lat-pulldown',
    name: l10n.exerciseLatPulldownName,
    muscle: l10n.muscleBack,
    equipment: l10n.equipmentCable,
    difficulty: l10n.difficultyBeginner,
    instructions: l10n.exerciseLatPulldownInstructions,
  ),
  LibraryExercise(
    id: 'barbell-row',
    name: l10n.exerciseBarbellRowName,
    muscle: l10n.muscleBack,
    equipment: l10n.equipmentBarbell,
    difficulty: l10n.difficultyIntermediate,
    instructions: l10n.exerciseBarbellRowInstructions,
  ),
  LibraryExercise(
    id: 'biceps-curl',
    name: l10n.exerciseBicepsCurlName,
    muscle: l10n.muscleBiceps,
    equipment: l10n.equipmentDumbbell,
    difficulty: l10n.difficultyBeginner,
    instructions: l10n.exerciseBicepsCurlInstructions,
  ),
  LibraryExercise(
    id: 'squat',
    name: l10n.exerciseSquatName,
    muscle: l10n.muscleQuads,
    equipment: l10n.equipmentBarbell,
    difficulty: l10n.difficultyAdvanced,
    instructions: l10n.exerciseSquatInstructions,
  ),
  LibraryExercise(
    id: 'leg-extension',
    name: l10n.exerciseLegExtensionName,
    muscle: l10n.muscleQuads,
    equipment: l10n.equipmentMachine,
    difficulty: l10n.difficultyBeginner,
    instructions: l10n.exerciseLegExtensionInstructions,
  ),
  LibraryExercise(
    id: 'plank',
    name: l10n.exercisePlankName,
    muscle: l10n.muscleAbs,
    equipment: l10n.equipmentBodyweight,
    difficulty: l10n.difficultyBeginner,
    instructions: l10n.exercisePlankInstructions,
  ),
  LibraryExercise(
    id: 'overhead-press',
    name: l10n.exerciseOverheadPressName,
    muscle: l10n.muscleShoulders,
    equipment: l10n.equipmentBarbell,
    difficulty: l10n.difficultyIntermediate,
    instructions: l10n.exerciseOverheadPressInstructions,
  ),
  LibraryExercise(
    id: 'lateral-raise',
    name: l10n.exerciseLateralRaiseName,
    muscle: l10n.muscleShoulders,
    equipment: l10n.equipmentDumbbell,
    difficulty: l10n.difficultyBeginner,
    instructions: l10n.exerciseLateralRaiseInstructions,
  ),
  LibraryExercise(
    id: 'face-pull',
    name: l10n.exerciseFacePullName,
    muscle: l10n.muscleShoulders,
    equipment: l10n.equipmentCable,
    difficulty: l10n.difficultyIntermediate,
    instructions: l10n.exerciseFacePullInstructions,
  ),
];
