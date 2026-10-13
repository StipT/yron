import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import '../../l10n/l10n.dart';
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
    final l10n = context.l10n;
    final program = widget.program;
    final weeks = program?.weeks ?? 10;
    final firstDay = program?.days.firstWhere((day) => !day.isRest);
    final firstDaySets = firstDay?.exercises.fold(0, (n, e) => n + e.sets) ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.activeProgramTitle),
        actions: [
          IconButton(
            tooltip: l10n.commonExerciseLibraryTooltip,
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
                YronBadge(label: l10n.activeProgramSampleBadge),
                const SizedBox(height: YronSpacing.md),
                Text(
                  program?.name ?? l10n.activeProgramSampleName,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: YronSpacing.sm),
                Text(
                  program == null
                      ? l10n.activeProgramSampleDesignerSubtitle
                      : l10n.activeProgramCustomDesignerSubtitle(
                          programFocusLabel(l10n, program.focus),
                        ),
                  style: const TextStyle(color: YronColors.textMuted),
                ),
                const SizedBox(height: YronSpacing.lg),
                YronCard(
                  child: Row(
                    children: [
                      IconButton(
                        tooltip: l10n.activeProgramPreviousWeekTooltip,
                        onPressed: _week > 1
                            ? () => setState(() => _week--)
                            : null,
                        icon: const Icon(Icons.chevron_left),
                      ),
                      Expanded(
                        child: Text(
                          l10n.activeProgramWeekLabel(_week, weeks),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      IconButton(
                        tooltip: l10n.activeProgramNextWeekTooltip,
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
                  title: l10n.activeProgramTodayTitle,
                  subtitle: l10n.activeProgramTodaySubtitle(
                    program?.workoutCount ?? 5,
                  ),
                ),
                const SizedBox(height: YronSpacing.md),
                YronWorkoutRow(
                  title: firstDay == null
                      ? '${l10n.dayMonday}: ${l10n.workoutTitleChestTriceps}'
                      : '${firstDay.name(l10n)}: ${firstDay.titleText(l10n)}',
                  summary: firstDay == null
                      ? l10n.activeProgramSampleWorkoutSummary
                      : l10n.activeProgramWorkoutSummary(
                          firstDay.exercises.length,
                          firstDaySets,
                        ),
                  status: YronBadge(label: l10n.activeProgramReadyBadge),
                  onTap: () => _openWeek(context),
                ),
                const SizedBox(height: YronSpacing.md),
                YronInfoCard(
                  icon: Icons.trending_up,
                  title: l10n.activeProgramInfoTitle,
                  description: l10n.activeProgramInfoDescription,
                ),
                const SizedBox(height: YronSpacing.lg),
                YronButton(
                  key: const ValueKey('start-workout'),
                  label: l10n.commonStartWorkout,
                  icon: Icons.play_arrow,
                  expand: true,
                  onPressed: () => widget.onStartWorkout(
                    firstDay == null
                        ? WorkoutSample.forSampleDay(0, l10n)
                        : WorkoutSample.fromDay(firstDay, l10n),
                  ),
                ),
                const SizedBox(height: YronSpacing.sm),
                YronButton(
                  key: const ValueKey('choose-workout-day'),
                  label: l10n.activeProgramChooseDayButton,
                  variant: YronButtonVariant.secondary,
                  expand: true,
                  onPressed: () => _openWeek(context),
                ),
                const SizedBox(height: YronSpacing.sm),
                YronButton(
                  label: l10n.activeProgramCreateNewProgramButton,
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
