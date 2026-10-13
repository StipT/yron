import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yron_ui/yron_ui.dart';

import '../../l10n/gen/app_localizations.dart';
import '../../l10n/l10n.dart';
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
  static const _sampleTitles = [
    WorkoutTitleId.chestTriceps,
    WorkoutTitleId.backBiceps,
    WorkoutTitleId.rest,
    WorkoutTitleId.legsAbsQuadFocus,
    WorkoutTitleId.fullBody,
    WorkoutTitleId.fullBody,
    WorkoutTitleId.rest,
  ];

  int _selectedDay = 4;

  bool _isRest(int index) =>
      widget.program?.days[index].isRest ?? (index == 2 || index == 6);

  String _title(int index, AppLocalizations l10n) =>
      widget.program?.days[index].displayTitle(l10n) ??
      switch (_sampleTitles[index]) {
        WorkoutTitleId.chestTriceps => l10n.workoutTitleChestTriceps,
        WorkoutTitleId.backBiceps => l10n.workoutTitleBackBiceps,
        WorkoutTitleId.rest => l10n.workoutTitleRestRecovery,
        WorkoutTitleId.legsAbsQuadFocus => l10n.workoutTitleLegsAbsQuadFocus,
        WorkoutTitleId.shoulders => l10n.workoutTitleShoulders,
        WorkoutTitleId.fullBody =>
          index == 4
              ? l10n.workoutTitleShouldersArmsHypertrophy
              : l10n.workoutTitleFullBody,
      };

  DateTime get _weekStart =>
      DateTime(2026, 8, 10).add(Duration(days: (widget.week - 4) * 7));

  String _dateLabel(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return '${DateFormat.MMM(locale).format(date).toUpperCase()} ${date.day}';
  }

  String _sampleStatus(AppLocalizations l10n, int index) => switch (index) {
    0 || 1 => l10n.weekDaysCompletedStatus,
    2 || 6 => l10n.weekDaysRecoveryStatus,
    3 => l10n.weekDaysSkippedStatus,
    4 => l10n.weekDaysTodayReadyStatus,
    _ => l10n.weekDaysUpcomingStatus,
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
    final l10n = context.l10n;
    final rest = _isRest(_selectedDay);
    final names = localizedWeekdayNames(l10n);
    final shortNames = localizedWeekdayShortNames(l10n);
    final start = _weekStart;
    final end = start.add(const Duration(days: 6));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.weekDaysTitle)),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: ListView(
              padding: const EdgeInsets.all(YronSpacing.md),
              children: [
                YronSectionHeader(
                  title: l10n.weekDaysTitle,
                  subtitle:
                      widget.program?.name ??
                      l10n.weekDaysSampleSubtitle(
                        widget.week,
                        _dateLabel(context, start),
                        _dateLabel(context, end),
                      ),
                ),
                const SizedBox(height: YronSpacing.sm),
                Text(
                  l10n.weekDaysDescription,
                  style: const TextStyle(color: YronColors.textMuted),
                ),
                const SizedBox(height: YronSpacing.md),
                if (widget.program == null)
                  YronCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.track_changes,
                              color: YronColors.primary,
                              size: 18,
                            ),
                            const SizedBox(width: YronSpacing.sm),
                            Expanded(child: Text(l10n.weekDaysProgressSummary)),
                            const Text(
                              '60%',
                              style: TextStyle(
                                color: YronColors.primary,
                                fontFamily: YronTypography.monoFamily,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: YronSpacing.sm),
                        YronProgressBar(
                          value: .6,
                          semanticLabel: l10n.weekDaysProgressSemanticLabel,
                          semanticValue: l10n.weekDaysProgressSemanticValue,
                        ),
                      ],
                    ),
                  ),
                if (widget.program == null)
                  const SizedBox(height: YronSpacing.md),
                YronDaySelector(
                  labels: [
                    for (final (index, name) in shortNames.indexed)
                      '$name ${start.add(Duration(days: index)).day}',
                  ],
                  selectedIndex: _selectedDay,
                  onSelected: (index) => setState(() => _selectedDay = index),
                ),
                const SizedBox(height: YronSpacing.lg),
                for (final (index, name) in names.indexed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: YronSpacing.sm),
                    child: YronWorkoutRow(
                      title: name,
                      summary: _title(index, l10n),
                      icon: _isRest(index)
                          ? Icons.self_improvement
                          : Icons.fitness_center,
                      metrics: widget.program == null && index < 2
                          ? Text(
                              index == 0
                                  ? l10n.weekDaysCompletedMetricsVolume
                                  : l10n.weekDaysCompletedMetricsLogged,
                              style: const TextStyle(
                                color: YronColors.textMuted,
                              ),
                            )
                          : null,
                      status: YronBadge(
                        label: widget.program == null
                            ? _sampleStatus(l10n, index)
                            : _isRest(index)
                            ? l10n.weekDaysRecoveryStatus
                            : l10n.weekDaysPlannedStatus,
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
                  title:
                      '${names[_selectedDay]} · ${_title(_selectedDay, l10n)}',
                  description: rest
                      ? l10n.weekDaysRestDescription
                      : l10n.weekDaysWorkoutDescription,
                ),
                const SizedBox(height: YronSpacing.md),
                if (!rest)
                  YronButton(
                    label: l10n.weekDaysStartSelectedWorkoutButton,
                    expand: true,
                    onPressed: () {
                      final program = widget.program;
                      widget.onStartWorkout(
                        program == null
                            ? WorkoutSample.forSampleDay(_selectedDay, l10n)
                            : WorkoutSample.fromDay(
                                program.days[_selectedDay],
                                l10n,
                              ),
                      );
                    },
                  )
                else
                  YronButton(
                    label: l10n.weekDaysBackToProgramButton,
                    variant: YronButtonVariant.secondary,
                    onPressed: () => Navigator.pop(context),
                  ),
                const SizedBox(height: YronSpacing.md),
                if (widget.program != null)
                  Text(
                    l10n.weekDaysProgramFooter,
                    style: const TextStyle(color: YronColors.textMuted),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
