import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import 'workout_sample.dart';

class ActiveWorkoutScreen extends StatefulWidget {
  const ActiveWorkoutScreen({
    super.key,
    this.workout = WorkoutSample.shoulders,
  });

  final WorkoutSample workout;

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _sets = [
    for (final exercise in widget.workout.exercises)
      [
        for (var i = 0; i < exercise.sets; i++)
          _LoggedSet(
            weight: exercise.weight.toStringAsFixed(0),
            reps: '${exercise.reps}',
          ),
      ],
  ];
  Timer? _timer;
  int _restSeconds = 90;
  bool _timerRunning = false;
  bool _allowExit = false;
  bool _exitDialogOpen = false;
  double _rpe = 8.5;

  Iterable<_LoggedSet> get _allSets => _sets.expand((sets) => sets);
  int get _completedCount => _allSets.where((set) => set.completed).length;
  double get _volume => _allSets
      .where((set) => set.completed)
      .fold(
        0,
        (total, set) => total + double.parse(set.weight) * int.parse(set.reps),
      );

  String? _validateWeight(String? value) {
    final number = double.tryParse(value ?? '');
    return number == null || !number.isFinite || number < 0 || number > 2000
        ? 'Enter 0–2000'
        : null;
  }

  String? _validateReps(String? value) {
    final number = int.tryParse(value ?? '');
    return number == null || number < 1 || number > 999 ? 'Enter 1–999' : null;
  }

