import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('YOUR_API_KEY');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getcurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null || mainCondition.isEmpty)
      return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case "shower rain":
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case "clear":
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 44, 44, 44),
      ),
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.location_on,
                color: const Color.fromARGB(255, 128, 128, 128)),
            Text(' ${_weather?.cityName ?? 'Unknown'}',
                style: TextStyle(
                    color: const Color.fromARGB(255, 128, 128, 128),
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Lottie.asset(
              getWeatherAnimation(_weather?.mainCondition),
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Text('${_weather?.temperature ?? 0}°C',
                style: TextStyle(
                    color: const Color.fromARGB(255, 128, 128, 128),
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text('${_weather?.mainCondition ?? 'Unknown'}',
                style: TextStyle(
                    color: const Color.fromARGB(255, 128, 128, 128),
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
