import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

class ProgressDashboardScreen extends StatelessWidget {
  const ProgressDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PROGRESS'),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: YronColors.primary,
          fontStyle: FontStyle.italic,
        ),
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 860),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: YronStatCard(
                        label: 'Total Volume',
                        value: '124.5k',
                        unit: 'lbs',
                      ),
                    ),
                    SizedBox(width: YronSpacing.sm),
                    Expanded(
                      child: YronStatCard(
                        label: 'Workouts',
                        value: '18 / 20',
                        accent: YronColors.secondary,
                        footer: Text('This Month'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: YronSpacing.lg),
                const YronSectionHeader(title: 'STRENGTH GAINS'),
                const SizedBox(height: YronSpacing.md),
                for (final trend in [
                  (
                    name: 'BARBELL SQUAT',
                    gain: '+15 lbs',
                    values: [280.0, 282.5, 287.5, 290.0, 295.0],
                    color: YronColors.primary,
                  ),
                  (
                    name: 'BENCH PRESS',
                    gain: '+5 lbs',
                    values: [210.0, 210.0, 212.5, 212.5, 215.0],
                    color: YronColors.secondary,
                  ),
                ])
                  Padding(
                    padding: const EdgeInsets.only(bottom: YronSpacing.md),
                    child: YronCard(
                      child: Column(
                        children: [
                          YronSectionHeader(
                            title: trend.name,
                            action: YronBadge(
                              label: trend.gain,
                              color: trend.color,
                            ),
                          ),
                          const SizedBox(height: YronSpacing.md),
                          YronStrengthTrendChart(
                            height: 112,
                            color: trend.color,
                            semanticLabel: '${trend.name} over five weeks',
                            emptyLabel: 'No samples',
                            points: [
                              for (final (index, value) in trend.values.indexed)
                                YronStrengthPoint(
                                  label: 'W${index + 1}',
                                  value: value,
                                  semanticLabel:
                                      'Week ${index + 1}: $value lbs',
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: YronSpacing.sm),
                const YronSectionHeader(title: 'PERSONAL BESTS'),
                const SizedBox(height: YronSpacing.md),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth >= 700 ? 4 : 2;
                    final width =
                        (constraints.maxWidth -
                            YronSpacing.sm * (columns - 1)) /
                        columns;
                    return Wrap(
                      spacing: YronSpacing.sm,
                      runSpacing: YronSpacing.sm,
                      children: [
                        for (final (exercise, value) in [
                          ('DEADLIFT', '405'),
                          ('SQUAT', '315'),
                          ('BENCH', '225'),
                          ('OHP', '135'),
                        ])
                          SizedBox(
                            width: width,
                            child: YronPersonalBestCard(
                              label: '1 REP MAX',
                              exercise: exercise,
                              value: value,
                              unit: 'lbs',
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: YronSpacing.md),
                const Text(
                  'Sample progress data. Logged sessions stay local to this app session.',
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
