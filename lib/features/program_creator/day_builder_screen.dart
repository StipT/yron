import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import '../exercise_library/exercise_catalog.dart';
import '../exercise_library/exercise_library_screen.dart';
import '../exercise_library/exercise_picker_screen.dart';
import 'program_creator_screen.dart';
import 'program_draft.dart';

class DayBuilderScreen extends StatefulWidget {
  const DayBuilderScreen({
    super.key,
    required this.draft,
    this.initialDayIndex = 0,
    this.returnToSplit = false,
    this.onProgramSaved,
  }) : assert(initialDayIndex >= 0 && initialDayIndex < 7);

  final ProgramDraft draft;
  final int initialDayIndex;
  final bool returnToSplit;
  final ValueChanged<ProgramDraft>? onProgramSaved;

  @override
  State<DayBuilderScreen> createState() => _DayBuilderScreenState();
}

class _DayBuilderScreenState extends State<DayBuilderScreen> {
  final _formKey = GlobalKey<FormState>();
  late int _dayIndex = widget.initialDayIndex;

  ProgramDayDraft get _day => widget.draft.days[_dayIndex];

  bool _validate() => _formKey.currentState?.validate() ?? true;

  void _selectDay(int index) {
    if (!_validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _dayIndex = index);
  }

  Future<void> _addExercises({bool fullScreen = false}) async {
    if (!_validate()) return;
    FocusScope.of(context).unfocus();
    final day = _day;
    final unavailable = day.exercises.map((item) => item.exercise.id).toSet();
    final selection = fullScreen
        ? Navigator.push<List<LibraryExercise>>(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => ExercisePickerScreen(
                dayName: day.name,
                unavailableIds: unavailable,
              ),
            ),
          )
        : showDayExercisePicker(
            context,
            dayName: day.name,
            unavailableIds: unavailable,
          );
    final exercises = await selection;
    if (!mounted || exercises == null || exercises.isEmpty) return;
    setState(() {
      day.isRest = false;
      if (day.title == 'Rest') day.title = 'Full Body';
      for (final exercise in exercises) {
        if (!day.exercises.any((item) => item.exercise.id == exercise.id)) {
          day.exercises.add(ProgramExerciseDraft(exercise: exercise));
        }
      }
    });
  }

  void _moveExercise(int oldIndex, int newIndex) {
    FocusScope.of(context).unfocus();
    setState(() {
      final exercise = _day.exercises.removeAt(oldIndex);
      _day.exercises.insert(newIndex, exercise);
    });
  }

  void _preview() {
    if (!_validate()) return;
    FocusScope.of(context).unfocus();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: 640),
      builder: (context) => YronSheet(
        title: '${_day.name} · ${_day.displayTitle}',
        subtitle: 'WORKOUT PREVIEW',
        actions: [
          YronButton(
            label: 'BACK TO BUILDER',
            onPressed: () => Navigator.pop(context),
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_day.isRest)
              const Text('Recovery day. No exercises scheduled.')
            else if (_day.exercises.isEmpty)
              const Text('Add exercises to build this workout.')
            else
              for (final item in _day.exercises)
                Padding(
                  padding: const EdgeInsets.only(bottom: YronSpacing.sm),
                  child: YronExerciseRow(
                    name: item.exercise.name,
                    summary: item.prescription,
                  ),
                ),
          ],
        ),
      ),
    );
  }

  void _continue() {
    if (!_validate()) return;
    FocusScope.of(context).unfocus();
    if (!_day.isRest && _day.exercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add an exercise or mark this day as rest.'),
        ),
      );
      return;
    }
    if (widget.returnToSplit) {
      Navigator.pop(context);
      return;
    }
    if (!widget.draft.isComplete) {
      final emptyIndex = widget.draft.days.indexWhere(
        (day) => !day.isRest && day.exercises.isEmpty,
      );
      if (emptyIndex >= 0) setState(() => _dayIndex = emptyIndex);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Every workout day needs at least one exercise.'),
        ),
      );
      return;
    }
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => ProgramCreatorScreen(
          draft: widget.draft,
          onProgramSaved: widget.onProgramSaved,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final day = _day;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('WORKOUT BUILDER'),
        actions: [
          IconButton(
            key: const ValueKey('builder-library'),
            tooltip: 'Exercise library',
            icon: const Icon(Icons.menu_book_outlined),
            onPressed: () => Navigator.push<void>(
              context,
              MaterialPageRoute(builder: (_) => const ExerciseLibraryScreen()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: YronSpacing.md,
                  ),
                  child: YronStepIndicator(
                    labels: const ['SETUP', 'WEEKLY SPLIT', 'BUILD'],
                    currentIndex: 2,
                  ),
                ),
                const SizedBox(height: YronSpacing.sm),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: YronSpacing.md,
                  ),
                  child: Row(
                    children: [
                      for (final (index, item) in widget.draft.days.indexed)
                        Padding(
                          padding: const EdgeInsets.only(right: YronSpacing.sm),
                          child: YronChoiceChip(
                            key: ValueKey('builder-day-$index'),
                            label: item.name.substring(0, 3).toUpperCase(),
                            selected: index == _dayIndex,
                            onPressed: () => _selectDay(index),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      padding: const EdgeInsets.all(YronSpacing.md),
                      children: [
                        Text(
                          day.name.toUpperCase(),
                          style: textTheme.labelSmall?.copyWith(
                            color: YronColors.primary,
                          ),
                        ),
                        const SizedBox(height: YronSpacing.sm),
                        Text(day.displayTitle, style: textTheme.headlineMedium),
                        const SizedBox(height: YronSpacing.md),
                        if (day.isRest)
                          YronEmptyState(
                            icon: Icons.self_improvement,
                            title: 'Rest & recovery',
                            description:
                                'No workout is scheduled. Adding an '
                                'exercise turns this into a workout day.',
                            action: YronButton(
                              label: 'BUILD A WORKOUT',
                              onPressed: () => _addExercises(),
                            ),
                          )
                        else ...[
                          TextFormField(
                            key: ValueKey('workout-title-$_dayIndex'),
                            initialValue: day.title,
                            decoration: const InputDecoration(
                              labelText: 'Workout name',
                            ),
                            textCapitalization: TextCapitalization.words,
                            onChanged: (value) {
                              if (value.trim().isNotEmpty) {
                                day.title = value.trim();
                              }
                            },
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                ? 'Enter a workout name.'
                                : null,
                          ),
                          const SizedBox(height: YronSpacing.lg),
                          YronSectionLabel(
                            label: 'EXERCISE PRESCRIPTIONS',
                            trailing: '${day.exercises.length} EXERCISES',
                          ),
                          const SizedBox(height: YronSpacing.md),
                          if (day.exercises.isEmpty)
                            const YronEmptyState(
                              icon: Icons.fitness_center,
                              title: 'Build your first exercise',
                              description:
                                  'Add exercises below, then choose '
                                  'sets, reps and rest for each one.',
                            ),
                          ReorderableListView.builder(
                            key: ValueKey('day-exercises-$_dayIndex'),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            buildDefaultDragHandles: false,
                            itemCount: day.exercises.length,
                            onReorder: (oldIndex, newIndex) => _moveExercise(
                              oldIndex,
                              newIndex > oldIndex ? newIndex - 1 : newIndex,
                            ),
                            itemBuilder: (context, index) {
                              final item = day.exercises[index];
                              return Padding(
                                key: ValueKey(
                                  'prescription-$_dayIndex-${item.exercise.id}',
                                ),
                                padding: const EdgeInsets.only(
                                  bottom: YronSpacing.md,
                                ),
                                child: YronProgramExerciseEditor(
                                  name: item.exercise.name,
                                  subtitle: item.exercise.muscle,
                                  sets: item.sets,
                                  reps: item.reps,
                                  restSeconds: item.restSeconds,
                                  setsLabel: 'Sets',
                                  repsLabel: item.exercise.id == 'plank'
                                      ? 'Hold (sec)'
                                      : 'Reps',
                                  restLabel: 'Rest (sec)',
                                  rangeError: (min, max) => 'Enter $min–$max.',
                                  onSetsChanged: (value) => item.sets = value,
                                  onRepsChanged: (value) => item.reps = value,
                                  onRestChanged: (value) =>
                                      item.restSeconds = value,
                                  deleteTooltip: 'Delete ${item.exercise.name}',
                                  moveUpTooltip:
                                      'Move ${item.exercise.name} up',
                                  moveDownTooltip:
                                      'Move ${item.exercise.name} down',
                                  onMoveUp: index == 0
                                      ? null
                                      : () => _moveExercise(index, index - 1),
                                  onMoveDown: index == day.exercises.length - 1
                                      ? null
                                      : () => _moveExercise(index, index + 1),
                                  onDelete: () => setState(
                                    () => day.exercises.removeAt(index),
                                  ),
                                  detailsTooltip:
                                      'Details: ${item.exercise.name}',
                                  onDetails: () => showExerciseDetails(
                                    context,
                                    item.exercise,
                                  ),
                                  dragHandle: ReorderableDragStartListener(
                                    index: index,
                                    child: Tooltip(
                                      message: 'Drag to reorder',
                                      child: const SizedBox.square(
                                        dimension: 48,
                                        child: Icon(Icons.drag_indicator),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                        const SizedBox(height: YronSpacing.sm),
                        Wrap(
                          spacing: YronSpacing.sm,
                          runSpacing: YronSpacing.sm,
                          children: [
                            YronButton(
                              key: const ValueKey('builder-add-exercises'),
                              label: 'ADD EXERCISES',
                              icon: Icons.add,
                              onPressed: () => _addExercises(),
                            ),
                            YronButton(
                              key: const ValueKey('builder-full-picker'),
                              label: 'BROWSE ALL EXERCISES',
                              variant: YronButtonVariant.secondary,
                              onPressed: () => _addExercises(fullScreen: true),
                            ),
                            YronButton(
                              key: const ValueKey('builder-preview'),
                              label: 'PREVIEW',
                              variant: YronButtonVariant.quiet,
                              icon: Icons.visibility_outlined,
                              onPressed: _preview,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(YronSpacing.md),
          child: YronButton(
            key: const ValueKey('builder-continue'),
            expand: true,
            label: widget.returnToSplit
                ? 'SAVE DAY & RETURN'
                : 'CONTINUE: REVIEW PROGRAM',
            icon: Icons.arrow_forward,
            onPressed: _continue,
          ),
        ),
      ),
    );
  }
}
