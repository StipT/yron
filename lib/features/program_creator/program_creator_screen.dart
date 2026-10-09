import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import 'day_builder_screen.dart';
import 'program_draft.dart';

/// Overview of the in-memory draft. Save has no backend side effects.
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
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('PROGRAM CREATOR')),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: ListView(
              padding: const EdgeInsets.all(YronSpacing.md),
              children: [
                Text(
                  'READY TO TRAIN',
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
                    YronBadge(label: draft.focus),
                    YronBadge(label: '${draft.weeks} WEEKS'),
                    YronBadge(label: '${draft.workoutCount} DAYS / WEEK'),
                    YronBadge(label: '${draft.totalSets} SETS / WEEK'),
                  ],
                ),
                if (draft.philosophy.isNotEmpty) ...[
                  const SizedBox(height: YronSpacing.lg),
                  const YronSectionLabel(label: 'PROGRAM PHILOSOPHY'),
                  const SizedBox(height: YronSpacing.sm),
                  Text(draft.philosophy, style: textTheme.bodyMedium),
                ],
                const SizedBox(height: YronSpacing.lg),
                const YronSectionHeader(
                  title: 'WEEKLY SCHEDULE',
                  subtitle:
                      'Expand a day to review its exercise prescriptions.',
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
                        title: Text(day.name.toUpperCase()),
                        subtitle: Text(day.displayTitle),
                        childrenPadding: const EdgeInsets.all(YronSpacing.md),
                        children: [
                          if (day.isRest)
                            const Text(
                              'Recovery day. Rest, recharge and prepare '
                              'for your next workout.',
                            )
                          else if (day.exercises.isEmpty)
                            const Text('No exercises yet. Edit this workout.')
                          else
                            for (final item in day.exercises)
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: YronSpacing.sm,
                                ),
                                child: YronExerciseRow(
                                  name: item.exercise.name,
                                  summary: item.prescription,
                                ),
                              ),
                          YronButton(
                            key: ValueKey('overview-edit-day-$index'),
                            label: 'EDIT ${day.name.toUpperCase()}',
                            icon: Icons.edit_outlined,
                            variant: YronButtonVariant.secondary,
                            onPressed: () => _editDay(index),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: YronSpacing.md),
                const YronInfoCard(
                  icon: Icons.check_circle_outline,
                  title: 'YOUR PROGRAM IS READY',
                  description:
                      'Save to finish this sample program and '
                      'return to your dashboard. This draft is held locally '
                      'for this session only.',
                ),
                if (!draft.isComplete) ...[
                  const SizedBox(height: YronSpacing.md),
                  Text(
                    'Add an exercise to every workout day before saving.',
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
            label: 'SAVE PROGRAM',
            icon: Icons.check,
            onPressed: _saved || !draft.isComplete ? null : _save,
          ),
        ),
      ),
    );
  }
}
