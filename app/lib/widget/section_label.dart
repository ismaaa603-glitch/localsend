import 'package:flutter/material.dart';

/// A section header: a small label in the accent color
/// with a 1px divider underneath. [trailing] is shown at the end of the label row (e.g. action buttons).
class SectionLabel extends StatelessWidget {
  final String label;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  const SectionLabel({
    required this.label,
    this.trailing,
    this.padding = const EdgeInsets.only(top: 4),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: padding,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
        ),
        Divider(height: 1, thickness: 1, color: theme.colorScheme.outlineVariant),
      ],
    );
  }
}
