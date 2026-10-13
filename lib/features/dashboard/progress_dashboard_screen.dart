import 'package:flutter/material.dart';
import 'package:yron_ui/yron_ui.dart';

import '../../l10n/l10n.dart';

class ProgressDashboardScreen extends StatelessWidget {
  const ProgressDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final trends = [
      (
        name: l10n.dashboardTrendBarbellSquatName,
        gain: l10n.dashboardTrendBarbellSquatGain,
        values: [280.0, 282.5, 287.5, 290.0, 295.0],
        color: YronColors.primary,
      ),
      (
        name: l10n.dashboardTrendBenchPressName,
        gain: l10n.dashboardTrendBenchPressGain,
        values: [210.0, 210.0, 212.5, 212.5, 215.0],
        color: YronColors.secondary,
      ),
    ];
    final personalBests = [
      (l10n.dashboardPersonalBestDeadlift, '405'),
      (l10n.dashboardPersonalBestSquat, '315'),
      (l10n.dashboardPersonalBestBench, '225'),
      (l10n.dashboardPersonalBestOhp, '135'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboardTitle),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: YronStatCard(
                        label: l10n.dashboardTotalVolumeLabel,
                        value: '124.5k',
                        unit: l10n.commonUnitLbs,
                      ),
                    ),
                    const SizedBox(width: YronSpacing.sm),
                    Expanded(
                      child: YronStatCard(
                        label: l10n.dashboardWorkoutsLabel,
                        value: '18 / 20',
                        accent: YronColors.secondary,
                        footer: Text(l10n.dashboardThisMonthLabel),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: YronSpacing.lg),
                YronSectionHeader(title: l10n.dashboardStrengthGainsTitle),
                const SizedBox(height: YronSpacing.md),
                for (final trend in trends)
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
                            semanticLabel: l10n
                                .dashboardTrendChartSemanticLabel(trend.name),
                            emptyLabel: l10n.dashboardTrendChartEmptyLabel,
                            points: [
                              for (final (index, value) in trend.values.indexed)
                                YronStrengthPoint(
                                  label:
                                      '${l10n.commonWeekAbbreviation}${index + 1}',
                                  value: value,
                                  semanticLabel: l10n
                                      .dashboardTrendPointSemanticLabel(
                                        index + 1,
                                        value.toStringAsFixed(
                                          value == value.truncateToDouble()
                                              ? 0
                                              : 1,
                                        ),
                                      ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: YronSpacing.sm),
                YronSectionHeader(title: l10n.dashboardPersonalBestsTitle),
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
                        for (final (exercise, value) in personalBests)
                          SizedBox(
                            width: width,
                            child: YronPersonalBestCard(
                              label: l10n.dashboardPersonalBestLabel,
                              exercise: exercise,
                              value: value,
                              unit: l10n.commonUnitLbs,
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: YronSpacing.md),
                Text(
                  l10n.dashboardSampleDisclaimer,
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
