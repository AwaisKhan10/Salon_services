import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';

// ignore: must_be_immutable
class ExpandableContainer extends StatelessWidget {
  final String title;
  final String about;
  const ExpandableContainer(
      {Key? key, required this.title, required this.about})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(textStyle: r_14),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: StyldColors.blue,
            ),
            width: MediaQuery.of(context).size.width * 0.85,
            child: Text(
              about,
              style: GoogleFonts.roboto(textStyle: r_13),
            ),
          ),
        ],
      ),
    );
  }
}
