import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import '../../l10n/l10n.dart';
import 'day_builder_screen.dart';
import 'program_draft.dart';

class ProgramCreatorScreen extends StatefulWidget {
  const ProgramCreatorScreen({
    super.key,
    required this.draft,
    this.onProgramSaved,
  });

  final ProgramDraft draft;
  final ValueChanged<ProgramDraft>? onProgramSaved;

  @override
  State<ProgramCreatorScreen> createState() => _ProgramCreatorScreenState();
}

class _ProgramCreatorScreenState extends State<ProgramCreatorScreen> {
  var _saved = false;

  void _save() {
    if (_saved || !widget.draft.isComplete) return;
    setState(() => _saved = true);
    widget.onProgramSaved?.call(widget.draft);
    if (!mounted) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<void> _editDay(int index) async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => DayBuilderScreen(
          draft: widget.draft,
          initialDayIndex: index,
          returnToSplit: true,
          onProgramSaved: widget.onProgramSaved,
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final draft = widget.draft;
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.programCreatorTitle)),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: ListView(
              padding: const EdgeInsets.all(YronSpacing.md),
              children: [
                Text(
                  l10n.programCreatorReadyLabel,
                  style: textTheme.labelSmall?.copyWith(
                    color: YronColors.primary,
                  ),
                ),
                const SizedBox(height: YronSpacing.sm),
                Text(draft.name, style: textTheme.headlineMedium),
                const SizedBox(height: YronSpacing.md),
                Wrap(
                  spacing: YronSpacing.sm,
                  runSpacing: YronSpacing.sm,
                  children: [
                    YronBadge(label: programFocusLabel(l10n, draft.focus)),
                    YronBadge(
                      label: l10n.programCreatorWeeksBadge(draft.weeks),
                    ),
                    YronBadge(
                      label: l10n.programCreatorDaysPerWeekBadge(
                        draft.workoutCount,
                      ),
                    ),
                    YronBadge(
                      label: l10n.programCreatorSetsPerWeekBadge(
                        draft.totalSets,
                      ),
                    ),
                  ],
                ),
                if (draft.philosophy.isNotEmpty) ...[
                  const SizedBox(height: YronSpacing.lg),
                  YronSectionLabel(label: l10n.setupProgramPhilosophySection),
                  const SizedBox(height: YronSpacing.sm),
                  Text(draft.philosophy, style: textTheme.bodyMedium),
                ],
                const SizedBox(height: YronSpacing.lg),
                YronSectionHeader(
                  title: l10n.programCreatorScheduleTitle,
                  subtitle: l10n.programCreatorScheduleSubtitle,
                ),
                const SizedBox(height: YronSpacing.md),
                for (final (index, day) in draft.days.indexed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: YronSpacing.sm),
                    child: YronCard(
                      padding: EdgeInsets.zero,
                      child: ExpansionTile(
                        key: ValueKey('overview-day-$index'),
                        initiallyExpanded: index == 0,
                        title: Text(day.name(l10n).toUpperCase()),
                        subtitle: Text(day.displayTitle(l10n)),
                        childrenPadding: const EdgeInsets.all(YronSpacing.md),
                        children: [
                          if (day.isRest)
                            Text(l10n.programCreatorRecoveryDayDescription)
                          else if (day.exercises.isEmpty)
                            Text(l10n.programCreatorNoExercisesYet)
                          else
                            for (final item in day.exercises)
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: YronSpacing.sm,
                                ),
                                child: YronExerciseRow(
                                  name: item.exercise.name,
                                  summary: item.prescription(l10n),
                                ),
                              ),
                          YronButton(
                            key: ValueKey('overview-edit-day-$index'),
                            label: l10n.programCreatorEditDayButton(
                              day.name(l10n).toUpperCase(),
                            ),
                            icon: Icons.edit_outlined,
                            variant: YronButtonVariant.secondary,
                            onPressed: () => _editDay(index),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: YronSpacing.md),
                YronInfoCard(
                  icon: Icons.check_circle_outline,
                  title: l10n.programCreatorInfoTitle,
                  description: l10n.programCreatorInfoDescription,
                ),
                if (!draft.isComplete) ...[
                  const SizedBox(height: YronSpacing.md),
                  Text(
                    l10n.programCreatorIncompleteWarning,
                    style: textTheme.bodyMedium?.copyWith(
                      color: YronColors.tertiary,
                    ),
                  ),
                ],
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
            key: const ValueKey('save-program'),
            expand: true,
            label: l10n.programCreatorSaveButton,
            icon: Icons.check,
            onPressed: _saved || !draft.isComplete ? null : _save,
          ),
        ),
      ),
    );
  }
}
