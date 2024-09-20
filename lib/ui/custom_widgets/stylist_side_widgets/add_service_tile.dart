import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';

class AddServiceTile extends StatelessWidget {
  final bool value;
  final String icon;
  final String title;
  final Function(bool?)? action;
  const AddServiceTile(
      {Key? key,
      this.action,
      required this.value,
      required this.icon,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: StyldColors.lightGrey.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(6.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: StyldColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    icon,
                    height: 40.h,
                  )),
              SizedBox(
                width: 10.w,
              ),
              Text(
                title,
                style: r_16_gld,
              ),
            ],
          ),
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.all(StyldColors.darkGold),
            value: value,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            onChanged: action,
          ),
        ],
      ),
    );
  }
}
