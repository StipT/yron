import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yron_ui/yron_ui.dart';

void main() {
  test('defines the YRON dark palette and typography', () {
    final theme = buildYronTheme();

    expect(theme.brightness, Brightness.dark);
    expect(theme.colorScheme.primary, YronColors.primary);
    expect(theme.scaffoldBackgroundColor, YronColors.canvas);
    expect(theme.textTheme.bodyMedium?.fontFamily, YronTypography.sansFamily);
    expect(theme.textTheme.labelSmall?.fontFamily, YronTypography.monoFamily);
  });
}
