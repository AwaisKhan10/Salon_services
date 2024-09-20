import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';

class CheckOutWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final VoidCallback? action;
  final String? picture;

  const CheckOutWidget(
      {Key? key,
      this.action,
      required this.text1,
      required this.text2,
      this.picture,
      required this.text3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text1,
              style: GoogleFonts.roboto(textStyle: b_14_g),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              text2,
              style: GoogleFonts.roboto(textStyle: b_16),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              text3,
              style: GoogleFonts.roboto(textStyle: b_12),
            ),
          ],
        ),
        picture != null
            ? Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: StyldColors.black,
                    foregroundColor: StyldColors.black,
                    backgroundImage: NetworkImage(picture!),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                      onTap: action ?? () {},
                      child: SvgPicture.asset(StyldImages.nextIcon)),
                ],
              )
            : InkWell(
                onTap: action ?? () {},
                child: SvgPicture.asset(StyldImages.nextIcon)),
      ],
    );
  }
}
