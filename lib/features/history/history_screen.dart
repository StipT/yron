import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import '../tracker/workout_sample.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, required this.sessions});

  final List<WorkoutSessionSummary> sessions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HISTORY')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(YronSpacing.md),
          children: [
            const YronSectionHeader(
              title: 'WORKOUT HISTORY',
              subtitle: 'Local sessions · resets when the app restarts',
            ),
            const SizedBox(height: YronSpacing.md),
            if (sessions.isEmpty)
              const YronEmptyState(
                icon: Icons.history,
                title: 'No sessions logged',
                description: 'Finish a workout in Tracker to see it here.',
              ),
            for (final session in sessions.reversed)
              Padding(
                padding: const EdgeInsets.only(bottom: YronSpacing.md),
                child: YronWorkoutRow(
                  title: session.title,
                  summary:
                      '${session.completedSets} '
                      '${session.completedSets == 1 ? 'set' : 'sets'} · '
                      '${session.volume.toStringAsFixed(0)} lbs',
                  status: const YronBadge(label: 'COMPLETE'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
