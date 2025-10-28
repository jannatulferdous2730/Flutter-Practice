import 'package:flutter/material.dart';

enum BMICategory { underweight, normal, overweight, obese }

class BMIResult {
  final double bmi;
  final BMICategory category;

  BMIResult({required this.bmi, required this.category});

  String get categoryLabel {
    switch (category) {
      case BMICategory.underweight:
        return 'Underweight';
      case BMICategory.normal:
        return 'Normal';
      case BMICategory.overweight:
        return 'Overweight';
      case BMICategory.obese:
        return 'Obese';
    }
  }

  Color get categoryColor {
    switch (category) {
      case BMICategory.underweight:
        return Colors.blue;
      case BMICategory.normal:
        return Colors.green;
      case BMICategory.overweight:
        return Colors.orange;
      case BMICategory.obese:
        return Colors.red;
    }
  }
}
