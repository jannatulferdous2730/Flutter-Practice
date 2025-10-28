import 'package:flutter/material.dart';

import '../models/bmi_result.dart';
import '../services/bmi_calculator.dart';

class BMIViewModel extends ChangeNotifier {
  // weight
  WeightUnit weightUnit = WeightUnit.kg;
  final TextEditingController weightController = TextEditingController();

  // height
  HeightUnit heightUnit = HeightUnit.cm;
  final TextEditingController heightController = TextEditingController(); // for cm or m
  final TextEditingController ftController = TextEditingController();
  final TextEditingController inController = TextEditingController();

  BMIResult? result;

  void disposeAll() {
    weightController.dispose();
    heightController.dispose();
    ftController.dispose();
    inController.dispose();
    dispose();
  }

  void setWeightUnit(WeightUnit u) {
    weightUnit = u;
    notifyListeners();
  }

  void setHeightUnit(HeightUnit u) {
    heightUnit = u;
    notifyListeners();
  }

  /// Validate inputs and compute BMI. Throws FormatException on invalid input.
  void calculate() {
    final weightText = weightController.text.trim();
    if (weightText.isEmpty) throw FormatException('Please enter weight');
    final weight = double.tryParse(weightText);
    if (weight == null || weight <= 0) throw FormatException('Weight must be a positive number');

    double kg;
    if (weightUnit == WeightUnit.kg) {
      kg = weight;
    } else {
      kg = BMICalculator.lbToKg(weight);
    }

    double meters;
    if (heightUnit == HeightUnit.cm) {
      final hText = heightController.text.trim();
      if (hText.isEmpty) throw FormatException('Please enter height in cm');
      final cm = double.tryParse(hText);
      if (cm == null || cm <= 0) throw FormatException('Height must be a positive number');
      meters = BMICalculator.cmToM(cm);
    } else if (heightUnit == HeightUnit.m) {
      final hText = heightController.text.trim();
      if (hText.isEmpty) throw FormatException('Please enter height in meters');
      final m = double.tryParse(hText);
      if (m == null || m <= 0) throw FormatException('Height must be a positive number');
      meters = m;
    } else {
      // ft + in
      final ftText = ftController.text.trim();
      final inText = inController.text.trim();
      final ft = double.tryParse(ftText.isEmpty ? '0' : ftText) ?? 0.0;
      var inches = double.tryParse(inText.isEmpty ? '0' : inText) ?? 0.0;

      // Carry over inches >= 12 into feet
      if (inches >= 12) {
        final extraFt = inches ~/ 12;
        inches = inches % 12;
        final newFt = ft + extraFt;
        ftController.text = newFt.toStringAsFixed(0);
        inController.text = inches.toString();
      }

      if (ft <= 0 && inches <= 0) throw FormatException('Please enter height in ft/in');

      meters = BMICalculator.ftInToM(ft, inches);
    }

    result = BMICalculator.computeFromKgAndM(kg: kg, meters: meters);
    notifyListeners();
  }

  void clearResult() {
    result = null;
    notifyListeners();
  }
}
