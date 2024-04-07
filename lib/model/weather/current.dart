
import 'package:weatherapp/model/weather/clouds.dart';
import 'package:weatherapp/model/weather/sys.dart';
import 'package:weatherapp/model/weather/weather.dart';
import 'package:weatherapp/model/weather/wind.dart';

class Current {
  List<Weather>? weather;
  Data? main;
  Wind? wind;
  Clouds? clouds;
  Sys? sys;

  Current({
    this.weather,
    this.main,
    this.wind,
    this.clouds,
    this.sys,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
        main: json['main'] == null
            ? null
            : Data.fromJson(json['main'] as Map<String, dynamic>),
        wind: json['wind'] == null
            ? null
            : Wind.fromJson(json['wind'] as Map<String, dynamic>),
        clouds: json['clouds'] == null
            ? null
            : Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
        sys: json['sys'] == null
            ? null
            : Sys.fromJson(json['sys'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'weather': weather?.map((e) => e.toJson()).toList(),
        'main': main?.toJson(),
        'wind': wind?.toJson(),
        'clouds': clouds?.toJson(),
        'sys': sys?.toJson(),
      };
}

class Data {
  int? temp;
  int? feelsLike;
  int? tempMin;
  int? tempMax;
  int? humidity;

  Data({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.humidity,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        temp: (json['temp'] as num?)?.round(),
        feelsLike: (json['feels_like'] as num?)?.round(),
        tempMin: (json['temp_min'] as num?)?.round(),
        tempMax: (json['temp_max'] as num?)?.round(),
        humidity: json['humidity'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'humidity': humidity,
      };
}
