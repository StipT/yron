import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import '../../l10n/l10n.dart';
import '../tracker/workout_sample.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, required this.sessions});

  final List<WorkoutSessionSummary> sessions;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.historyTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(YronSpacing.md),
          children: [
            YronSectionHeader(
              title: l10n.historySectionTitle,
              subtitle: l10n.historySectionSubtitle,
            ),
            const SizedBox(height: YronSpacing.md),
            if (sessions.isEmpty)
              YronEmptyState(
                icon: Icons.history,
                title: l10n.historyEmptyTitle,
                description: l10n.historyEmptyDescription,
              ),
            for (final session in sessions.reversed)
              Padding(
                padding: const EdgeInsets.only(bottom: YronSpacing.md),
                child: YronWorkoutRow(
                  title: session.title,
                  summary: l10n
                      .historySessionSummary(
                        session.completedSets,
                        session.volume.toStringAsFixed(0),
                      )
                      .replaceCountMarker(session.completedSets),
                  status: YronBadge(label: l10n.historyCompleteBadge),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
