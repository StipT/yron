import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';

/// Caller-owned destination metadata, independent of the application's router.
@immutable
class YronNavigationItem {
  const YronNavigationItem({
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.tooltip,
  });

  final String label;
  final IconData icon;
  final IconData? selectedIcon;
  final String? tooltip;
}

/// Controlled bottom navigation with Material focus and selection semantics.
class YronBottomNavigation extends StatelessWidget {
  YronBottomNavigation({
    super.key,
    required List<YronNavigationItem> items,
    required this.selectedIndex,
    required this.onSelected,
  }) : items = List.unmodifiable(items),
       assert(items.length >= 2),
       assert(selectedIndex >= 0 && selectedIndex < items.length);

  final List<YronNavigationItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: YronColors.outline)),
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => Theme.of(context).textTheme.labelSmall?.copyWith(
              fontFamily: YronTypography.sansFamily,
              fontFamilyFallback: const ['packages/yron_ui/Montserrat'],
              color: states.contains(WidgetState.selected)
                  ? YronColors.primary
                  : YronColors.textMuted,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onSelected,
          backgroundColor: YronColors.canvas,
          surfaceTintColor: Colors.transparent,
          indicatorColor: YronColors.limeSurface,
          elevation: 0,
          height: 72,
          destinations: [
            for (final item in items)
              NavigationDestination(
                icon: Icon(item.icon, color: YronColors.textMuted),
                selectedIcon: Icon(
                  item.selectedIcon ?? item.icon,
                  color: YronColors.primary,
                ),
                label: item.label,
                tooltip: item.tooltip ?? item.label,
              ),
          ],
        ),
      ),
    );
  }
}
