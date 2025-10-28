import 'package:flutter/material.dart';

import '../services/exception_handler.dart';
import '../services/bmi_calculator.dart';
import '../viewmodels/bmi_viewmodel.dart';
import '../widgets/decimal_input.dart';
import '../widgets/segmented_toggle.dart';
import '../widgets/result_card.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final BMIViewModel vm = BMIViewModel();

  @override
  void initState() {
    super.initState();
    vm.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    vm.disposeAll();
    super.dispose();
  }

  void _onCalculate() {
    try {
      vm.calculate();
    } on FormatException catch (f) {
      ExceptionHandler.showError(context, f.message);
    } catch (e) {
      ExceptionHandler.showError(context, 'Unexpected error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Text('Weight', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            SegmentedToggle<WeightUnit>(
              value: vm.weightUnit,
              onValueChanged: (v) => setState(() => vm.setWeightUnit(v)),
              children: const {WeightUnit.kg: 'kg', WeightUnit.lb: 'lb'},
            ),
            const SizedBox(height: 8),
            DecimalInput(controller: vm.weightController, label: 'Enter weight', hint: 'e.g. 70.5', suffix: vm.weightUnit == WeightUnit.kg ? 'kg' : 'lb'),
            const SizedBox(height: 16),

            Text('Height', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            SegmentedToggle<HeightUnit>(
              value: vm.heightUnit,
              onValueChanged: (v) => setState(() => vm.setHeightUnit(v)),
              children: const {HeightUnit.cm: 'cm', HeightUnit.m: 'm', HeightUnit.ft_in: 'ft/in'},
            ),
            const SizedBox(height: 8),
            if (vm.heightUnit == HeightUnit.cm) ...[
              DecimalInput(controller: vm.heightController, label: 'Height (cm)', hint: 'e.g. 170', suffix: 'cm'),
            ] else if (vm.heightUnit == HeightUnit.m) ...[
              DecimalInput(controller: vm.heightController, label: 'Height (m)', hint: 'e.g. 1.72', suffix: 'm'),
            ] else ...[
              Row(
                children: [
                  Expanded(child: DecimalInput(controller: vm.ftController, label: 'ft', hint: 'e.g. 5')),
                  const SizedBox(width: 12),
                  Expanded(child: DecimalInput(controller: vm.inController, label: 'in', hint: 'e.g. 7.5')),
                ],
              )
            ],

            const SizedBox(height: 20),
            ElevatedButton(onPressed: _onCalculate, child: const Text('Calculate BMI')),

            const SizedBox(height: 20),
            if (vm.result != null) ResultCard(result: vm.result!),
          ],
        ),
      ),
    );
  }
}
