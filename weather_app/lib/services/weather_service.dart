import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  static const String baseUrl = 'https://api.open-meteo.com/v1/forecast';
  static const String timezone = 'Asia/Dhaka';

  Future<WeatherData> getWeather(double latitude, double longitude) async {
    try {
      final url = Uri.parse(
        '$baseUrl?latitude=$latitude&longitude=$longitude'
        '&current=temperature_2m,weather_code,wind_speed_10m'
        '&hourly=temperature_2m,weather_code,wind_speed_10m'
        '&daily=temperature_2m_max,temperature_2m_min,sunrise,sunset'
        '&forecast_days=10'
        '&timezone=$timezone',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherData.fromJson(data);
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }

  String getWeatherDescription(int code) {
    switch (code) {
      case 0:
        return 'Clear sky';
      case 1:
      case 2:
      case 3:
        return 'Partly cloudy';
      case 45:
      case 48:
        return 'Foggy';
      case 51:
      case 53:
      case 55:
        return 'Drizzle';
      case 61:
      case 63:
      case 65:
        return 'Rain';
      case 71:
      case 73:
      case 75:
        return 'Snow';
      case 77:
        return 'Snow grains';
      case 80:
      case 81:
      case 82:
        return 'Rain showers';
      case 85:
      case 86:
        return 'Snow showers';
      case 95:
        return 'Thunderstorm';
      case 96:
      case 99:
        return 'Thunderstorm with hail';
      default:
        return 'Unknown';
    }
  }

  String getWeatherIcon(int code) {
    switch (code) {
      case 0:
        return '☀️';
      case 1:
      case 2:
      case 3:
        return '⛅';
      case 45:
      case 48:
        return '🌫️';
      case 51:
      case 53:
      case 55:
        return '🌦️';
      case 61:
      case 63:
      case 65:
        return '🌧️';
      case 71:
      case 73:
      case 75:
        return '❄️';
      case 77:
        return '🌨️';
      case 80:
      case 81:
      case 82:
        return '🌦️';
      case 85:
      case 86:
        return '🌨️';
      case 95:
        return '⛈️';
      case 96:
      case 99:
        return '⛈️';
      default:
        return '🌡️';
    }
  }
}
