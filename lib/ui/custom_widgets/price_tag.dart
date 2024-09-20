import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';

class PriceTag extends StatelessWidget {
  const PriceTag(
      {Key? key, required this.packageName, required this.packagePrice})
      : super(key: key);
  final String packageName;
  final String packagePrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5.w),
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      height: 25.h,
      decoration: BoxDecoration(
          color: StyldColors.grey, borderRadius: BorderRadius.circular(2.0)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              packageName,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 8.sp,
                  color: StyldColors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              packagePrice,
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                fontSize: 12.sp,
                color: StyldColors.gold,
                fontWeight: FontWeight.w800,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
