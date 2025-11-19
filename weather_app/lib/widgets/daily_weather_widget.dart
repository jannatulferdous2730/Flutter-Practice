import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class DailyWeatherWidget extends StatelessWidget {
  final DailyWeather weather;
  final WeatherService weatherService;

  const DailyWeatherWidget({
    super.key,
    required this.weather,
    required this.weatherService,
  });

  @override
  Widget build(BuildContext context) {
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
                Icons.calendar_today,
                color: Color(0xFF3B82F6),
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                '10-Day Forecast',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: weather.time.length,
            itemBuilder: (context, index) {
              return _buildDailyItem(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDailyItem(int index) {
    final date = DateTime.parse(weather.time[index]);
    final dayName = DateFormat('EEE').format(date);
    final dayDate = DateFormat('MMM d').format(date);
    final tempMax = weather.temperatureMax[index];
    final tempMin = weather.temperatureMin[index];
    
    // For daily forecast, we'll use the max temp to determine general conditions
    // Since Open-Meteo doesn't provide weather code for daily, we'll show a generic icon
    final sunrise = weather.sunrise[index];
    final sunset = weather.sunset[index];
    
    final sunriseTime = DateFormat('HH:mm').format(DateTime.parse(sunrise));
    final sunsetTime = DateFormat('HH:mm').format(DateTime.parse(sunset));

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF334155),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF475569),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  dayDate,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Icon(
                      Icons.wb_sunny,
                      color: Color(0xFFFBBF24),
                      size: 16,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      sunriseTime,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Column(
                  children: [
                    const Icon(
                      Icons.nightlight,
                      color: Color(0xFF818CF8),
                      size: 16,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      sunsetTime,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_upward,
                          color: Color(0xFFEF4444),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${tempMax.toStringAsFixed(0)}°',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_downward,
                          color: Color(0xFF3B82F6),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${tempMin.toStringAsFixed(0)}°',
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
