import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/model/weather/current.dart';
import 'package:weatherapp/services/remote/current_repository.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding library for reverse geocoding


class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  RxString city = "".obs; // Variable to hold the city name
  RxString state = "".obs; // Variable to hold the state name
  final CurrentRepository _currentRepository = CurrentRepository();
  late DateTime now;
  late String formattedDate;

 

  final fetchedWeatherImage = ''.obs;
  final fetchedWeatherDescription = ''.obs;
  final fetchedWeatherTemperature = ''.obs;
  final fetchedWeatherFeelsLike = ''.obs;
  final fetchedWeatherHumidity = ''.obs;
  final fetchedWeatherWindSpeed = ''.obs;
  final fetchedWeatherCloud = ''.obs;
  final fetchedWeatherSunrise = ''.obs;
  final fetchedWeatherSunset = ''.obs;
  final fetchedWeatherTempMax = ''.obs;
  final fetchedWeatherTempMin = ''.obs;

  @override
  void onInit() {
       
    super.onInit();
    getLocation();
     getAddress(getLatitude().value,
        getLongitude().value);
            now = DateTime.now();
    // Format the date using the specified format
    formattedDate = DateFormat('MM/dd').format(now);
  }

  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  getLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission locationPermission;

    if (!isServiceEnabled) {
      return Future.error('Location is not enabled');
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('Location permission denied forever');
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
    }
    if (locationPermission == LocationPermission.denied) {
      return Future.error('Location permission denied');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    ).then((value) {
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;
      print(_latitude.value);
            print(_longitude.value);

      fetchCurrentWeather(_latitude.value, _longitude.value);
            _isLoading.value = false;

    });
  }

  Future<void> fetchCurrentWeather(double lat, double lon) async {
    try {
      Current fetchedCurrentWeather =
          await _currentRepository.fetchCurrentWeather(lat, lon);
     
    fetchedWeatherImage.value = fetchedCurrentWeather.weather![0].icon!;
      fetchedWeatherDescription.value =
          fetchedCurrentWeather.weather![0].description!;
      fetchedWeatherTemperature.value =
          fetchedCurrentWeather.main!.temp!.toString();
      fetchedWeatherFeelsLike.value =
          fetchedCurrentWeather.main!.feelsLike!.toString();
      fetchedWeatherHumidity.value =
          fetchedCurrentWeather.main!.humidity!.toString();
      fetchedWeatherWindSpeed.value =
          fetchedCurrentWeather.wind!.speed!.toString();
      fetchedWeatherCloud.value = fetchedCurrentWeather.clouds!.all!.toString();
      fetchedWeatherSunrise.value = DateFormat("jm").format(
          DateTime.fromMillisecondsSinceEpoch(
              fetchedCurrentWeather.sys!.sunrise! * 1000));
      fetchedWeatherSunset.value = DateFormat("jm").format(
          DateTime.fromMillisecondsSinceEpoch(
              fetchedCurrentWeather.sys!.sunset! * 1000));
      fetchedWeatherTempMax.value =
          fetchedCurrentWeather.main!.tempMax!.toString();
      fetchedWeatherTempMin.value =
          fetchedCurrentWeather.main!.tempMin!.toString();
          
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> getAddress(lat, lon) async {
    // Retrieve a list of placemarks based on the provided latitude and longitude
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);

    // Update the city and state variables with the retrieved placemark information
    
      city.value =
          placemark[0].locality!; // Get the city name from the first placemark
      state.value = placemark[0]
          .administrativeArea!; // Get the state name from the first placemark
   
  }

}
