import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import '../program_creator/program_draft.dart';
import '../program_creator/weekly_split_screen.dart';

class CreateProgramSetupScreen extends StatefulWidget {
  const CreateProgramSetupScreen({super.key, this.onProgramSaved});

  /// Called once after saving the local draft, before returning to app root.
  final ValueChanged<ProgramDraft>? onProgramSaved;

  @override
  State<CreateProgramSetupScreen> createState() =>
      _CreateProgramSetupScreenState();
}

class _CreateProgramSetupScreenState extends State<CreateProgramSetupScreen> {
  static const _trainingFocuses = [
    'HYPERTROPHY',
    'STRENGTH',
    'POWERLIFTING',
    'BODYBUILDING',
  ];
  static const _cycleDurations = [8, 10, 12];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(
    text: 'HYPERTROPHY OVERLOAD 01',
  );
  final _philosophyController = TextEditingController();
  var _selectedFocus = _trainingFocuses.first;
  var _selectedCycleDuration = 10;

  void _continueToWeeklySplit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    FocusScope.of(context).unfocus();
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => WeeklySplitScreen(
          draft: ProgramDraft(
            name: _nameController.text.trim(),
            philosophy: _philosophyController.text.trim(),
            focus: _selectedFocus,
            weeks: _selectedCycleDuration,
          ),
          onProgramSaved: widget.onProgramSaved,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _philosophyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('CREATE PROGRAM'),
        actions: [
          IconButton(
            tooltip: 'Close',
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: YronSpacing.md),
              child: YronStepIndicator(
                labels: const ['SETUP', 'WEEKLY SPLIT', 'BUILD'],
                currentIndex: 0,
                semanticLabelBuilder: (index, state) =>
                    'Step ${index + 1} of 3: ${['Setup', 'Weekly split', 'Build'][index]}',
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(
                    YronSpacing.md,
                    YronSpacing.lg,
                    YronSpacing.md,
                    YronSpacing.xl,
                  ),
                  children: [
                    Text(
                      'PHASE 01  /  ARCHITECT',
                      style: textTheme.labelSmall?.copyWith(
                        color: YronColors.primary,
                      ),
                    ),
                    const SizedBox(height: YronSpacing.sm),
                    Text('1. PROGRAM SETUP', style: textTheme.headlineMedium),
                    const SizedBox(height: YronSpacing.xs),
                    Text(
                      'Name your routine and define the training cycle parameters.',
                      style: textTheme.bodySmall?.copyWith(
                        color: YronColors.textMuted,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: YronSpacing.lg),
                    YronSectionLabel(
                      label: 'PROGRAM NAME',
                      trailing: 'REQUIRED',
                      trailingColor: YronColors.primary,
                    ),
                    const SizedBox(height: YronSpacing.sm),
                    TextFormField(
                      key: const ValueKey('program-name'),
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Program name',
                        suffixIcon: Icon(
                          Icons.check_circle_outline,
                          color: YronColors.primary,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter a program name to continue.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: YronSpacing.md),
                    const YronSectionLabel(
                      label: 'PROGRAM PHILOSOPHY',
                      trailing: 'OPTIONAL',
                    ),
                    const SizedBox(height: YronSpacing.sm),
                    TextFormField(
                      key: const ValueKey('program-philosophy'),
                      controller: _philosophyController,
                      minLines: 2,
                      maxLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Program philosophy',
                        hintText:
                            'e.g. 5-day push/pull/legs focusing on progressive '
                            'overload and high mechanical tension...',
                      ),
                    ),
                    const SizedBox(height: YronSpacing.lg),
                    const YronSectionLabel(label: 'TRAINING FOCUS'),
                    const SizedBox(height: YronSpacing.sm),
                    Wrap(
                      spacing: YronSpacing.sm,
                      runSpacing: YronSpacing.sm,
                      children: [
                        for (final focus in _trainingFocuses)
                          YronChoiceChip(
                            key: ValueKey('focus-${focus.toLowerCase()}'),
                            label: focus,
                            selected: _selectedFocus == focus,
                            onPressed: () {
                              setState(() => _selectedFocus = focus);
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: YronSpacing.lg),
                    YronSectionLabel(
                      label: 'CYCLE DURATION',
                      trailing: 'RECOMMENDED: 10 WEEKS',
                      trailingColor: YronColors.primary,
                    ),
                    const SizedBox(height: YronSpacing.sm),
                    Row(
                      children: [
                        for (final (index, duration) in _cycleDurations.indexed)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: index == _cycleDurations.length - 1
                                    ? 0
                                    : YronSpacing.sm,
                              ),
                              child: YronChoiceChip(
                                key: ValueKey('duration-$duration'),
                                label: '$duration WEEKS',
                                selected: _selectedCycleDuration == duration,
                                onPressed: () {
                                  setState(
                                    () => _selectedCycleDuration = duration,
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: YronSpacing.lg),
                    const YronInfoCard(
                      icon: Icons.sync,
                      title: 'CYCLE SYNCHRONIZATION',
                      description:
                          'This weekly split will repeat across all weeks in '
                          'the cycle. Microcycle progressive overload and '
                          'delta weights can be recalibrated per block.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            YronSpacing.md,
            YronSpacing.sm,
            YronSpacing.md,
            YronSpacing.md,
          ),
          child: YronButton(
            key: const ValueKey('setup-next'),
            expand: true,
            label: 'NEXT: CONFIGURE WEEKLY SPLIT',
            icon: Icons.arrow_forward,
            onPressed: _continueToWeeklySplit,
          ),
        ),
      ),
    );
  }
}
