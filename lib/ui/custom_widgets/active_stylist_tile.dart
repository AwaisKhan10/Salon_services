import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/model/active_stylist_model.dart';

class ActiveStylistTile extends StatelessWidget {
  final ActiveStylistModel activeStylist;
  final VoidCallback? onPressAction;
  const ActiveStylistTile({
    Key? key,
    required this.activeStylist,
    this.onPressAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressAction ?? () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        height: 130.h,
        width: 356.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.0),
          color: StyldColors.blue,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30.h,
                    backgroundColor: StyldColors.blue,
                    foregroundColor: StyldColors.blue,
                    backgroundImage: AssetImage(activeStylist.imageUrl),
                  ),
                  SizedBox(width: 10.w),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activeStylist.title,
                          style: GoogleFonts.roboto(textStyle: headerText),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(StyldImages.locationPointerSmall),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              activeStylist.address,
                              style: GoogleFonts.roboto(textStyle: o3),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(StyldImages.starIcon),
                    SizedBox(width: 5.w),
                    SvgPicture.asset(StyldImages.starIcon),
                    SizedBox(width: 5.w),
                    SvgPicture.asset(StyldImages.starIcon),
                    SizedBox(width: 5.w),
                    SvgPicture.asset(StyldImages.starIcon),
                    SizedBox(width: 5.w),
                    SvgPicture.asset(StyldImages.starIcon),
                    SizedBox(width: 5.w),
                    Text(
                      activeStylist.rating,
                      style: GoogleFonts.roboto(textStyle: h0B),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
