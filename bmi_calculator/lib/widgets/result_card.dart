import 'package:flutter/material.dart';
import '../models/bmi_result.dart';

class ResultCard extends StatelessWidget {
  final BMIResult result;

  const ResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('BMI', style: Theme.of(context).textTheme.titleLarge),
                Chip(
                  label: Text(result.categoryLabel, style: const TextStyle(color: Colors.white)),
                  backgroundColor: result.categoryColor,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(result.bmi.toStringAsFixed(1), style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(_bmiInterpretation(result), style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  String _bmiInterpretation(BMIResult r) {
    switch (r.category) {
      case BMICategory.underweight:
        return 'Below healthy weight';
      case BMICategory.normal:
        return 'Within a healthy range';
      case BMICategory.overweight:
        return 'Above healthy weight';
      case BMICategory.obese:
        return 'At high risk - consult a professional';
    }
  }
}
