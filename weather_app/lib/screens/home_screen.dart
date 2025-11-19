import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/hourly_weather_widget.dart';
import '../widgets/daily_weather_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final WeatherService _weatherService = WeatherService();

  bool _isLoading = false;
  bool _isGettingLocation = false;
  String? _errorMessage;
  WeatherData? _weatherData;

  @override
  void initState() {
    super.initState();
    // Default coordinates for Dhaka
    _latitudeController.text = '23.8103';
    _longitudeController.text = '90.4125';
    _checkLocationPermissionAndGetLocation();
  }

  Future<void> _checkLocationPermissionAndGetLocation() async {
    try {
      setState(() {
        _isGettingLocation = true;
      });

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _isGettingLocation = false;
        });
        _showLocationDialog(
          'Location Services Disabled',
          'Please enable location services to automatically fetch your location, or enter coordinates manually.',
        );
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _isGettingLocation = false;
          });
          _showLocationDialog(
            'Location Permission Denied',
            'Please enter latitude and longitude manually.',
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _isGettingLocation = false;
        });
        _showLocationDialog(
          'Location Permission Denied Forever',
          'Location permissions are permanently denied. Please enable them in app settings or enter coordinates manually.',
        );
        return;
      }

      // Get current location
      await _getCurrentLocation();
    } catch (e) {
      setState(() {
        _isGettingLocation = false;
      });
      _showLocationDialog(
        'Location Error',
        'Failed to get location: $e\nPlease enter coordinates manually.',
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      setState(() {
        _isGettingLocation = true;
      });

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        ),
      );

      setState(() {
        _latitudeController.text = position.latitude.toStringAsFixed(4);
        _longitudeController.text = position.longitude.toStringAsFixed(4);
        _isGettingLocation = false;
      });

      // Automatically fetch weather after getting location
      await _fetchWeather();
    } catch (e) {
      setState(() {
        _isGettingLocation = false;
      });
      _showLocationDialog(
        'Error Getting Location',
        'Could not fetch your current location: $e\nPlease enter coordinates manually.',
      );
    }
  }

  void _showLocationDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          message,
          style: const TextStyle(color: Color(0xFF94A3B8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'OK',
              style: TextStyle(color: Color(0xFF3B82F6)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  Future<void> _fetchWeather() async {
    final latitude = double.tryParse(_latitudeController.text);
    final longitude = double.tryParse(_longitudeController.text);

    if (latitude == null || longitude == null) {
      setState(() {
        _errorMessage = 'Please enter valid latitude and longitude';
        _weatherData = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _weatherData = null;
    });

    try {
      final data = await _weatherService.getWeather(latitude, longitude);
      setState(() {
        _weatherData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text(
          'Weather Forecast',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildInputSection(),
          Expanded(
            child: _buildContentSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _latitudeController,
                        label: 'Latitude',
                        icon: Icons.location_on,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        controller: _longitudeController,
                        label: 'Longitude',
                        icon: Icons.my_location,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF334155),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: (_isLoading || _isGettingLocation)
                      ? null
                      : _getCurrentLocation,
                  icon: _isGettingLocation
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF3B82F6),
                          ),
                        )
                      : const Icon(
                          Icons.gps_fixed,
                          color: Color(0xFF3B82F6),
                          size: 28,
                        ),
                  tooltip: 'Use my location',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              onPressed: _isLoading ? null : _fetchWeather,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                disabledBackgroundColor: const Color(0xFF64748B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.cloud_outlined, color: Colors.white),
              label: const Text(
                'Get Weather',
                style: TextStyle(
                  fontSize: 16,
                  // fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF94A3B8)),
        prefixIcon: Icon(icon, color: const Color(0xFF3B82F6)),
        filled: true,
        fillColor: const Color(0xFF334155),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Color(0xFF3B82F6),
              strokeWidth: 3,
            ),
            SizedBox(height: 16),
            Text(
              'Loading weather data...',
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Color(0xFFEF4444),
              ),
              const SizedBox(height: 16),
              Text(
                'Error',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _fetchWeather,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_weatherData == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_outlined,
              size: 100,
              color: const Color(0xFF475569),
            ),
            const SizedBox(height: 16),
            Text(
              'Enter coordinates to get weather',
              style: TextStyle(
                color: const Color(0xFF94A3B8),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_weatherData!.current != null)
            CurrentWeatherWidget(
              weather: _weatherData!.current!,
              weatherService: _weatherService,
            ),
          const SizedBox(height: 20),
          if (_weatherData!.hourly != null)
            HourlyWeatherWidget(
              weather: _weatherData!.hourly!,
              weatherService: _weatherService,
            ),
          const SizedBox(height: 20),
          if (_weatherData!.daily != null)
            DailyWeatherWidget(
              weather: _weatherData!.daily!,
              weatherService: _weatherService,
            ),
        ],
      ),
    );
  }
}
