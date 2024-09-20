import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';

class BigCheckoutRow extends StatelessWidget {
  final double? fontSize;
  final String text1;
  final String text2;

  const BigCheckoutRow(
      {Key? key, this.fontSize, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
              fontSize: fontSize ?? 14.sp,
              color: StyldColors.white,
              fontWeight: FontWeight.w700,
            )),
          ),
          Text(
            '$text2 \$',
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
              fontSize: fontSize ?? 12.sp,
              color: StyldColors.white,
              fontWeight: FontWeight.w700,
            )),
          ),
        ],
      ),
    );
  }
}
