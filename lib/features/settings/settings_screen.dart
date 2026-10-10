import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.onLibrary,
    required this.onCreateProgram,
  });

  final VoidCallback onLibrary;
  final VoidCallback onCreateProgram;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SETTINGS')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(YronSpacing.md),
          children: [
            const YronInfoCard(
              icon: Icons.info_outline,
              title: 'IRON PROGRESS · SAMPLE MODE',
              description:
                  'Programs, exercise prescriptions and workout logs use '
                  'local sample data. No account or backend is connected.',
            ),
            const SizedBox(height: YronSpacing.lg),
            YronButton(
              label: 'EXERCISE LIBRARY',
              variant: YronButtonVariant.secondary,
              onPressed: onLibrary,
            ),
            const SizedBox(height: YronSpacing.md),
            YronButton(label: 'CREATE PROGRAM', onPressed: onCreateProgram),
            const SizedBox(height: YronSpacing.lg),
            const YronSectionHeader(
              title: 'DISPLAY & UNITS',
              subtitle:
                  'Dark theme · pounds (lbs) · Montserrat / JetBrains Mono',
            ),
          ],
        ),
      ),
    );
  }
}
