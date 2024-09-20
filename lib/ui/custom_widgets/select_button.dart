import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';

class SelectButton extends StatelessWidget {
  final bool isActive;
  final String title;
  final VoidCallback action;
  const SelectButton(
      {Key? key,
      required this.isActive,
      required this.title,
      required this.action})
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
          color: isActive
              ? StyldColors.lightGold
              : StyldColors.lightGold.withOpacity(0.55),
        ),
        child: Center(
          child: isActive
              ? Container(
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
                          child: SvgPicture.asset(StyldImages.selectionIcon)),
                    ],
                  ),
                )
              : Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(textStyle: buttonStyle),
                ),
        ),
      ),
    );
  }
}
