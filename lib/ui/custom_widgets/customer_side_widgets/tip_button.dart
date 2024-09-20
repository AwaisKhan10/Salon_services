import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';

class TipButton extends StatelessWidget {
  final ValueNotifier value;
  final String price;
  final String iconPath;
  const TipButton(
      {Key? key,
      required this.value,
      required this.iconPath,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: value,
      builder: (context, hasError, child) {
        return InkWell(
          onTap: () {
            value.value = !value.value;
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            height: 45.h,
            width: 45.h,
            decoration: BoxDecoration(
              color: value.value ? StyldColors.lightGold : StyldColors.blue,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconPath,
                  color: value.value ? StyldColors.black : StyldColors.white,
                ),
                Text(
                  '\$ $price',
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                    fontSize: 18.sp,
                    color: value.value ? StyldColors.black : StyldColors.white,
                    fontWeight: FontWeight.w500,
                  )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
