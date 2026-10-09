import 'package:flutter/material.dart';

import '../theme/yron_theme.dart';

/// Visual emphasis for [YronButton].
enum YronButtonVariant { primary, secondary, quiet, destructive }

/// Accessible action button with disabled and loading states.
///
/// Supply a localized [loadingLabel] when the action is in progress.
class YronButton extends StatelessWidget {
  const YronButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = YronButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.loadingLabel,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final YronButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final String? loadingLabel;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final foreground = switch (variant) {
      YronButtonVariant.primary => YronColors.canvas,
      YronButtonVariant.destructive => YronColors.tertiary,
      _ => YronColors.textPrimary,
    };
    final background = switch (variant) {
      YronButtonVariant.primary => YronColors.primary,
      YronButtonVariant.quiet => Colors.transparent,
      _ => YronColors.surface,
    };
    final enabled = onPressed != null && !isLoading;
    final button = TextButton(
      onPressed: enabled ? onPressed : null,
      style: TextButton.styleFrom(
        foregroundColor: foreground,
        backgroundColor: background,
        disabledForegroundColor: YronColors.textMuted,
        disabledBackgroundColor: YronColors.outline,
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.symmetric(
          horizontal: YronSpacing.md,
          vertical: YronSpacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: YronRadii.small,
          side: variant == YronButtonVariant.secondary
              ? const BorderSide(color: YronColors.outline)
              : BorderSide.none,
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) ...[
            SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: YronColors.textMuted,
              ),
            ),
            const SizedBox(width: YronSpacing.sm),
          ] else if (icon != null) ...[
            Icon(icon, size: 18),
            const SizedBox(width: YronSpacing.sm),
          ],
          Flexible(child: Text(isLoading ? loadingLabel ?? label : label)),
        ],
      ),
    );
    return Semantics(
      liveRegion: isLoading,
      child: expand ? SizedBox(width: double.infinity, child: button) : button,
    );
  }
}
