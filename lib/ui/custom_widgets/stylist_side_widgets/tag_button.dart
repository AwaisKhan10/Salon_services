import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TagButton extends StatelessWidget {
  final String tagValue;
  final bool selected;
  final VoidCallback? callback;
  const TagButton(
      {Key? key, required this.tagValue, required this.selected, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.only(right: 5.0),
        constraints: BoxConstraints(
          maxWidth: 120.w,
        ),
        height: 21.h,
        // width: 60,
        decoration: BoxDecoration(
          // border: Border.all(
          //     color: selected ? StyldColors.lightGold : StyldColors.gold),
          borderRadius: BorderRadius.circular(14),
          color: selected
              ? StyldColors.lightGold
              : StyldColors.lightGold.withOpacity(0.6),
        ),
        child: Center(
          child: Text(
            tagValue,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(fontSize: 11.sp, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}



class RegistrationTagButton extends StatelessWidget {
  final String tagValue;
  final bool selected;
  final VoidCallback? callback;
  const RegistrationTagButton(
      {Key? key, required this.tagValue, required this.selected, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: callback,
        child: Container(
          margin: const EdgeInsets.only(right: 5.0),
          constraints: BoxConstraints(
            maxWidth: 120.w,
          ),
          height: 21.h,
          // width: 60,
          decoration: BoxDecoration(
            // border: Border.all(
            //     color: selected ? StyldColors.lightGold : StyldColors.gold),
            borderRadius: BorderRadius.circular(14),
            color: selected
                ? StyldColors.lightGold
                : StyldColors.lightGold.withOpacity(0.6),
          ),
          child: Center(
            child: Text(
              tagValue,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(fontSize: 11.sp, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
