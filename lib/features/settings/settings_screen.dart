import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import '../../l10n/gen/app_localizations.dart';
import '../../l10n/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.onLibrary,
    required this.onCreateProgram,
    required this.selectedLocale,
    required this.onLocaleChanged,
  });

  final VoidCallback onLibrary;
  final VoidCallback onCreateProgram;
  final Locale selectedLocale;
  final ValueChanged<Locale> onLocaleChanged;

  String _localeLabel(AppLocalizations l10n, Locale locale) =>
      switch (locale.languageCode) {
        'de' => l10n.localeGerman,
        'hr' => l10n.localeCroatian,
        _ => l10n.localeEnglish,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final supportedLocales = AppLocalizations.supportedLocales;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(YronSpacing.md),
          children: [
            YronInfoCard(
              icon: Icons.info_outline,
              title: l10n.settingsInfoTitle,
              description: l10n.settingsInfoDescription,
            ),
            const SizedBox(height: YronSpacing.lg),
            YronButton(
              label: l10n.commonExerciseLibrary,
              variant: YronButtonVariant.secondary,
              onPressed: onLibrary,
            ),
            const SizedBox(height: YronSpacing.md),
            YronButton(
              label: l10n.commonCreateProgram,
              onPressed: onCreateProgram,
            ),
            if (supportedLocales.length > 1) ...[
              const SizedBox(height: YronSpacing.lg),
              YronSectionHeader(
                title: l10n.settingsLanguageTitle,
                subtitle: l10n.settingsLanguageSubtitle,
              ),
              const SizedBox(height: YronSpacing.md),
              Wrap(
                spacing: YronSpacing.sm,
                runSpacing: YronSpacing.sm,
                children: [
                  for (final locale in supportedLocales)
                    YronChoiceChip(
                      label: _localeLabel(l10n, locale),
                      selected:
                          locale.languageCode == selectedLocale.languageCode,
                      onPressed: () => onLocaleChanged(locale),
                    ),
                ],
              ),
            ],
            const SizedBox(height: YronSpacing.lg),
            YronSectionHeader(
              title: l10n.settingsDisplayTitle,
              subtitle: l10n.settingsDisplaySubtitle,
            ),
          ],
        ),
      ),
    );
  }
}
