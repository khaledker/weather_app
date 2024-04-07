// Import the model class for current weather data
import 'package:weatherapp/model/weather_data_current.dart';

// Define a class to represent weather data
class WeatherData {
  // Define a field to hold the current weather data
  final WeatherDataCurrent? current;

  // Constructor for the WeatherData class
  WeatherData([this.current]);

WeatherDataCurrent getCurrentWeather() => current!;



}

