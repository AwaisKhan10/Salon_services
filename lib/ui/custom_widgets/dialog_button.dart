import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';

class DialogButton extends StatelessWidget {
  final VoidCallback? action;
  final String titleText;
  final Color buttonColor;
  const DialogButton(
      {Key? key,
      this.action,
      required this.buttonColor,
      required this.titleText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action ?? () {},
      child: Container(
          height: 50.h,
          width: 168.w,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Center(
            child: Text(
              titleText,
              style: GoogleFonts.roboto(textStyle: buttonStyle),
            ),
          )),
    );
  }
}
