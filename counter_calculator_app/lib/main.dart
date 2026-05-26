import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(const CounterCalculatorApp());
}

class CounterCalculatorApp extends StatelessWidget {
  const CounterCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter Calculator App',
      theme: ThemeData(useMaterial3: true, fontFamily: 'Roboto'),
      home: const CounterCalculatorHome(),
    );
  }
}