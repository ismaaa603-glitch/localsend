import 'package:flutter/material.dart';
import 'package:localsend_app/config/avoid_style.dart';
import 'package:localsend_app/config/theme.dart';

/// A [DropdownButton] with a custom theme.
/// Currently, there is no easy way to apply color and border radius to all [DropdownButton].
class CustomDropdownButton<T> extends StatelessWidget {
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T>? onChanged;
  final bool expanded;

  const CustomDropdownButton({
    required this.value,
    required this.items,
    this.onChanged,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final avoid = isAvoidStyle(context);
    return Material(
      color: theme.inputDecorationTheme.fillColor,
      shape: RoundedRectangleBorder(
        borderRadius: theme.inputDecorationTheme.borderRadius,
        side: avoid ? BorderSide(color: theme.colorScheme.outline) : BorderSide.none,
      ),
      child: DropdownButton<T>(
        value: value,
        isExpanded: expanded,
        isDense: avoid,
        itemHeight: avoid ? null : kMinInteractiveDimension,
        padding: EdgeInsets.symmetric(horizontal: avoid ? 10 : 12, vertical: avoid ? 8 : 0),
        underline: Container(),
        borderRadius: theme.inputDecorationTheme.borderRadius,
        items: items,
        onChanged: onChanged == null
            ? null
            : (value) {
                if (value != null) {
                  onChanged!(value);
                }
              },
      ),
    );
  }
}
