import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class HourlyWeatherWidget extends StatelessWidget {
  final HourlyWeather weather;
  final WeatherService weatherService;

  const HourlyWeatherWidget({
    super.key,
    required this.weather,
    required this.weatherService,
  });

  @override
  Widget build(BuildContext context) {
    // Show only next 24 hours
    final displayCount = weather.time.length > 24 ? 24 : weather.time.length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.access_time,
                color: Color(0xFF3B82F6),
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Hourly Forecast',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: displayCount,
              itemBuilder: (context, index) {
                return _buildHourlyItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyItem(int index) {
    final time = DateTime.parse(weather.time[index]);
    final hour = DateFormat('HH:mm').format(time);
    final temp = weather.temperature[index];
    final code = weather.weatherCode[index];

    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF334155),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF475569),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            hour,
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            weatherService.getWeatherIcon(code),
            style: const TextStyle(fontSize: 32),
          ),
          Text(
            '${temp.toStringAsFixed(0)}°',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
