import 'package:weatherapp/api/api_key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weatherapp/model/weather/current.dart';

class CurrentRepository {

  Future<Current> fetchCurrentWeather(double lat, double lon) async {
  try {
      // Construct the API URL

      // Make a GET request to the API
      var response = await http.get(Uri.parse(apiURL(lat, lon)));

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Decode the JSON response
        var jsonString = jsonDecode(response.body);
          print(response.body);
          return Current.fromJson(jsonString);
        // Create a WeatherData object from the decoded JSON

      } else {
        // If the response is not successful, throw an error
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    }catch (e) {
      throw Exception('Failed to fetch current weather');
    }
  }
}
 String apiURL(double lat, double lon) {
String url;

  url =
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
  return url;
    }
