import 'dart:math';

import '../models/bmi_result.dart';

enum WeightUnit { kg, lb }
enum HeightUnit { cm, m, ft_in }

class BMICalculator {
  /// Convert pounds to kilograms
  static double lbToKg(double lb) => lb * 0.45359237;

  /// Convert centimeters to meters
  static double cmToM(double cm) => cm / 100.0;

  /// Given feet and inches, return meters
  static double ftInToM(double ft, double inches) {
    final totalInches = ft * 12.0 + inches;
    final meters = totalInches * 0.0254;
    return meters;
  }

  /// Compute BMI given weight in kilograms and height in meters
  static BMIResult computeFromKgAndM({required double kg, required double meters}) {
    final height = max(meters, 0.0001);
    final bmi = kg / (height * height);
    final category = _categoryForBMI(bmi);
    return BMIResult(bmi: bmi, category: category);
  }

  static BMICategory _categoryForBMI(double bmi) {
    if (bmi < 18.5) return BMICategory.underweight;
    if (bmi < 25.0) return BMICategory.normal;
    if (bmi < 30.0) return BMICategory.overweight;
    return BMICategory.obese;
  }
}
