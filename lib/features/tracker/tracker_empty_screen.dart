import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import '../../l10n/l10n.dart';

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

  List<_ProgramTemplate> _buildTemplates(BuildContext context) {
    final l10n = context.l10n;
    return [
      _ProgramTemplate(
        name: l10n.templatePushPullLegsName,
        category: l10n.templateCategoryHypertrophy,
        description: l10n.templatePushPullLegsDescription,
        color: YronColors.primary,
        days: [
          _TemplateDay(label: l10n.templateDayPush),
          _TemplateDay(label: l10n.templateDayPull),
          _TemplateDay(label: l10n.templateDayLegs),
          _TemplateDay(label: l10n.commonRest, isRest: true),
          _TemplateDay(label: l10n.templateDayUpper),
          _TemplateDay(label: l10n.commonRest, isRest: true),
          _TemplateDay(label: l10n.commonRest, isRest: true),
        ],
      ),
      _ProgramTemplate(
        name: l10n.templateUpperLowerName,
        category: l10n.templateCategoryStrength,
        description: l10n.templateUpperLowerDescription,
        color: YronColors.secondary,
        days: [
          _TemplateDay(label: l10n.templateDayUpper),
          _TemplateDay(label: l10n.templateDayLower),
          _TemplateDay(label: l10n.commonRest, isRest: true),
          _TemplateDay(label: l10n.templateDayUpper),
          _TemplateDay(label: l10n.templateDayLower),
          _TemplateDay(label: l10n.commonRest, isRest: true),
          _TemplateDay(label: l10n.commonRest, isRest: true),
        ],
      ),
      _ProgramTemplate(
        name: l10n.templateArnoldSplitName,
        category: l10n.templateCategoryVolume,
        description: l10n.templateArnoldSplitDescription,
        color: YronColors.textMuted,
        days: [
          _TemplateDay(label: l10n.templateDayChestBack),
          _TemplateDay(label: l10n.templateDayShouldersArms),
          _TemplateDay(label: l10n.templateDayLegs),
          _TemplateDay(label: l10n.templateDayChestBack),
          _TemplateDay(label: l10n.templateDayArms),
          _TemplateDay(label: l10n.templateDayLegs),
          _TemplateDay(label: l10n.commonRest, isRest: true),
        ],
      ),
    ];
  }

  void _previewTemplate(BuildContext context, _ProgramTemplate template) {
    final l10n = context.l10n;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: 640),
      builder: (sheetContext) => YronSheet(
        title: template.name,
        subtitle: '${template.category} · ${template.description}',
        actions: [
          YronButton(
            label: l10n.commonCancel,
            variant: YronButtonVariant.quiet,
            onPressed: () => Navigator.pop(sheetContext),
          ),
          YronButton(
            label: l10n.trackerEmptyStartSampleProgramButton,
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
                  title: l10n.trackerEmptyTemplateDayLabel(index + 1),
                  summary: day.label,
                  icon: day.isRest
                      ? Icons.self_improvement
                      : Icons.fitness_center,
                  status: day.isRest
                      ? YronBadge(
                          label: l10n.weekDaysRecoveryStatus,
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
    final l10n = context.l10n;
    final templates = _buildTemplates(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.fitness_center, color: YronColors.primary),
            const SizedBox(width: YronSpacing.sm),
            Text(l10n.trackerEmptyAppBarTitle),
          ],
        ),
        actions: [
          IconButton(
            tooltip: l10n.commonExerciseLibraryTooltip,
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
                      YronBadge(
                        label: l10n.trackerEmptySystemReadyBadge,
                        icon: Icons.circle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: YronSpacing.lg),
                Text(
                  l10n.trackerEmptyNoProgramTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: YronColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: YronSpacing.sm),
                Text(
                  l10n.trackerEmptyNoProgramDescription,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: YronColors.textMuted,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: YronSpacing.lg),
                YronButton(
                  key: const ValueKey('create-program'),
                  label: l10n.trackerEmptyCreateProgramButton,
                  icon: Icons.arrow_forward,
                  expand: true,
                  onPressed: onCreateProgram,
                ),
                const SizedBox(height: YronSpacing.xl),
                YronSectionHeader(
                  title: l10n.trackerEmptyPresetTitle,
                  subtitle: l10n.trackerEmptyPresetSubtitle,
                ),
                const SizedBox(height: YronSpacing.md),
                for (final template in templates)
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
                                      label: l10n.trackerEmptyPreviewButton,
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
                YronCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      YronSectionHeader(
                        title: l10n.trackerEmptyHowItWorksTitle,
                        subtitle: l10n.trackerEmptyHowItWorksSubtitle,
                      ),
                      const SizedBox(height: YronSpacing.md),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: YronOnboardingStep(
                              number: '01',
                              label: l10n.trackerEmptyStepOne,
                            ),
                          ),
                          const SizedBox(width: YronSpacing.sm),
                          Expanded(
                            child: YronOnboardingStep(
                              number: '02',
                              label: l10n.trackerEmptyStepTwo,
                            ),
                          ),
                          const SizedBox(width: YronSpacing.sm),
                          Expanded(
                            child: YronOnboardingStep(
                              number: '03',
                              label: l10n.trackerEmptyStepThree,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: YronSpacing.md),
                Text(
                  l10n.trackerEmptyFooter,
                  textAlign: TextAlign.center,
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
  final List<_TemplateDay> days;
}

class _TemplateDay {
  const _TemplateDay({required this.label, this.isRest = false});

  final String label;
  final bool isRest;
}
