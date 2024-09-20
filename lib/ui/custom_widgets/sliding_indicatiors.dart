import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/constants/colors.dart';

class SlidingIndicationDots extends StatelessWidget {
  final int? index;
  final int? currentImage;
  final double height;
  final double width;
  final Color fillColor;
  final Color borderColor;

  SlidingIndicationDots(
      {this.index,
      this.currentImage,
      this.height = 10,
      this.width = 10,
      this.fillColor = Colors.white,
      this.borderColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        index == currentImage
            ? Container(
                height: 13.h,
                width: 13.w,
                decoration: BoxDecoration(
                    color: StyldColors.lightGold, shape: BoxShape.circle),
              )
            : Container(
                height: height.h,
                width: width.w,
                decoration: BoxDecoration(
                    color: StyldColors.white, shape: BoxShape.circle)),
        SizedBox(width: 13.w),
      ],
    );
  }
}
