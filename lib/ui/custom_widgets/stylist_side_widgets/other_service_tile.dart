import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';

class OtherServiceTile extends StatelessWidget {
  final VoidCallback? action;
  const OtherServiceTile({Key? key, this.action}) : super(key: key);

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
                    StyldImages.addOtherIcon,
                    height: 40.h,
                  )),
              SizedBox(
                width: 10.w,
              ),
              Text(
                'Add Custom',
                style: r_16_gld,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            child: InkWell(
                onTap: action, child: SvgPicture.asset(StyldImages.pencilIcon)),
          ),
        ],
      ),
    );
  }
}
