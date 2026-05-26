import 'package:flutter/material.dart';

class CounterCalculatorHome extends StatefulWidget {
  const CounterCalculatorHome({super.key});

  @override
  State<CounterCalculatorHome> createState() => _CounterCalculatorHomeState();
}

class _CounterCalculatorHomeState extends State<CounterCalculatorHome> {
  double _currentValue = 0;

  final TextEditingController _increaseController = TextEditingController();
  final TextEditingController _decreaseController = TextEditingController();
  final TextEditingController _multiplyController = TextEditingController();
  final TextEditingController _divideController = TextEditingController();

  void _updateValue(double Function(double) operation) {
    setState(() {
      _currentValue = operation(_currentValue);
    });
  }

  void _reset() {
    setState(() {
      _currentValue = 0;
    });
  }

  @override
  void dispose() {
    _increaseController.dispose();
    _decreaseController.dispose();
    _multiplyController.dispose();
    _divideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4963E3),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: FlexibleSpaceBar(
          // background: Container(
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [Color(0xFF2E3E8E), Color(0xFF00C6FF)],
          //       begin: Alignment.centerLeft,
          //       end: Alignment.centerRight,
          //     ),
          //   ),
          // ),
        ),
        title: const Text(
          'Counter Calculator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _reset,
            icon: const Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF8F9FE),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              spacing: 20,
              children: [
                // Current Value Card
                _buildValueCard(),

                // Quick Actions
                _buildQuickActions(),

                // Increase/Decrease By
                Row(
                  children: [
                    Expanded(
                      child: _buildInputCard(
                        'INCREASE BY',
                        Icons.trending_up,
                        Colors.green,
                        _increaseController,
                        (val) => _updateValue((v) => v + val),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInputCard(
                        'DECREASE BY',
                        Icons.trending_down,
                        Colors.red,
                        _decreaseController,
                        (val) => _updateValue((v) => v - val),
                      ),
                    ),
                  ],
                ),

                // Multiply By
                _buildAdvancedActionCard(
                  title: 'MULTIPLY BY',
                  icon: Icons.close,
                  color: Colors.deepPurple,
                  quickValues: [2, 3, 4, 5, 10],
                  controller: _multiplyController,
                  onApply: (val) => _updateValue((v) => v * val),
                  label: 'Quick Multiply',
                ),

                // Divide By
                _buildAdvancedActionCard(
                  title: 'DIVIDE BY',
                  icon: Icons.horizontal_rule,
                  color: Colors.blueAccent,
                  quickValues: [2, 5, 10, 20, 50],
                  controller: _divideController,
                  onApply: (val) {
                    if (val != 0) {
                      _updateValue((v) => v / val);
                    }
                  },
                  label: 'Quick Divide',
                  isDivide: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildValueCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 30, height: 1.5, color: const Color(0xFF2E3E8E)),
              const SizedBox(width: 8),
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Color(0xFF2E3E8E),
                  shape: BoxShape.circle,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'CURRENT VALUE',
                  style: TextStyle(
                    color: Color(0xFF2E3E8E),
                    letterSpacing: 1.2,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Color(0xFF2E3E8E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(width: 30, height: 1.5, color: const Color(0xFF2E3E8E)),
            ],
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              _currentValue % 1 == 0
                  ? _currentValue.toInt().toString()
                  : _currentValue.toStringAsFixed(1),
              style: const TextStyle(
                color: Color(0xFF0A0E21),
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 60, height: 1, color: Colors.grey.shade300),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'QUICK ACTIONS',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 1.2,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(width: 60, height: 1, color: Colors.grey.shade300),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: _buildQuickButton(
                '1',
                'Increase by 1',
                const [Color(0xFF4CAF50), Color(0xFF00C6FF)],
                () => _updateValue((v) => v + 1),
                Icons.add,
                Colors.green,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildQuickButton(
                '1',
                'Decrease by 1',
                const [Color(0xFFFF5252), Color(0xFFFF8A80)],
                () => _updateValue((v) => v - 1),
                Icons.remove,
                Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickButton(
    String title,
    String subtitle,
    List<Color> gradient,
    VoidCallback onPressed,
    IconData icon,
    Color textColor,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradient),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: gradient[0].withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildInputCard(
    String title,
    IconData icon,
    Color color,
    TextEditingController controller,
    Function(double) onApply,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 16),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter number',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              suffixIcon: Icon(
                Icons.format_list_bulleted,
                color: Colors.grey.shade400,
                size: 16,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final val = double.tryParse(controller.text);
                if (val != null) {
                  onApply(val);
                  controller.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                'APPLY',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedActionCard({
    required String title,
    required IconData icon,
    required Color color,
    required List<double> quickValues,
    required TextEditingController controller,
    required Function(double) onApply,
    required String label,
    bool isDivide = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: isDivide
                        ? Text(
                            '÷',
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        : Icon(icon, color: color, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.flash_on, color: color, size: 14),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: quickValues
                .map((v) => _buildQuickValueButton(v, color, onApply))
                .toList(),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 40, height: 1, color: Colors.grey.shade200),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'or enter custom number',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
                ),
              ),
              Container(width: 40, height: 1, color: Colors.grey.shade200),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter number',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 13,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    suffixIcon: Icon(
                      Icons.format_list_bulleted,
                      color: Colors.grey.shade400,
                      size: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  final val = double.tryParse(controller.text);
                  if (val != null) {
                    onApply(val);
                    controller.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'APPLY',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickValueButton(
    double value,
    Color color,
    Function(double) onApply,
  ) {
    return GestureDetector(
      onTap: () => onApply(value),
      child: Container(
        width: 55,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: Text(
          value.toInt().toString(),
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
