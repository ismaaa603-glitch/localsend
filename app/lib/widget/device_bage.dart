import 'package:flutter/material.dart';

class DeviceBadge extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final String label;

  const DeviceBadge({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: foregroundColor.withValues(alpha: 0.35)),
        borderRadius: BorderRadius.zero,
      ),
      child: Text(label, style: TextStyle(color: foregroundColor, fontSize: 12)),
    );
  }
}
