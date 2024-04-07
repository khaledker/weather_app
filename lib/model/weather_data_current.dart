


// Define a class to represent current weather conditions
class Current {
  // Fields to hold various weather parameters
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;

  // Constructor for Current class
  Current({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  // Factory method to create Current object from JSON data
  factory Current.fromJson(Map<String, dynamic> json) => Current(
        // Initialize fields from JSON data
        temp: (json['temp'] as num?)?.toDouble(),
        feelsLike: (json['feels_like'] as num?)?.toDouble(),
        tempMin: (json['temp_min'] as num?)?.toDouble(),
        tempMax: (json['temp_max'] as num?)?.toDouble(),
        pressure: json['pressure'] as int?,
        humidity: json['humidity'] as int?,
      );

  // Method to convert Current object to JSON data
  Map<String, dynamic> toJson() => {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'humidity': humidity,
      };
}

// Define a class to represent weather information
class Weather {
  List<Weather>? weather; // List of weather conditions
  String? base; // Base station
  Current? current; // Current weather conditions
  int? visibility; // Visibility
  int? dt; // Date and time
  int? id; // Location ID
  String? name; // Location name
  int? cod; // Response code

  // Constructor for Weather class
  Weather({
    this.weather,
    this.base,
    this.current,
    this.visibility,
    this.dt,
    this.id,
    this.name,
    this.cod,
  });

  // Factory method to create Weather object from JSON data
  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        // Initialize fields from JSON data
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
        base: json['base'] as String?,
        current: json['current'] == null
            ? null
            : Current.fromJson(json['current'] as Map<String, dynamic>),
        visibility: json['visibility'] as int?,
        dt: json['dt'] as int?,
        id: json['id'] as int?,
        name: json['name'] as String?,
        cod: json['cod'] as int?,
      );

  // Method to convert Weather object to JSON data
  Map<String, dynamic> toJson() => {
        'weather': weather?.map((e) => e.toJson()).toList(),
        'base': base,
        'current': current?.toJson(),
        'visibility': visibility,
        'dt': dt,
        'id': id,
        'name': name,
        'cod': cod,
      };
}


// Define a class to represent current weather data
class WeatherDataCurrent {
  final Current current; // Field to hold current weather information

  // Constructor for WeatherDataCurrent class
  WeatherDataCurrent({required this.current});

  // Factory method to create WeatherDataCurrent object from JSON data
 factory WeatherDataCurrent.fromJson(Map<String, dynamic> json)=>  WeatherDataCurrent( current: Current.fromJson(json['current']));

}