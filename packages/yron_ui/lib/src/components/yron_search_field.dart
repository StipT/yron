import 'package:flutter/material.dart';

import 'yron_text_field.dart';

/// Search input with an optional clear action.
///
/// The caller owns [controller]. Clearing notifies [onChanged] just like typing.
class YronSearchField extends StatelessWidget {
  const YronSearchField({
    super.key,
    required this.label,
    required this.controller,
    required this.clearTooltip,
    this.hint,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
  });

  final String label;
  final TextEditingController controller;
  final String clearTooltip;
  final String? hint;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return YronTextField(
          label: label,
          hint: hint,
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          prefixIcon: Icons.search,
          textInputAction: TextInputAction.search,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          suffix: value.text.isEmpty
              ? null
              : IconButton(
                  tooltip: clearTooltip,
                  onPressed: enabled
                      ? () {
                          controller.clear();
                          onChanged?.call('');
                        }
                      : null,
                  icon: const Icon(Icons.close),
                ),
        );
      },
    );
  }
}
