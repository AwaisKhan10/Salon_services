import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/model/customer_side_models/complete_order_model.dart';

class CompleteOrderTile extends StatelessWidget {
  final CompleteOrderModel completeOrder;
  final VoidCallback? onPressAction;
  const CompleteOrderTile({
    Key? key,
    required this.completeOrder,
    this.onPressAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressAction ?? () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        height: 120.h,
        width: 356.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: StyldColors.blue,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    backgroundImage: AssetImage(completeOrder.path),
                  ),
                  SizedBox(width: 10.w),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          completeOrder.name,
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
                              completeOrder.address,
                              style: GoogleFonts.roboto(textStyle: o3),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      width: 163.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: StyldColors.lightGrey,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(StyldImages.smCalendarIcon),
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(completeOrder.date,
                                  style: GoogleFonts.roboto(textStyle: r_10)),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(StyldImages.smTimeIcon),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(completeOrder.time,
                                  style: GoogleFonts.roboto(textStyle: r_10)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      width: 163.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: StyldColors.lightGold,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            StyldImages.bookingNotificationIcon,
                            color: StyldColors.white,
                            height: 12.64.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text("Completed",
                              style: GoogleFonts.roboto(textStyle: r_14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
