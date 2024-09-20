import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:get/get.dart';

class RootViewModel extends BaseViewModel {
  ///
  /// Back button dialog
  ///
  Future<bool> onWillPop() async {
    return await Get.dialog(AlertDialog(
      title: Text('Are you sure?',
          style: TextStyle(color: StyldColors.black, fontSize: 18.sp)),
      content: Text("Do you really want to exit this app??",
          style: TextStyle(color: StyldColors.black, fontSize: 16.sp)),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(StyldColors.darkGold)),
          onPressed: () {
            Get.back();
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: StyldColors.black, fontSize: 16.sp),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(StyldColors.darkGold)),
          onPressed: () {
            exit(0);
          },
          child: Text(
            'Ok',
            style: TextStyle(color: StyldColors.black, fontSize: 16.sp),
          ),
        ),
      ],
    ));
  }
}
