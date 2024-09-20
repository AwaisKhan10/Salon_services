import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/model/schedule_order_model.dart';
import 'package:styld_stylist/ui/custom_widgets/circle_image_placeholder.dart';
import 'package:styld_stylist/ui/custom_widgets/left_nexticon.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/accountScreen/map_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key, required this.scheduleOrderModel})
      : super(key: key);
  final ScheduleOrderModel scheduleOrderModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyldColors.black,
        elevation: 0.0,
        title: Text(
          'Orders',
          style: GoogleFonts.roboto(textStyle: r_18),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(StyldImages.backIcon),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  children: [
                    SvgPicture.asset(StyldImages.scheduleIcon),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      children: [
                        Text(
                          'Scheduled',
                          style: GoogleFonts.roboto(textStyle: b_18),
                        ),
                        SizedBox(height: 3.h),
                        Container(
                          height: 5.h,
                          width: 72.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: StyldColors.lightGold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: StyldColors.blue,
                ),
                height: 392.h,
                width: 356.w,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    CircleImagePlaceholder(
                      radius: 40,
                      backgroundImage: AssetImage(scheduleOrderModel.path),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      scheduleOrderModel.name,
                      style: GoogleFonts.roboto(textStyle: b_18),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(StyldImages.locationPointerSmall),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          scheduleOrderModel.address,
                          style: GoogleFonts.roboto(textStyle: o3),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Appointment on',
                              style: GoogleFonts.roboto(textStyle: m_18),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              width: 163.w,
                              height: 28.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: StyldColors.lightGrey,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          StyldImages.smCalendarIcon),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Text(scheduleOrderModel.date,
                                          style: GoogleFonts.roboto(
                                              textStyle: r_10)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(StyldImages.smTimeIcon),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(scheduleOrderModel.time,
                                          style: GoogleFonts.roboto(
                                              textStyle: r_10)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Duration',
                              style: GoogleFonts.roboto(textStyle: m_18),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              width: 113.w,
                              height: 28.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: StyldColors.lightGrey,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(StyldImages.smTimeIcon),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(scheduleOrderModel.duration,
                                      style:
                                          GoogleFonts.roboto(textStyle: r_10)),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Column(
                      children: [
                        Text(
                          "Total Price",
                          style: GoogleFonts.roboto(textStyle: m_18),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          height: 34.h,
                          width: 98.w,
                          decoration: BoxDecoration(
                            color: StyldColors.grey,
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(StyldImages.priceTagIcon),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "\$ ${scheduleOrderModel.price}",
                                style: GoogleFonts.roboto(textStyle: r_18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    LeftNextIconButton(
                        action: () => Get.to(() => const MapScreen()),
                        icon: StyldImages.mapIcon,
                        title: "View on Map"),
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
