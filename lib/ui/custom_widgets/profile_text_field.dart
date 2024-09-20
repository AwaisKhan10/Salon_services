import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';

class ProfileTextField extends StatelessWidget {
  final TextEditingController textController;
  final String title;
  const ProfileTextField(
      {Key? key, required this.textController, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      width: 156.w,
      child: TextField(
        controller: textController,
        style: GoogleFonts.lato(
            textStyle: TextStyle(
          fontSize: 13.sp,
          color: StyldColors.white,
        )),
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: StyldColors.white, width: 1.5)),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: StyldColors.white, width: 1.5)),
          hintText: textController.text,
          hintStyle: GoogleFonts.lato(
              textStyle: TextStyle(
            fontSize: 14.sp,
            color: StyldColors.lightGrey,
          )),
          labelText: title,
          labelStyle: GoogleFonts.lato(
              textStyle: TextStyle(
            fontSize: 13.sp,
            color: StyldColors.lightGrey,
          )),
        ),
      ),
    );
  }
}
