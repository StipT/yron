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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TRACKER'),
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
                const YronSectionHeader(
                  title: 'YOUR NEXT CHAPTER',
                  subtitle: 'Monday · A fresh start',
                ),
                const SizedBox(height: YronSpacing.lg),
                const YronInfoCard(
                  icon: Icons.self_improvement,
                  title: 'REST DAY',
                  description:
                      'No workout scheduled yet. Recovery builds strength; '
                      'a plan turns your next session into progress.',
                ),
                const SizedBox(height: YronSpacing.xl),
                YronEmptyState(
                  icon: Icons.fitness_center,
                  title: 'No active program',
                  description:
                      'Create your training split or explore the sample '
                      'program to start logging your first workout.',
                  action: YronButton(
                    key: const ValueKey('create-program'),
                    label: 'CREATE PROGRAM',
                    icon: Icons.add,
                    onPressed: onCreateProgram,
                  ),
                ),
                const SizedBox(height: YronSpacing.lg),
                YronButton(
                  key: const ValueKey('start-sample-program'),
                  label: 'START SAMPLE PROGRAM',
                  variant: YronButtonVariant.secondary,
                  expand: true,
                  onPressed: onStartSample,
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
