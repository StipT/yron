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

const sampleExercises = <LibraryExercise>[
  LibraryExercise(
    id: 'bench-press',
    name: 'Barbell Bench Press',
    muscle: 'Chest',
    equipment: 'Barbell',
    difficulty: 'Intermediate',
    instructions:
        'Plant your feet and brace your torso. Lower the bar to your '
        'chest with control, then press up without lifting your hips.',
  ),
  LibraryExercise(
    id: 'incline-press',
    name: 'Incline Dumbbell Press',
    muscle: 'Chest',
    equipment: 'Dumbbell',
    difficulty: 'Beginner',
    instructions:
        'Set the bench to a modest incline. Keep your shoulder blades '
        'back and press the dumbbells above your upper chest.',
  ),
  LibraryExercise(
    id: 'cable-fly',
    name: 'Cable Chest Fly',
    muscle: 'Chest',
    equipment: 'Cable',
    difficulty: 'Beginner',
    instructions:
        'Keep a soft bend in your elbows. Bring the handles together '
        'in front of your chest, then return slowly to a comfortable stretch.',
  ),
  LibraryExercise(
    id: 'triceps-pushdown',
    name: 'Triceps Rope Pushdown',
    muscle: 'Triceps',
    equipment: 'Cable',
    difficulty: 'Beginner',
    instructions:
        'Hold your elbows close to your sides. Extend your arms and '
        'separate the rope ends, then return without moving your shoulders.',
  ),
  LibraryExercise(
    id: 'lat-pulldown',
    name: 'Lat Pulldown',
    muscle: 'Back',
    equipment: 'Cable',
    difficulty: 'Beginner',
    instructions:
        'Brace your torso and pull the bar toward your upper chest. '
        'Lead with your elbows and control the return.',
  ),
  LibraryExercise(
    id: 'barbell-row',
    name: 'Bent-Over Barbell Row',
    muscle: 'Back',
    equipment: 'Barbell',
    difficulty: 'Intermediate',
    instructions:
        'Hinge at your hips with a neutral spine. Pull the bar toward '
        'your lower ribs without swinging your torso.',
  ),
  LibraryExercise(
    id: 'biceps-curl',
    name: 'Dumbbell Biceps Curl',
    muscle: 'Biceps',
    equipment: 'Dumbbell',
    difficulty: 'Beginner',
    instructions:
        'Keep your upper arms still. Curl the dumbbells toward your '
        'shoulders and lower them with control.',
  ),
  LibraryExercise(
    id: 'squat',
    name: 'Barbell Back Squat',
    muscle: 'Quads',
    equipment: 'Barbell',
    difficulty: 'Advanced',
    instructions:
        'Brace before each repetition. Bend at your hips and knees '
        'to a comfortable depth, then drive through your whole foot.',
  ),
  LibraryExercise(
    id: 'leg-extension',
    name: 'Leg Extension',
    muscle: 'Quads',
    equipment: 'Machine',
    difficulty: 'Beginner',
    instructions:
        'Align your knees with the machine pivot. Extend your legs '
        'without locking your knees forcefully, then lower slowly.',
  ),
  LibraryExercise(
    id: 'plank',
    name: 'Plank',
    muscle: 'Abs',
    equipment: 'Bodyweight',
    difficulty: 'Beginner',
    instructions:
        'Keep your elbows below your shoulders and your body in a '
        'straight line. Brace and breathe steadily. For this timed exercise, '
        'the builder records seconds in the reps field.',
  ),
  LibraryExercise(
    id: 'overhead-press',
    name: 'Barbell Overhead Press',
    muscle: 'Shoulders',
    equipment: 'Barbell',
    difficulty: 'Intermediate',
    instructions:
        'Brace your torso and keep your ribs down. Press the bar '
        'overhead without leaning back, then return to shoulder height.',
  ),
  LibraryExercise(
    id: 'lateral-raise',
    name: 'Dumbbell Lateral Raise',
    muscle: 'Shoulders',
    equipment: 'Dumbbell',
    difficulty: 'Beginner',
    instructions:
        'With a soft elbow bend, raise your arms to shoulder height. '
        'Use a controlled pace and avoid shrugging or swinging.',
  ),
  LibraryExercise(
    id: 'face-pull',
    name: 'Cable Face Pull',
    muscle: 'Shoulders',
    equipment: 'Cable',
    difficulty: 'Intermediate',
    instructions:
        'Pull the rope toward your forehead with your elbows high. '
        'Keep your torso still and squeeze your shoulder blades gently.',
  ),
];
