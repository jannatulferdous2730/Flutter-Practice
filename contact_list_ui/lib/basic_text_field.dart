
import 'package:flutter/material.dart';

class BasicTextField extends StatelessWidget {
  const BasicTextField({
    super.key,
    required this.icon,
    required this.hintText,
  });

  final Icon icon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
