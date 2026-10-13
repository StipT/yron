import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import '../../l10n/l10n.dart';
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
                dayName: day.name(context.l10n),
                unavailableIds: unavailable,
              ),
            ),
          )
        : showDayExercisePicker(
            context,
            dayName: day.name(context.l10n),
            unavailableIds: unavailable,
          );
    final exercises = await selection;
    if (!mounted || exercises == null || exercises.isEmpty) return;
    setState(() {
      day.activateWorkoutDefault();
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
    final l10n = context.l10n;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: 640),
      builder: (context) => YronSheet(
        title: '${_day.name(l10n)} · ${_day.displayTitle(l10n)}',
        subtitle: l10n.dayBuilderPreviewTitle,
        actions: [
          YronButton(
            label: l10n.dayBuilderBackToBuilderButton,
            onPressed: () => Navigator.pop(context),
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_day.isRest)
              Text(l10n.dayBuilderPreviewRestDescription)
            else if (_day.exercises.isEmpty)
              Text(l10n.dayBuilderPreviewEmptyDescription)
            else
              for (final item in _day.exercises)
                Padding(
                  padding: const EdgeInsets.only(bottom: YronSpacing.sm),
                  child: YronExerciseRow(
                    name: item.exercise.name,
                    summary: item.prescription(l10n),
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
    final l10n = context.l10n;
    if (!_day.isRest && _day.exercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.dayBuilderAddExerciseOrRestError)),
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
        SnackBar(content: Text(l10n.dayBuilderEveryWorkoutNeedsExerciseError)),
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
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final shortDayNames = localizedWeekdayShortNames(l10n);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dayBuilderTitle),
        actions: [
          IconButton(
            key: const ValueKey('builder-library'),
            tooltip: l10n.commonExerciseLibraryTooltip,
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
                    labels: localizedStepLabels(l10n),
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
                      for (final (index, _) in widget.draft.days.indexed)
                        Padding(
                          padding: const EdgeInsets.only(right: YronSpacing.sm),
                          child: YronChoiceChip(
                            key: ValueKey('builder-day-$index'),
                            label: shortDayNames[index],
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
                          day.name(l10n).toUpperCase(),
                          style: textTheme.labelSmall?.copyWith(
                            color: YronColors.primary,
                          ),
                        ),
                        const SizedBox(height: YronSpacing.sm),
                        Text(
                          day.displayTitle(l10n),
                          style: textTheme.headlineMedium,
                        ),
                        const SizedBox(height: YronSpacing.md),
                        if (day.isRest)
                          YronEmptyState(
                            icon: Icons.self_improvement,
                            title: l10n.dayBuilderRestRecoveryTitle,
                            description: l10n.dayBuilderRestRecoveryDescription,
                            action: YronButton(
                              label: l10n.dayBuilderBuildWorkoutButton,
                              onPressed: () => _addExercises(),
                            ),
                          )
                        else ...[
                          TextFormField(
                            key: ValueKey('workout-title-$_dayIndex'),
                            initialValue: day.titleText(l10n),
                            decoration: InputDecoration(
                              labelText: l10n.dayBuilderWorkoutNameLabel,
                            ),
                            textCapitalization: TextCapitalization.words,
                            onChanged: (value) => day.updateTitle(value, l10n),
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                ? l10n.dayBuilderWorkoutNameRequiredError
                                : null,
                          ),
                          const SizedBox(height: YronSpacing.lg),
                          YronSectionLabel(
                            label: l10n.dayBuilderExercisePrescriptionsLabel,
                            trailing: l10n.dayBuilderExerciseCount(
                              day.exercises.length,
                            ),
                          ),
                          const SizedBox(height: YronSpacing.md),
                          if (day.exercises.isEmpty)
                            YronEmptyState(
                              icon: Icons.fitness_center,
                              title: l10n.dayBuilderEmptyTitle,
                              description: l10n.dayBuilderEmptyDescription,
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
                                  setsLabel: l10n.dayBuilderSetsLabel,
                                  repsLabel: item.exercise.id == 'plank'
                                      ? l10n.dayBuilderHoldSecondsLabel
                                      : l10n.dayBuilderRepsLabel,
                                  restLabel: l10n.dayBuilderRestSecondsLabel,
                                  rangeError: l10n.dayBuilderRangeError,
                                  onSetsChanged: (value) => item.sets = value,
                                  onRepsChanged: (value) => item.reps = value,
                                  onRestChanged: (value) =>
                                      item.restSeconds = value,
                                  deleteTooltip: l10n.dayBuilderDeleteTooltip(
                                    item.exercise.name,
                                  ),
                                  moveUpTooltip: l10n.dayBuilderMoveUpTooltip(
                                    item.exercise.name,
                                  ),
                                  moveDownTooltip: l10n
                                      .dayBuilderMoveDownTooltip(
                                        item.exercise.name,
                                      ),
                                  onMoveUp: index == 0
                                      ? null
                                      : () => _moveExercise(index, index - 1),
                                  onMoveDown: index == day.exercises.length - 1
                                      ? null
                                      : () => _moveExercise(index, index + 1),
                                  onDelete: () => setState(
                                    () => day.exercises.removeAt(index),
                                  ),
                                  detailsTooltip: l10n.dayBuilderDetailsTooltip(
                                    item.exercise.name,
                                  ),
                                  onDetails: () => showExerciseDetails(
                                    context,
                                    item.exercise,
                                  ),
                                  dragHandle: ReorderableDragStartListener(
                                    index: index,
                                    child: Tooltip(
                                      message: l10n.dayBuilderDragTooltip,
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
                              label: l10n.commonAddExercises,
                              icon: Icons.add,
                              onPressed: () => _addExercises(),
                            ),
                            YronButton(
                              key: const ValueKey('builder-full-picker'),
                              label: l10n.commonBrowseAllExercises,
                              variant: YronButtonVariant.secondary,
                              onPressed: () => _addExercises(fullScreen: true),
                            ),
                            YronButton(
                              key: const ValueKey('builder-preview'),
                              label: l10n.commonPreview,
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
                ? l10n.dayBuilderSaveAndReturnButton
                : l10n.dayBuilderContinueButton,
            icon: Icons.arrow_forward,
            onPressed: _continue,
          ),
        ),
      ),
    );
  }
}
