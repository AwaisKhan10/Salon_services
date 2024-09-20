import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';

class LeftWidthButton extends StatelessWidget {
  final String title;
  final Color? color;
  final Color? textColor;
  final double? width;
  final VoidCallback action;
  final String icon;
  const LeftWidthButton(
      {Key? key,
      required this.action,
      this.width,
      this.textColor,
      required this.icon,
      required this.title,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 45.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w),

        height: 50.h,
        width: width ?? 156.w,

        // width: width ?? 356.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: color ?? StyldColors.lightGold,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(icon),
              SizedBox(width: 15.w),
              Text(
                title,
                // textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 18.sp,
                    color: textColor ?? StyldColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
