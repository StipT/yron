import 'package:flutter/material.dart';

class YronPrimaryButton extends StatelessWidget {
  const YronPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            if (icon case final icon?) Icon(icon, size: 18),
          ],
        ),
      ),
    );
  }
}
