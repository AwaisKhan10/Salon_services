import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';

class ServicesTile extends StatelessWidget {
  final String title;
  final VoidCallback? action;
  final String imagePath;
  const ServicesTile(
      {Key? key, required this.imagePath, required this.title, this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action ?? () {},
      child: Container(
        height: 65.h,
        width: 153.w,
        // constraints: BoxC
        //onstraints(maxWidth: 153.),
        margin: EdgeInsets.only(right: 10.w),
        // padding: EdgeInsets.symmetric(
        //     horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(imagePath),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.10), BlendMode.darken),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style:
                GoogleFonts.roboto(textStyle: b_20, color: StyldColors.black),
          ),
        ),
      ),
    );
  }
}
