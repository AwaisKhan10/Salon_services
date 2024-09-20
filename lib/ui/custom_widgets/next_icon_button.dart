import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';

class NextIconButton extends StatelessWidget {
  final String title;
  final VoidCallback action;
  final String icon;
  const NextIconButton(
      {Key? key, required this.action, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.w),
        height: 50.h,
        width: 356.w,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              StyldColors.lightGold,
              StyldColors.darkGold,
            ],
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Container(),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(textStyle: buttonStyle),
                ),
                Container(
                    margin: EdgeInsets.only(left: 50.w),
                    child: SvgPicture.asset(icon)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
