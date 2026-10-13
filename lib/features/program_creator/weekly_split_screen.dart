import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import '../../l10n/l10n.dart';
import 'day_builder_screen.dart';
import 'program_draft.dart';

class WeeklySplitScreen extends StatefulWidget {
  const WeeklySplitScreen({
    super.key,
    required this.draft,
    this.onProgramSaved,
  });

  final ProgramDraft draft;
  final ValueChanged<ProgramDraft>? onProgramSaved;

  @override
  State<WeeklySplitScreen> createState() => _WeeklySplitScreenState();
}

class _WeeklySplitScreenState extends State<WeeklySplitScreen> {
  Future<void> _openBuilder(int index, {bool returnToSplit = false}) async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => DayBuilderScreen(
          draft: widget.draft,
          initialDayIndex: index,
          returnToSplit: returnToSplit,
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
      appBar: AppBar(title: Text(l10n.createProgramTitle)),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: ListView(
              padding: const EdgeInsets.all(YronSpacing.md),
              children: [
                YronStepIndicator(
                  labels: localizedStepLabels(l10n),
                  currentIndex: 1,
                ),
                const SizedBox(height: YronSpacing.lg),
                Text(
                  l10n.weeklySplitPhaseLabel,
                  style: textTheme.labelSmall?.copyWith(
                    color: YronColors.primary,
                  ),
                ),
                const SizedBox(height: YronSpacing.sm),
                Text(
                  l10n.weeklySplitScreenTitle,
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(height: YronSpacing.sm),
                Text(
                  l10n.weeklySplitSummary(
                    draft.name,
                    programFocusLabel(l10n, draft.focus),
                    draft.weeks,
                  ),
                  style: textTheme.bodySmall,
                ),
                const SizedBox(height: YronSpacing.md),
                Text(l10n.weeklySplitDescription),
                const SizedBox(height: YronSpacing.lg),
                YronSectionLabel(
                  label: l10n.weeklySplitScheduleLabel,
                  trailing: l10n.weeklySplitWorkoutDaysBadge(
                    draft.workoutCount,
                  ),
                ),
                const SizedBox(height: YronSpacing.md),
                for (final (index, day) in draft.days.indexed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: YronSpacing.sm),
                    child: YronCard(
                      key: ValueKey('split-day-$index'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          YronSectionHeader(
                            title: day.name(l10n).toUpperCase(),
                            subtitle: day.displayTitle(l10n),
                            action: IconButton(
                              key: ValueKey('edit-day-$index'),
                              tooltip: l10n.weeklySplitEditDayTooltip(
                                day.name(l10n),
                              ),
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () =>
                                  _openBuilder(index, returnToSplit: true),
                            ),
                          ),
                          const SizedBox(height: YronSpacing.sm),
                          Wrap(
                            spacing: YronSpacing.sm,
                            runSpacing: YronSpacing.sm,
                            children: [
                              YronChoiceChip(
                                key: ValueKey('workout-day-$index'),
                                label: l10n.commonWorkout,
                                selected: !day.isRest,
                                onPressed: () =>
                                    setState(day.activateWorkoutDefault),
                              ),
                              YronChoiceChip(
                                key: ValueKey('rest-day-$index'),
                                label: l10n.commonRest,
                                selected: day.isRest,
                                onPressed: () =>
                                    setState(() => day.isRest = true),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: YronSpacing.md),
                YronInfoCard(
                  icon: Icons.repeat,
                  title: l10n.weeklySplitInfoTitle,
                  description: l10n.weeklySplitInfoDescription,
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
            key: const ValueKey('split-next'),
            expand: true,
            label: l10n.weeklySplitNextButton,
            icon: Icons.arrow_forward,
            onPressed: draft.workoutCount == 0
                ? null
                : () =>
                      _openBuilder(draft.days.indexWhere((day) => !day.isRest)),
          ),
        ),
      ),
    );
  }
}
