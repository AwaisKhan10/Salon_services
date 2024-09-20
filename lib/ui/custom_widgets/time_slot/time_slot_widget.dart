import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';

class TimeSlotWidget extends StatelessWidget {
  const TimeSlotWidget(
      {Key? key, required this.isActive, required this.value, this.action})
      : super(key: key);
  final bool isActive;
  final VoidCallback? action;
  final String value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Column(
        children: [
          Container(
            height: 33.h,
            width: 76.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: isActive ? StyldColors.lightGold : StyldColors.blue,
            ),
            child: Center(
              child: Text(
                value,
                style: isActive
                    ? GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontSize: 13.sp,
                          color: StyldColors.blue,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : TextStyle(
                        fontSize: 13.sp,
                        color: StyldColors.white,
                        fontWeight: FontWeight.w400,
                      ),
              ),
            ),
          ),
          if (isActive)
            SizedBox(
              height: 5.h,
            ),
          if (isActive)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                color: StyldColors.lightGold,
              ),
              height: 5.h,
              width: 48.w,
            ),
        ],
      ),
    );
  }
}
