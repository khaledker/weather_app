import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/controller/global_controller.dart';
import 'package:weatherapp/widgets/header_widget.dart';


class HomePage extends StatelessWidget {
     HomePage({Key? key   }) : super(key: key);

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Ensure that the child is placed within the safe area of the screen
        child: Obx(() {
          // Use Obx widget to listen to changes in observable variables
          return globalController.checkLoading().isTrue
              // Check if loading is true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              // If loading is true, display a centered widget (e.g., loading indicator)
              :  HeaderWidget(); // If loading is false, display the HeaderWidget
        }),
      ) 
    );
  }
}
