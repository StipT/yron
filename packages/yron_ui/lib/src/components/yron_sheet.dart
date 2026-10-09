import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';
import 'yron_section_header.dart';

/// Visual bottom-sheet content, to be hosted by the caller's modal route.
///
/// Scrolls when constrained, respects safe areas and keyboard insets. [child]
/// should be shrink-wrapping content, not an Expanded or unbounded list.
class YronSheet extends StatelessWidget {
  const YronSheet({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.headerAction,
    this.actions = const [],
    this.showHandle = true,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? headerAction;
  final List<Widget> actions;
  final bool showHandle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Material(
        color: YronColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: YronRadii.card.topLeft),
          side: const BorderSide(color: YronColors.outline),
        ),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(YronSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (showHandle) ...[
                  Center(
                    child: ExcludeSemantics(
                      child: Container(
                        width: 32,
                        height: YronSpacing.xs,
                        decoration: const BoxDecoration(
                          color: YronColors.textMuted,
                          borderRadius: YronRadii.small,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: YronSpacing.lg),
                ],
                YronSectionHeader(
                  title: title,
                  subtitle: subtitle,
                  action: headerAction,
                ),
                const SizedBox(height: YronSpacing.lg),
                child,
                if (actions.isNotEmpty) ...[
                  const SizedBox(height: YronSpacing.lg),
                  Wrap(
                    alignment: WrapAlignment.end,
                    spacing: YronSpacing.sm,
                    runSpacing: YronSpacing.sm,
                    children: actions,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
