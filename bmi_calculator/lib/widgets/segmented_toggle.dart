import 'package:flutter/material.dart';

class SegmentedToggle<T> extends StatelessWidget {
  final T value;
  final void Function(T) onValueChanged;
  final Map<T, String> children;

  const SegmentedToggle({super.key, required this.value, required this.onValueChanged, required this.children});

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: children.keys.map((k) => k == value).toList(),
      onPressed: (index) {
        final key = children.keys.elementAt(index);
        onValueChanged(key);
      },
      children: children.values.map((s) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(s),
      )).toList(),
    );
  }
}
