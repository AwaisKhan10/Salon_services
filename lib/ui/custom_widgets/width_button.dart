import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';

class WidthButton extends StatelessWidget {
  final VoidCallback? action;
  final String titleText;
  final Color? textColor;
  final double? height;

  final Color buttonColor;
  final Color? buttonColor2;

  final double width;
  const WidthButton(
      {Key? key,
      this.action,
      this.height,
      this.buttonColor2,
      required this.buttonColor,
      required this.titleText,
      this.textColor,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action ?? () {},
      child: Container(
          height: height ?? 50.h,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                buttonColor,
                buttonColor2 ?? buttonColor,
              ],
            ),
            // color: buttonColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Center(
            child: Text(
              titleText,
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                fontSize: 18.sp,
                color: textColor ?? StyldColors.white,
                fontWeight: FontWeight.w500,
              )),
            ),
          )),
    );
  }
}
