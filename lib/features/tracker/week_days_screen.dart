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
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  static const _titles = [
    'Chest & Triceps',
    'Back & Biceps',
    'Rest & Recovery',
    'Legs & Abs (Quad Focus)',
    'Shoulders & Arms Hypertrophy',
    'Full Body',
    'Rest & Recovery',
  ];
  static const _months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];
  int _selectedDay = 4;

  bool _isRest(int index) =>
      widget.program?.days[index].isRest ?? (index == 2 || index == 6);

  String _title(int index) =>
      widget.program?.days[index].displayTitle ?? _titles[index];

  DateTime get _weekStart =>
      DateTime(2026, 8, 10).add(Duration(days: (widget.week - 4) * 7));

  String _dateLabel(DateTime date) => '${_months[date.month - 1]} ${date.day}';

  String _sampleStatus(int index) => switch (index) {
    0 || 1 => 'COMPLETED',
    2 || 6 => 'RECOVERY',
    3 => 'SKIPPED',
    4 => 'TODAY · READY',
    _ => 'UPCOMING',
  };

  Color _statusColor(int index) => switch (index) {
    2 || 6 => YronColors.secondary,
    3 => YronColors.tertiary,
    4 => YronColors.primary,
    5 => YronColors.textMuted,
    _ => YronColors.primary,
  };

  @override
  Widget build(BuildContext context) {
    final rest = _isRest(_selectedDay);
    final start = _weekStart;
    final end = start.add(const Duration(days: 6));
    return Scaffold(
      appBar: AppBar(title: const Text('SELECT WORKOUT DAY')),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: ListView(
              padding: const EdgeInsets.all(YronSpacing.md),
              children: [
                YronSectionHeader(
                  title: 'SELECT WORKOUT DAY',
                  subtitle:
                      widget.program?.name ??
                      'HYPERTROPHY OVERLOAD 1.0 · WEEK ${widget.week} '
                          '(${_dateLabel(start)} – ${_dateLabel(end)})',
                ),
                const SizedBox(height: YronSpacing.sm),
                const Text(
                  'Log your sets and compare against previous benchmarks '
                  'to keep making progress.',
                  style: TextStyle(color: YronColors.textMuted),
                ),
                const SizedBox(height: YronSpacing.md),
                if (widget.program == null)
                  YronCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.track_changes,
                              color: YronColors.primary,
                              size: 18,
                            ),
                            SizedBox(width: YronSpacing.sm),
                            Expanded(
                              child: Text('3 OF 5 COMPLETED · 1 SKIPPED'),
                            ),
                            Text(
                              '60%',
                              style: TextStyle(
                                color: YronColors.primary,
                                fontFamily: YronTypography.monoFamily,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: YronSpacing.sm),
                        const YronProgressBar(
                          value: .6,
                          semanticLabel: 'Weekly workout progress',
                          semanticValue: '60 percent',
                        ),
                      ],
                    ),
                  ),
                if (widget.program == null)
                  const SizedBox(height: YronSpacing.md),
                YronDaySelector(
                  labels: [
                    for (final (index, name) in _names.indexed)
                      '${name.substring(0, 3).toUpperCase()} '
                          '${_dateLabel(start.add(Duration(days: index))).split(' ').last}',
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
                      metrics: widget.program == null && index < 2
                          ? Text(
                              index == 0
                                  ? '4 Exercises · 14,200 KG Vol'
                                  : '4 Exercises logged',
                              style: const TextStyle(
                                color: YronColors.textMuted,
                              ),
                            )
                          : null,
                      status: YronBadge(
                        label: widget.program == null
                            ? _sampleStatus(index)
                            : _isRest(index)
                            ? 'RECOVERY'
                            : 'PLANNED',
                        color: widget.program == null
                            ? _statusColor(index)
                            : _isRest(index)
                            ? YronColors.secondary
                            : YronColors.primary,
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
                            ? WorkoutSample.forSampleDay(_selectedDay)
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
                if (widget.program != null)
                  const Text(
                    'Workout assignments from your local program draft.',
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
