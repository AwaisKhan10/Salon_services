import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:styld_stylist/core/constants/colors.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final onEdit;
  final onDelete;
  final image;
  FullScreenImage({required this.imageUrl, this.onEdit, this.onDelete, this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(Icons.keyboard_arrow_left, color: StyldColors.darkGold),
                      onPressed: () => Get.back()),
                 
                ],
              ),
              // SizedBox(height: 30.h),
              Expanded(
                child: PhotoView(
                  imageProvider: NetworkImage(imageUrl),
                ) 
              ),
            ],
          )),
    );
  }
}