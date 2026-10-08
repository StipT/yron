import 'package:flutter/material.dart';

abstract final class YronColors {
  static const canvas = Color(0xFF0E0E0E);
  static const surface = Color(0xFF161618);
  static const elevatedSurface = Color(0xFF1E1E22);
  static const outline = Color(0xFF2E2E32);
  static const primary = Color(0xFFCCFF00);
  static const secondary = Color(0xFF00E5FF);
  static const tertiary = Color(0xFFFF3B30);
  static const textPrimary = Color(0xFFF4F4F5);
  static const textMuted = Color(0xFF8A8A93);
  static const limeSurface = Color(0xFF1E2800);
}

abstract final class YronTypography {
  static const sansFamily = 'Montserrat';
  static const monoFamily = 'JetBrains Mono';
}

abstract final class YronSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}

abstract final class YronRadii {
  static const small = BorderRadius.all(Radius.circular(4));
  static const medium = BorderRadius.all(Radius.circular(8));
  static const card = BorderRadius.all(Radius.circular(12));
}

ThemeData buildYronTheme() {
  const colorScheme = ColorScheme.dark(
    primary: YronColors.primary,
    onPrimary: YronColors.canvas,
    secondary: YronColors.secondary,
    onSecondary: YronColors.canvas,
    error: YronColors.tertiary,
    onError: Colors.white,
    surface: YronColors.surface,
    onSurface: YronColors.textPrimary,
    surfaceContainerHighest: YronColors.elevatedSurface,
    outline: YronColors.outline,
  );

  final baseTextTheme = ThemeData.dark().textTheme.apply(
    fontFamily: YronTypography.sansFamily,
    bodyColor: YronColors.textPrimary,
    displayColor: YronColors.textPrimary,
  );
  final textTheme = baseTextTheme.copyWith(
    headlineMedium: baseTextTheme.headlineMedium?.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.6,
    ),
    titleLarge: baseTextTheme.titleLarge?.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    labelSmall: baseTextTheme.labelSmall?.copyWith(
      fontFamily: YronTypography.monoFamily,
      fontSize: 10,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.8,
    ),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: YronColors.canvas,
    fontFamily: YronTypography.sansFamily,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: YronColors.canvas,
      foregroundColor: YronColors.textPrimary,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: 1.1,
      ),
    ),
    cardTheme: CardThemeData(
      color: YronColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: YronRadii.medium,
        side: const BorderSide(color: YronColors.outline),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: YronColors.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: YronSpacing.md,
        vertical: YronSpacing.md,
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(
        color: YronColors.textMuted,
        fontSize: 12,
      ),
      border: const OutlineInputBorder(
        borderRadius: YronRadii.small,
        borderSide: BorderSide(color: YronColors.outline),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: YronRadii.small,
        borderSide: BorderSide(color: YronColors.outline),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: YronRadii.small,
        borderSide: BorderSide(color: YronColors.primary, width: 1.5),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: YronRadii.small,
        borderSide: BorderSide(color: YronColors.tertiary),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: YronRadii.small,
        borderSide: BorderSide(color: YronColors.tertiary, width: 1.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: YronColors.primary,
        foregroundColor: YronColors.canvas,
        disabledBackgroundColor: YronColors.outline,
        disabledForegroundColor: YronColors.textMuted,
        minimumSize: const Size(48, 52),
        shape: const RoundedRectangleBorder(borderRadius: YronRadii.small),
        textStyle: const TextStyle(
          fontFamily: YronTypography.sansFamily,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: YronColors.primary,
      foregroundColor: YronColors.canvas,
      shape: RoundedRectangleBorder(borderRadius: YronRadii.medium),
    ),
    dividerTheme: const DividerThemeData(
      color: YronColors.outline,
      thickness: 1,
      space: 1,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: YronColors.elevatedSurface,
      contentTextStyle: textTheme.bodyMedium?.copyWith(
        color: YronColors.textPrimary,
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
