import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import '../program_creator/program_draft.dart';
import 'workout_sample.dart';

class WeekDaysScreen extends StatefulWidget {
  const WeekDaysScreen({
    super.key,
    required this.week,
    this.program,
    required this.onStartWorkout,
  });

  final int week;
  final ProgramDraft? program;
  final ValueChanged<WorkoutSample> onStartWorkout;

  @override
  State<WeekDaysScreen> createState() => _WeekDaysScreenState();
}

class _WeekDaysScreenState extends State<WeekDaysScreen> {
  static const _names = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday',
  ];
  static const _titles = [
    'Push Power',
    'Pull Strength',
    'Legs & Abs',
    'Rest & Recovery',
    'Shoulders & Arms Hypertrophy',
    'Full Body',
    'Rest & Recovery',
  ];
  int _selectedDay = 0;

  bool _isRest(int index) =>
      widget.program?.days[index].isRest ?? (index == 3 || index == 6);

  String _title(int index) =>
      widget.program?.days[index].displayTitle ?? _titles[index];

  @override
  Widget build(BuildContext context) {
    final rest = _isRest(_selectedDay);
    return Scaffold(
      appBar: AppBar(title: const Text('WEEK DAYS')),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: ListView(
              padding: const EdgeInsets.all(YronSpacing.md),
              children: [
                YronSectionHeader(
                  title: 'WEEK ${widget.week}',
                  subtitle: widget.program?.name ?? 'HYPERTROPHY PHASE II',
                ),
                const SizedBox(height: YronSpacing.md),
                YronDaySelector(
                  labels: [
                    for (final (index, name) in _names.indexed)
                      '${name.substring(0, 3).toUpperCase()} '
                          '${5 + (widget.week - 1) * 7 + index}',
                  ],
                  selectedIndex: _selectedDay,
                  onSelected: (index) => setState(() => _selectedDay = index),
                ),
                const SizedBox(height: YronSpacing.lg),
                for (final (index, name) in _names.indexed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: YronSpacing.sm),
                    child: YronWorkoutRow(
                      title: name,
                      summary: _title(index),
                      icon: _isRest(index)
                          ? Icons.self_improvement
                          : Icons.fitness_center,
                      status: YronBadge(
                        label: index == _selectedDay
                            ? 'SELECTED'
                            : _isRest(index)
                            ? 'REST'
                            : 'WORKOUT',
                      ),
                      onTap: () => setState(() => _selectedDay = index),
                    ),
                  ),
                const SizedBox(height: YronSpacing.md),
                YronInfoCard(
                  icon: rest ? Icons.self_improvement : Icons.timer_outlined,
                  title: '${_names[_selectedDay]} · ${_title(_selectedDay)}',
                  description: rest
                      ? 'Recovery is part of the plan. Choose a workout day '
                            'when you are ready to train.'
                      : 'Review the exercises and log each set in the session logger.',
                ),
                const SizedBox(height: YronSpacing.md),
                if (!rest)
                  YronButton(
                    label: 'START SELECTED WORKOUT',
                    expand: true,
                    onPressed: () {
                      final program = widget.program;
                      widget.onStartWorkout(
                        program == null
                            ? WorkoutSample(
                                title: _title(_selectedDay).toUpperCase(),
                                exercises: WorkoutSample.shoulders.exercises,
                              )
                            : WorkoutSample.fromDay(program.days[_selectedDay]),
                      );
                    },
                  )
                else
                  YronButton(
                    label: 'BACK TO PROGRAM',
                    variant: YronButtonVariant.secondary,
                    onPressed: () => Navigator.pop(context),
                  ),
                const SizedBox(height: YronSpacing.md),
                const Text(
                  'Sample week dates and workout assignments.',
                  style: TextStyle(color: YronColors.textMuted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
