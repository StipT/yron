import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

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
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('CREATE PROGRAM')),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: ListView(
              padding: const EdgeInsets.all(YronSpacing.md),
              children: [
                YronStepIndicator(
                  labels: const ['SETUP', 'WEEKLY SPLIT', 'BUILD'],
                  currentIndex: 1,
                ),
                const SizedBox(height: YronSpacing.lg),
                Text(
                  'PHASE 02 / STRUCTURE',
                  style: textTheme.labelSmall?.copyWith(
                    color: YronColors.primary,
                  ),
                ),
                const SizedBox(height: YronSpacing.sm),
                Text('2. WEEKLY SPLIT', style: textTheme.headlineMedium),
                const SizedBox(height: YronSpacing.sm),
                Text(
                  '${draft.name} · ${draft.focus} · ${draft.weeks} weeks',
                  style: textTheme.bodySmall,
                ),
                const SizedBox(height: YronSpacing.md),
                const Text(
                  'Choose workout and recovery days. Edit a workout to '
                  'build its exercise prescription.',
                ),
                const SizedBox(height: YronSpacing.lg),
                YronSectionLabel(
                  label: 'WEEKLY SCHEDULE',
                  trailing: '${draft.workoutCount} WORKOUT DAYS',
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
                            title: day.name.toUpperCase(),
                            subtitle: day.displayTitle,
                            action: IconButton(
                              key: ValueKey('edit-day-$index'),
                              tooltip: 'Edit ${day.name}',
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
                                label: 'WORKOUT',
                                selected: !day.isRest,
                                onPressed: () => setState(() {
                                  day.isRest = false;
                                  if (day.title == 'Rest') {
                                    day.title = 'Full Body';
                                  }
                                }),
                              ),
                              YronChoiceChip(
                                key: ValueKey('rest-day-$index'),
                                label: 'REST',
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
                const YronInfoCard(
                  icon: Icons.repeat,
                  title: 'YOUR REPEATING MICROCYCLE',
                  description:
                      'This seven-day schedule repeats for every '
                      'week of your program. Rest days preserve their '
                      'exercises if you switch them back to a workout.',
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
            label: 'CONTINUE: BUILD WORKOUTS',
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
