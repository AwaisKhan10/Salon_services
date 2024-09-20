import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/model/tag_model.dart';

class BeautySaloonTile extends StatelessWidget {
  final Services service;
  BeautySaloonTile(this.service);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 70,
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(service.imagePath!),
              ),
            ),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 5.h),
                  Text(
                    service.name,
                    style: GoogleFonts.roboto(textStyle: b_16),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'Top services by Stylists',
                    style: GoogleFonts.roboto(textStyle: r_14),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      SvgPicture.asset(StyldImages.locationPointerSmall),
                      SizedBox(
                        width: 5.w,
                      ),
                      Flexible(
                        child: Text(
                          'Available everywhere you can choose by your ease',
                          style: GoogleFonts.roboto(textStyle: r_11_g),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: const Divider(
                      thickness: 1.0,
                      color: StyldColors.lightGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}