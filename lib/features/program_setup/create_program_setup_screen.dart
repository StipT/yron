import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import '../../l10n/l10n.dart';
import '../exercise_library/exercise_catalog.dart';
import '../program_creator/program_draft.dart';
import '../program_creator/weekly_split_screen.dart';

class CreateProgramSetupScreen extends StatefulWidget {
  const CreateProgramSetupScreen({super.key, this.onProgramSaved});

  final ValueChanged<ProgramDraft>? onProgramSaved;

  @override
  State<CreateProgramSetupScreen> createState() =>
      _CreateProgramSetupScreenState();
}

class _CreateProgramSetupScreenState extends State<CreateProgramSetupScreen> {
  static const _cycleDurations = [8, 10, 12];

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _philosophyController;
  var _didInitControllers = false;
  var _selectedFocus = ProgramFocus.hypertrophy;
  var _selectedCycleDuration = 10;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didInitControllers) return;
    _nameController = TextEditingController(
      text: context.l10n.setupDefaultProgramName,
    );
    _philosophyController = TextEditingController();
    _didInitControllers = true;
  }

  void _continueToWeeklySplit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final l10n = context.l10n;
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
            catalog: buildExerciseCatalog(l10n),
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
    final l10n = context.l10n;
    final stepLabels = localizedStepLabels(l10n);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.commonBack,
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(l10n.createProgramTitle),
        actions: [
          IconButton(
            tooltip: l10n.commonClose,
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
                labels: stepLabels,
                currentIndex: 0,
                semanticLabelBuilder: (index, state) =>
                    l10n.stepIndicatorSemanticLabel(
                      index + 1,
                      stepLabels.length,
                      stepLabels[index],
                    ),
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
                      l10n.setupPhaseLabel,
                      style: textTheme.labelSmall?.copyWith(
                        color: YronColors.primary,
                      ),
                    ),
                    const SizedBox(height: YronSpacing.sm),
                    Text(
                      l10n.setupScreenTitle,
                      style: textTheme.headlineMedium,
                    ),
                    const SizedBox(height: YronSpacing.xs),
                    Text(
                      l10n.setupScreenDescription,
                      style: textTheme.bodySmall?.copyWith(
                        color: YronColors.textMuted,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: YronSpacing.lg),
                    YronSectionLabel(
                      label: l10n.setupProgramNameSection,
                      trailing: l10n.commonRequired,
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
                      decoration: InputDecoration(
                        labelText: l10n.setupProgramNameFieldLabel,
                        suffixIcon: const Icon(
                          Icons.check_circle_outline,
                          color: YronColors.primary,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.setupProgramNameRequiredError;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: YronSpacing.md),
                    YronSectionLabel(
                      label: l10n.setupProgramPhilosophySection,
                      trailing: l10n.commonOptional,
                    ),
                    const SizedBox(height: YronSpacing.sm),
                    TextFormField(
                      key: const ValueKey('program-philosophy'),
                      controller: _philosophyController,
                      minLines: 2,
                      maxLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        labelText: l10n.setupProgramPhilosophyFieldLabel,
                        hintText: l10n.setupProgramPhilosophyHint,
                      ),
                    ),
                    const SizedBox(height: YronSpacing.lg),
                    YronSectionLabel(label: l10n.setupTrainingFocusSection),
                    const SizedBox(height: YronSpacing.sm),
                    Wrap(
                      spacing: YronSpacing.sm,
                      runSpacing: YronSpacing.sm,
                      children: [
                        for (final focus in ProgramFocus.values)
                          YronChoiceChip(
                            key: ValueKey('focus-${focus.name}'),
                            label: programFocusLabel(l10n, focus),
                            selected: _selectedFocus == focus,
                            onPressed: () =>
                                setState(() => _selectedFocus = focus),
                          ),
                      ],
                    ),
                    const SizedBox(height: YronSpacing.lg),
                    YronSectionLabel(
                      label: l10n.setupCycleDurationSection,
                      trailing: l10n.setupCycleDurationRecommended,
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
                                label: l10n.setupCycleDurationOption(duration),
                                selected: _selectedCycleDuration == duration,
                                onPressed: () => setState(
                                  () => _selectedCycleDuration = duration,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: YronSpacing.lg),
                    YronInfoCard(
                      icon: Icons.sync,
                      title: l10n.setupInfoTitle,
                      description: l10n.setupInfoDescription,
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
            label: l10n.setupNextButton,
            icon: Icons.arrow_forward,
            onPressed: _continueToWeeklySplit,
          ),
        ),
      ),
    );
  }
}
