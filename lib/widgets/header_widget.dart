import 'package:get/get.dart'; // Import Get package for state management
import 'package:weatherapp/controller/global_controller.dart'; // Import GlobalController for accessing global app state
import 'package:flutter/material.dart'; // Import Flutter material library
import 'package:geocoding/geocoding.dart'; // Import geocoding library for reverse geocoding
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

// Define a stateful widget for the header of the app
class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});
  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = ""; // Variable to hold the city name
  String state = ""; // Variable to hold the state name

  // Initialize GlobalController for accessing global app state
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    // Get the address based on latitude and longitude when the widget is initialized
    getAddress(globalController.getLatitude().value,
        globalController.getLongitude().value);

    super.initState();
  }

  // Method to fetch the address based on latitude and longitude
  getAddress(lat, lon) async {
    // Retrieve a list of placemarks based on the provided latitude and longitude
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);

    // Update the city and state variables with the retrieved placemark information
    setState(() {
      city =
          placemark[0].locality!; // Get the city name from the first placemark
      state = placemark[0]
          .administrativeArea!; // Get the state name from the first placemark
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the current date and time
    DateTime now = DateTime.now();
    // Format the date and time using the specified format
    String formattedDate = DateFormat('MM/dd').format(now);

    // Return the header widget containing the city, state, and formatted date
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: const Color(0xFF19C3FB), // Hexadecimal color value
        height: 900,
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Container displaying the city and state
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 20, start: 20),
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Text(
                        city + "," + state,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 25,
                      )
                    ],
                  ),
                ),
                // Container displaying the formatted date

                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "${globalController.fetchedWeatherTemperature.value}°",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 88,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                            TextSpan(
                              text: globalController
                                  .fetchedWeatherDescription.value,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            TextSpan(
                              text: '   $formattedDate',
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Image.asset(
                    'assets/weather/${globalController.fetchedWeatherImage.value}.png',
                    // do a height and width
                    height: 200,
                    width: 200,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    height: 140,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(
                            255, 240, 239, 247), // Hexadecimal color value

                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0, right: 40, left: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                'assets/icons/windspeed.png',

                                // do a height and width
                                height: 50,
                                width: 50,
                              ),
                              Text(
                                '${globalController.fetchedWeatherWindSpeed.value} Km/h',
                                style: TextStyle(
                                  color: const Color(
                                      0xFF19C3FB), // Hexadecimal color value
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/icons/clouds.png',
                                // do a height and width
                                height: 50,
                                width: 50,
                              ),
                              Text(
                                '${globalController.fetchedWeatherCloud.value}%',
                                style: TextStyle(
                                  color: const Color(
                                      0xFF19C3FB), // Hexadecimal color value
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/icons/humidity.png',
                                // do a height and width
                                height: 50,
                                width: 50,
                              ),
                              Text(
                                '${globalController.fetchedWeatherHumidity.value}%',
                                style: TextStyle(
                                  color: const Color(
                                      0xFF19C3FB), // Hexadecimal color value
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      Text('Comfort level',
                          style: TextStyle(fontSize: 25, color: Colors.white)),
                      SizedBox(height: 20),
                      SleekCircularSlider(
                        min: 0,
                        max: 100,
                        initialValue: double.parse(
                            globalController.fetchedWeatherHumidity.value),
                        appearance: CircularSliderAppearance(
                          infoProperties: InfoProperties(
                            bottomLabelText: 'Humidity',
                            bottomLabelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                            ),
                          ),
                          animationEnabled: true,
                          size: 140,
                          customWidths: CustomSliderWidths(
                            handlerSize: 0,
                            trackWidth: 12,
                            progressBarWidth: 12,
                          ),
                          customColors: CustomSliderColors(
                            hideShadow: true,
                            trackColor: Color.fromARGB(255, 255, 255, 255)
                                .withAlpha(100),
                            progressBarColors: [
                              Color.fromARGB(255, 255, 255, 255),
                              Color.fromARGB(255, 255, 255, 255)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
