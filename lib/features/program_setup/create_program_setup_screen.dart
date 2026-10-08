import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

class CreateProgramSetupScreen extends StatefulWidget {
  const CreateProgramSetupScreen({super.key});

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
  var _selectedFocus = _trainingFocuses.first;
  var _selectedCycleDuration = 10;

  void _continueToWeeklySplit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Weekly split configuration is the next step.'),
        ),
      );
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
            const _StepProgress(),
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
                      initialValue: 'HYPERTROPHY OVERLOAD 01',
                      textCapitalization: TextCapitalization.words,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: const InputDecoration(
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
                      minLines: 2,
                      maxLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
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
          child: YronPrimaryButton(
            label: 'NEXT: CONFIGURE WEEKLY SPLIT',
            icon: Icons.arrow_forward,
            onPressed: _continueToWeeklySplit,
          ),
        ),
      ),
    );
  }
}

class _StepProgress extends StatelessWidget {
  const _StepProgress();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: YronSpacing.md),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'STEP 1 OF 3',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: YronColors.primary),
              ),
            ],
          ),
          const SizedBox(height: YronSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: const LinearProgressIndicator(
              value: 1 / 3,
              minHeight: 3,
              backgroundColor: YronColors.outline,
              color: YronColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
