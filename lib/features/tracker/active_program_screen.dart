import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import '../program_creator/program_draft.dart';
import 'week_days_screen.dart';
import 'workout_sample.dart';

class ActiveProgramScreen extends StatefulWidget {
  const ActiveProgramScreen({
    super.key,
    this.program,
    required this.onStartWorkout,
    required this.onCreateProgram,
    required this.onLibrary,
  });

  final ProgramDraft? program;
  final ValueChanged<WorkoutSample> onStartWorkout;
  final VoidCallback onCreateProgram;
  final VoidCallback onLibrary;

  @override
  State<ActiveProgramScreen> createState() => _ActiveProgramScreenState();
}

class _ActiveProgramScreenState extends State<ActiveProgramScreen> {
  int _week = 1;

  @override
  Widget build(BuildContext context) {
    final program = widget.program;
    final weeks = program?.weeks ?? 10;
    final firstDay = program?.days.firstWhere((day) => !day.isRest);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TRACKER'),
        actions: [
          IconButton(
            tooltip: 'Exercise library',
            onPressed: widget.onLibrary,
            icon: const Icon(Icons.menu_book_outlined),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: ListView(
              padding: const EdgeInsets.all(YronSpacing.md),
              children: [
                const YronBadge(label: 'ACTIVE PROGRAM · SAMPLE MODE'),
                const SizedBox(height: YronSpacing.md),
                Text(
                  program?.name ?? 'HYPERTROPHY PHASE II',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: YronSpacing.sm),
                Text(
                  program == null
                      ? 'Program designer · Iron Coaching'
                      : 'Program designer · You · ${program.focus}',
                  style: const TextStyle(color: YronColors.textMuted),
                ),
                const SizedBox(height: YronSpacing.lg),
                YronCard(
                  child: Row(
                    children: [
                      IconButton(
                        tooltip: 'Previous week',
                        onPressed: _week > 1
                            ? () => setState(() => _week--)
                            : null,
                        icon: const Icon(Icons.chevron_left),
                      ),
                      Expanded(
                        child: Text(
                          'WEEK $_week OF $weeks',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Next week',
                        onPressed: _week < weeks
                            ? () => setState(() => _week++)
                            : null,
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: YronSpacing.lg),
                YronSectionHeader(
                  title: 'TODAY\'S WORKOUT',
                  subtitle: 'Day 1 of ${program?.workoutCount ?? 5}',
                ),
                const SizedBox(height: YronSpacing.md),
                YronWorkoutRow(
                  title: firstDay == null
                      ? 'Monday: Push Power'
                      : '${firstDay.name}: ${firstDay.title}',
                  summary: firstDay == null
                      ? '6 exercises · 18 sets · ~60 min'
                      : '${firstDay.exercises.length} exercises · '
                            '${firstDay.exercises.fold(0, (n, e) => n + e.sets)} sets',
                  status: const YronBadge(label: 'READY'),
                  onTap: () => _openWeek(context),
                ),
                const SizedBox(height: YronSpacing.md),
                const YronInfoCard(
                  icon: Icons.trending_up,
                  title: 'PROGRESSIVE OVERLOAD',
                  description:
                      'Target RPE 8.5. Review your last session before '
                      'adding load. Sample progression: +2.5 lbs.',
                ),
                const SizedBox(height: YronSpacing.lg),
                YronButton(
                  key: const ValueKey('start-workout'),
                  label: 'START WORKOUT',
                  icon: Icons.play_arrow,
                  expand: true,
                  onPressed: () => widget.onStartWorkout(
                    firstDay == null
                        ? WorkoutSample.shoulders
                        : WorkoutSample.fromDay(firstDay),
                  ),
                ),
                const SizedBox(height: YronSpacing.sm),
                YronButton(
                  key: const ValueKey('choose-workout-day'),
                  label: 'VIEW WEEK & CHOOSE DAY',
                  variant: YronButtonVariant.secondary,
                  expand: true,
                  onPressed: () => _openWeek(context),
                ),
                const SizedBox(height: YronSpacing.sm),
                YronButton(
                  label: 'CREATE NEW PROGRAM',
                  variant: YronButtonVariant.quiet,
                  onPressed: widget.onCreateProgram,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openWeek(BuildContext context) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => WeekDaysScreen(
          week: _week,
          program: widget.program,
          onStartWorkout: widget.onStartWorkout,
        ),
      ),
    );
  }
}
