import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styld_stylist/ui/screens/splash_screen.dart';

class NetworkErrorDialog extends StatelessWidget {
  const NetworkErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Network error'),
      content: Text('Please connect your device to internet'),
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back();
              Get.offAll(SplashScreen());
            },
            child: Text(
              "OK",
              style: TextStyle(fontSize: 14),
            ))
      ],
    );
  }
}
