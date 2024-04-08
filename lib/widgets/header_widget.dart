import 'package:get/get.dart'; // Import Get package for state management
import 'package:weatherapp/controller/global_controller.dart'; // Import GlobalController for accessing global app state
import 'package:flutter/material.dart'; // Import Flutter material library
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

// Define a stateful widget for the header of the app


class HeaderWidget extends StatelessWidget {

   HeaderWidget({super.key});

  // Initialize GlobalController for accessing global app state
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);



  // Method to fetch the address based on latitude and longitude
  
  @override
  Widget build(BuildContext context) {
   

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
                        globalController.city.value + "," + globalController.state.value,
                        style:  TextStyle(
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
                              text: '   ${globalController.formattedDate}',
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
                const SizedBox(
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
                      padding: const EdgeInsets.only(top: 30.0, right: 40, left: 40),
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
                                style: const TextStyle(
                                  color: Color(
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
                                style: const TextStyle(
                                  color: Color(
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
                                style: const TextStyle(
                                  color: Color(
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
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      const Text('Comfort level',
                          style: TextStyle(fontSize: 25, color: Colors.white)),
                      const SizedBox(height: 20),
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
                            trackColor: const Color.fromARGB(255, 255, 255, 255)
                                .withAlpha(100),
                            progressBarColors: [
                              const Color.fromARGB(255, 255, 255, 255),
                              const Color.fromARGB(255, 255, 255, 255)
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
