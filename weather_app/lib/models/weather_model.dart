class WeatherData {
  final CurrentWeather? current;
  final HourlyWeather? hourly;
  final DailyWeather? daily;

  WeatherData({
    this.current,
    this.hourly,
    this.daily,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      current: json['current'] != null
          ? CurrentWeather.fromJson(json['current'])
          : null,
      hourly: json['hourly'] != null
          ? HourlyWeather.fromJson(json['hourly'])
          : null,
      daily:
          json['daily'] != null ? DailyWeather.fromJson(json['daily']) : null,
    );
  }
}

class CurrentWeather {
  final String time;
  final double temperature;
  final int weatherCode;
  final double windSpeed;

  CurrentWeather({
    required this.time,
    required this.temperature,
    required this.weatherCode,
    required this.windSpeed,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      time: json['time'] ?? '',
      temperature: (json['temperature_2m'] ?? 0).toDouble(),
      weatherCode: json['weather_code'] ?? 0,
      windSpeed: (json['wind_speed_10m'] ?? 0).toDouble(),
    );
  }
}

class HourlyWeather {
  final List<String> time;
  final List<double> temperature;
  final List<int> weatherCode;
  final List<double> windSpeed;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.weatherCode,
    required this.windSpeed,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: List<String>.from(json['time'] ?? []),
      temperature: ((json['temperature_2m'] as List?)
              ?.map((e) => (e ?? 0).toDouble())
              .toList() ??
          []).cast<double>(),
      weatherCode:
          (json['weather_code'] as List?)?.map((e) => e as int).toList() ?? [],
      windSpeed: ((json['wind_speed_10m'] as List?)
              ?.map((e) => (e ?? 0).toDouble())
              .toList() ??
          []).cast<double>(),
    );
  }
}

class DailyWeather {
  final List<String> time;
  final List<double> temperatureMax;
  final List<double> temperatureMin;
  final List<String> sunrise;
  final List<String> sunset;

  DailyWeather({
    required this.time,
    required this.temperatureMax,
    required this.temperatureMin,
    required this.sunrise,
    required this.sunset,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      time: List<String>.from(json['time'] ?? []),
      temperatureMax: ((json['temperature_2m_max'] as List?)
              ?.map((e) => (e ?? 0).toDouble())
              .toList() ??
          []).cast<double>(),
      temperatureMin: ((json['temperature_2m_min'] as List?)
              ?.map((e) => (e ?? 0).toDouble())
              .toList() ??
          []).cast<double>(),
      sunrise: List<String>.from(json['sunrise'] ?? []),
      sunset: List<String>.from(json['sunset'] ?? []),
    );
  }
}