  void _startRest(int seconds) {
    _timer?.cancel();
    setState(() {
      _restSeconds = seconds;
      _timerRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _restSeconds--;
        if (_restSeconds <= 0) {
          timer.cancel();
          _timerRunning = false;
        }
      });
    });
  }

  void _completeSet(_LoggedSet set, bool completed, int restSeconds) {
    if (completed && !(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    setState(() => set.completed = completed);
    if (completed) _startRest(restSeconds);
  }

  Future<void> _finish() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    if (_completedCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complete at least one set to finish.')),
      );
      return;
    }
    if (_completedCount < _allSets.length) {
      final finish = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Finish this workout?'),
          content: Text(
            '$_completedCount of ${_allSets.length} sets completed. '
            'Only completed sets will appear in your local history.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('KEEP TRAINING'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('FINISH WORKOUT'),
            ),
          ],
        ),
      );
      if (!mounted || finish != true) return;
    }
    final summary = WorkoutSessionSummary(
      title: widget.workout.title,
      completedSets: _completedCount,
      volume: _volume,
    );
    _timer?.cancel();
    setState(() => _allowExit = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) Navigator.pop(context, summary);
    });
  }

  Future<void> _requestExit() async {
    if (_exitDialogOpen) return;
    if (_completedCount == 0) {
      Navigator.pop(context);
      return;
    }
    _exitDialogOpen = true;
    final discard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard workout?'),
        content: const Text(
          'Your unfinished sample session will not be saved.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('KEEP TRAINING'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('DISCARD'),
          ),
        ],
      ),
    );
    _exitDialogOpen = false;
    if (!mounted || discard != true) return;
    setState(() => _allowExit = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<WorkoutSessionSummary>(
      canPop: _allowExit || _completedCount == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _requestExit();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            tooltip: 'Back',
            onPressed: _requestExit,
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('ACTIVE WORKOUT'),
        ),
        body: SafeArea(
          top: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 840),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(YronSpacing.md),
                  children: [
                    const YronBadge(label: 'LIVE SESSION · LOCAL SAMPLE'),
                    const SizedBox(height: YronSpacing.md),
                    Text(
                      widget.workout.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: YronSpacing.lg),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: YronStatCard(
                            label: 'VOLUME',
                            value: _volume.toStringAsFixed(0),
                            unit: 'lbs',
                            footer: Text(
                              '$_completedCount / ${_allSets.length} sets',
                            ),
                          ),
                        ),
                        const SizedBox(width: YronSpacing.sm),
                        Expanded(
                          child: YronStatCard(
                            label: 'REST TIMER',
                            value:
                                '${_restSeconds ~/ 60}:'
                                '${(_restSeconds % 60).toString().padLeft(2, '0')}',
                            accent: YronColors.secondary,
                            footer: YronButton(
                              label: _timerRunning ? 'PAUSE' : 'START',
                              variant: YronButtonVariant.quiet,
                              onPressed: () {
                                if (_timerRunning) {
                                  _timer?.cancel();
                                  setState(() => _timerRunning = false);
                                } else {
                                  _startRest(
                                    _restSeconds == 0 ? 90 : _restSeconds,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: YronSpacing.md),
                    const YronInfoCard(
                      icon: Icons.trending_up,
                      title: 'PROGRESSION · TARGET RPE 8.5',
                      description:
                          'Sample last session: 9 sets / 10,500 lbs. '
                          'Aim for controlled reps. Consider +2.5 lbs next '
                          'session only when your form and effort allow it.',
                    ),
                    const SizedBox(height: YronSpacing.md),
                    YronCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          YronSectionLabel(
                            label: 'SESSION RPE',
                            trailing: _rpe.toStringAsFixed(1),
                          ),
                          Slider(
                            value: _rpe,
                            min: 1,
                            max: 10,
                            divisions: 18,
                            label: _rpe.toStringAsFixed(1),
                            onChanged: (value) => setState(() => _rpe = value),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: YronSpacing.lg),
                    for (final (index, exercise)
                        in widget.workout.exercises.indexed)
                      Padding(
                        padding: const EdgeInsets.only(bottom: YronSpacing.md),
                        child: YronCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              YronSectionHeader(
                                title: exercise.name,
                                subtitle:
                                    '${exercise.sets} sets · ${exercise.reps} reps '
                                    '· ${exercise.restSeconds}s rest',
                              ),
                              const SizedBox(height: YronSpacing.sm),
                              for (final (setIndex, set)
                                  in _sets[index].indexed)
                                YronWorkoutSetRow(
                                  key: ValueKey('log-set-$index-$setIndex'),
                                  setLabel: '${setIndex + 1}',
                                  weightLabel: 'lbs',
                                  repsLabel: 'Reps',
                                  completeLabel:
                                      '${exercise.name} set ${setIndex + 1} complete',
                                  weight: set.weight,
                                  reps: set.reps,
                                  completed: set.completed,
                                  onWeightChanged: (value) =>
                                      set.weight = value,
                                  onRepsChanged: (value) => set.reps = value,
                                  onCompletedChanged: (value) => _completeSet(
                                    set,
                                    value,
                                    exercise.restSeconds,
                                  ),
                                  weightValidator: _validateWeight,
                                  repsValidator: _validateReps,
                                ),
                              YronButton(
                                label:
                                    _sets[index].every((set) => set.completed)
                                    ? 'UNDO EXERCISE'
                                    : 'COMPLETE EXERCISE',
                                variant: YronButtonVariant.secondary,
                                onPressed: () {
                                  final completed = !_sets[index].every(
                                    (set) => set.completed,
                                  );
                                  if (completed &&
                                      !(_formKey.currentState?.validate() ??
                                          false)) {
                                    return;
                                  }
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    for (final set in _sets[index]) {
                                      set.completed = completed;
                                    }
                                  });
                                  if (completed) {
                                    _startRest(exercise.restSeconds);
                                  }
                                },
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
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(YronSpacing.md),
            child: YronButton(
              key: const ValueKey('finish-workout'),
              label: 'FINISH WORKOUT',
              expand: true,
              icon: Icons.check,
              onPressed: _finish,
            ),
          ),
        ),
      ),
    );
  }
}

class _LoggedSet {
  _LoggedSet({required this.weight, required this.reps});

  String weight;
  String reps;
  bool completed = false;
}
