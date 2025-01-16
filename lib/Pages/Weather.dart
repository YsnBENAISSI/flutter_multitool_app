import 'package:flutter/material.dart';
import 'package:flutter_projet_1/Pages/WeatherApiCaller.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import '../main.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();
  Map<String, dynamic>? weatherData;
  bool isLoading = false;

  Future<void> _getWeatherData(String cityName) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiCaller.callApiWeatherByCityName(cityName);
      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('City not found')),
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching weather data')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showDetailedInfo() {
    if (weatherData == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Text(weatherData!['name']),
            const SizedBox(width: 10),
            Image.network(
              ApiCaller.callApiFlagsByCode(weatherData!['sys']['country']),
              height: 24,
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _detailRow('Feels Like', '${(weatherData!['main']['feels_like'] - 273.15).toStringAsFixed(1)}°C'),
              _detailRow('Humidity', '${weatherData!['main']['humidity']}%'),
              _detailRow('Pressure', '${weatherData!['main']['pressure']} hPa'),
              _detailRow('Wind Speed', '${weatherData!['wind']['speed']} m/s'),
              _detailRow('Visibility', '${weatherData!['visibility'] / 1000} km'),
              _detailRow('Sunrise', DateFormat('HH:mm').format(
                  DateTime.fromMillisecondsSinceEpoch(weatherData!['sys']['sunrise'] * 1000)
              )),
              _detailRow('Sunset', DateFormat('HH:mm').format(
                  DateTime.fromMillisecondsSinceEpoch(weatherData!['sys']['sunset'] * 1000)
              )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weather'),
        ),
        drawer: const CommonDrawer(currentPage: 'weather'),
        body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade300, Colors.blue.shade700],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      hintText: 'Enter city name',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          if (_cityController.text.isNotEmpty) {
                            _getWeatherData(_cityController.text);
                          }
                        },
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _getWeatherData(value);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              if (isLoading)
                const CircularProgressIndicator(color: Colors.white)
              else if (weatherData != null)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _showDetailedInfo,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    weatherData!['name'],
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Image.network(
                                    ApiCaller.callApiFlagsByCode(weatherData!['sys']['country']),
                                    height: 32,
                                  ),
                                ],
                              ),
                              const Text(
                                'Tap for more details',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Card(
                          elevation: 4,
                          color: Colors.white.withOpacity(0.9),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      'https://openweathermap.org/img/wn/${weatherData!['weather'][0]['icon']}@2x.png',
                                    ),
                                    Text(
                                      '${(weatherData!['main']['temp'] - 273.15).toStringAsFixed(1)}°C',
                                      style: const TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  weatherData!['weather'][0]['description'].toString().toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    _weatherInfo(
                                      Icons.thermostat,
                                      'Feels Like',
                                      '${(weatherData!['main']['feels_like'] - 273.15).toStringAsFixed(1)}°C',
                                    ),
                                    _weatherInfo(
                                      Icons.water_drop,
                                      'Humidity',
                                      '${weatherData!['main']['humidity']}%',
                                    ),
                                    _weatherInfo(
                                      Icons.speed,
                                      'Pressure',
                                      '${weatherData!['main']['pressure']} hPa',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    )
    );
  }

  Widget _weatherInfo(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }
}