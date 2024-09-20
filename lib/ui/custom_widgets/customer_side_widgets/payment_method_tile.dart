import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';

class PaymentMethodTile extends StatelessWidget {
  final String lastFourDigits;
  final String expiryDate;
  final String cardType;
  final VoidCallback? editAction;
  const PaymentMethodTile(
      {Key? key,
      required this.cardType,
      this.editAction,
      required this.expiryDate,
      required this.lastFourDigits})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),

      height: 62.h,
      // width: 320.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: StyldColors.lightGrey,
      ),
      child: ListTile(
        leading: SvgPicture.asset(cardType),
        title: Text(
          '****  ****  ****  $lastFourDigits',
          maxLines: 1,
          style: GoogleFonts.roboto(
              textStyle: TextStyle(
            fontSize: 15.sp,
            color: StyldColors.white,
            fontWeight: FontWeight.w400,
          )),
        ),
        subtitle: Text(
          'expires on $expiryDate',
          style: GoogleFonts.roboto(
              textStyle: TextStyle(
            fontSize: 13.sp,
            color: StyldColors.white,
            fontWeight: FontWeight.w400,
          )),
        ),
        // trailing: InkWell(
        //   onTap: editAction ?? () {},
        //   child: Container(
        //     height: 34.h,
        //     width: 84.w,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(5.0),
        //       color: StyldColors.lightGold,
        //     ),
        //     child: Center(
        //       child: Text(
        //         'Edit',
        //         style: GoogleFonts.roboto(
        //             textStyle: TextStyle(
        //           fontSize: 13.sp,
        //           color: StyldColors.black,
        //           fontWeight: FontWeight.w400,
        //         )),
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
