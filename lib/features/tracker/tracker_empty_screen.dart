import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

class TrackerEmptyScreen extends StatelessWidget {
  const TrackerEmptyScreen({
    super.key,
    required this.onCreateProgram,
    required this.onStartSample,
    required this.onLibrary,
  });

  final VoidCallback onCreateProgram;
  final VoidCallback onStartSample;
  final VoidCallback onLibrary;

  static const _templates = [
    _ProgramTemplate(
      name: 'Push Pull Legs',
      category: 'Hypertrophy',
      description: '5-Day High Intensity Frequency',
      color: YronColors.primary,
      days: ['Push', 'Pull', 'Legs', 'Rest', 'Upper', 'Rest', 'Rest'],
    ),
    _ProgramTemplate(
      name: 'Upper Lower',
      category: 'Strength',
      description: '4-Day Pure Power Foundation',
      color: YronColors.secondary,
      days: ['Upper', 'Lower', 'Rest', 'Upper', 'Lower', 'Rest', 'Rest'],
    ),
    _ProgramTemplate(
      name: 'Arnold Split',
      category: 'Volume',
      description: '6-Day Antagonist Muscle Blast',
      color: YronColors.textMuted,
      days: [
        'Chest & Back',
        'Shoulders & Arms',
        'Legs',
        'Chest & Back',
        'Arms',
        'Legs',
        'Rest',
      ],
    ),
  ];

  void _previewTemplate(BuildContext context, _ProgramTemplate template) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: 640),
      builder: (sheetContext) => YronSheet(
        title: template.name,
        subtitle: '${template.category} · ${template.description}',
        actions: [
          YronButton(
            label: 'CANCEL',
            variant: YronButtonVariant.quiet,
            onPressed: () => Navigator.pop(sheetContext),
          ),
          YronButton(
            label: 'START SAMPLE PROGRAM',
            icon: Icons.play_arrow,
            onPressed: () {
              Navigator.pop(sheetContext);
              onStartSample();
            },
          ),
        ],
        child: Column(
          children: [
            for (final (index, day) in template.days.indexed)
              Padding(
                padding: const EdgeInsets.only(bottom: YronSpacing.sm),
                child: YronWorkoutRow(
                  title: 'DAY ${index + 1}',
                  summary: day,
                  icon: day == 'Rest'
                      ? Icons.self_improvement
                      : Icons.fitness_center,
                  status: day == 'Rest'
                      ? const YronBadge(
                          label: 'RECOVERY',
                          color: YronColors.secondary,
                        )
                      : null,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.fitness_center, color: YronColors.primary),
            SizedBox(width: YronSpacing.sm),
            Text('IRON PULSE'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Exercise library',
            onPressed: onLibrary,
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
                const SizedBox(height: YronSpacing.md),
                Center(
                  child: Column(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: YronRadii.card,
                          boxShadow: [
                            BoxShadow(
                              color: YronColors.primary.withValues(alpha: .12),
                              blurRadius: 28,
                            ),
                          ],
                        ),
                        child: const YronIconTile(
                          icon: Icons.fitness_center,
                          size: 112,
                        ),
                      ),
                      const SizedBox(height: YronSpacing.md),
                      const YronBadge(label: 'SYS READY', icon: Icons.circle),
                    ],
                  ),
                ),
                const SizedBox(height: YronSpacing.lg),
                Text(
                  'NO ACTIVE PROGRAM',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: YronColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: YronSpacing.sm),
                const Text(
                  'You need an active routine to log workouts, track '
                  'progressive overload, and build muscle. Choose a template '
                  'or build your custom split from scratch.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: YronColors.textMuted, height: 1.5),
                ),
                const SizedBox(height: YronSpacing.lg),
                YronButton(
                  key: const ValueKey('create-program'),
                  label: 'CREATE WORKOUT PROGRAM',
                  icon: Icons.arrow_forward,
                  expand: true,
                  onPressed: onCreateProgram,
                ),
                const SizedBox(height: YronSpacing.xl),
                const YronSectionHeader(
                  title: 'OR START FROM A PRESET',
                  subtitle: '3 PROTOCOLS',
                ),
                const SizedBox(height: YronSpacing.md),
                for (final template in _templates)
                  Padding(
                    padding: const EdgeInsets.only(bottom: YronSpacing.sm),
                    child: YronCard(
                      padding: EdgeInsets.zero,
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              width: 4,
                              child: ColoredBox(color: template.color),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(YronSpacing.md),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                            spacing: YronSpacing.sm,
                                            runSpacing: YronSpacing.xs,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              Text(
                                                template.name,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.titleMedium,
                                              ),
                                              YronBadge(
                                                label: template.category,
                                                color: template.color,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: YronSpacing.xs,
                                          ),
                                          Text(
                                            template.description,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: YronColors.textMuted,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: YronSpacing.sm),
                                    YronButton(
                                      key: ValueKey(
                                        'template-preview-${template.name}',
                                      ),
                                      label: 'PREVIEW',
                                      variant: YronButtonVariant.secondary,
                                      onPressed: () =>
                                          _previewTemplate(context, template),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: YronSpacing.lg),
                const YronCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      YronSectionHeader(
                        title: 'HOW YRON WORKS',
                        subtitle: 'Build a repeatable training system.',
                      ),
                      SizedBox(height: YronSpacing.md),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: YronOnboardingStep(
                              number: '01',
                              label: 'Set weekly muscle split',
                            ),
                          ),
                          SizedBox(width: YronSpacing.sm),
                          Expanded(
                            child: YronOnboardingStep(
                              number: '02',
                              label: 'Add sets & target reps',
                            ),
                          ),
                          SizedBox(width: YronSpacing.sm),
                          Expanded(
                            child: YronOnboardingStep(
                              number: '03',
                              label: 'Log weights & overload',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: YronSpacing.md),
                const Text(
                  'Sample mode · programs and logs are local to this session.',
                  textAlign: TextAlign.center,
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

class _ProgramTemplate {
  const _ProgramTemplate({
    required this.name,
    required this.category,
    required this.description,
    required this.color,
    required this.days,
  });

  final String name;
  final String category;
  final String description;
  final Color color;
  final List<String> days;
}
