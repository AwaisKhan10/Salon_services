import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';

class NextButton extends StatelessWidget {
  final String title;
  final VoidCallback action;
  const NextButton({Key? key, required this.title, required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        height: 50.h,
        width: 356.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: StyldColors.lightGold,
        ),
        child: Center(
          child: Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(textStyle: buttonStyle),
          ),
        ),
      ),
    );
  }
}
