import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/model/booking.dart';
import 'package:styld_stylist/ui/custom_widgets/circle_image_placeholder.dart';
import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/payment_section/payment_view_model.dart';
import 'add_payment_view.dart';

class OrderConfirmDetailsView extends StatefulWidget {
  final Booking booking;
  OrderConfirmDetailsView(this.booking);

  @override
  State<OrderConfirmDetailsView> createState() =>
      _OrderConfirmDetailsViewState();
}

class _OrderConfirmDetailsViewState extends State<OrderConfirmDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: StyldColors.black,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: SvgPicture.asset(StyldImages.backIcon),
            ),
            title: Text(
              'Select Date & Time',
              style: GoogleFonts.roboto(textStyle: r_16),
            ),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            child: CustomScrollableView(
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      StyldImages.timeline3Icon,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  //OrderDetailWidget(scheduleOrderModel: scheduleOrderLists[1]),
                  bookingDetailContainer(widget.booking, model),
                  // OrderDetailsScreen(scheduleOrderModel: scheduleOrderLists[1]),
                  SizedBox(
                    height: 45.h,
                  ),

                  WidthButton(
                      action: () => Get.to(() => AddPaymentView(widget.booking)),
                      buttonColor: StyldColors.lightGold,
                      buttonColor2: StyldColors.darkGold,
                      titleText: 'Proceed to Payment',
                      width: 356.w),
                  SizedBox(
                    height: 5.h,
                  ),

                  // const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bookingDetailContainer(Booking booking, PaymentViewModel model) {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: StyldColors.blue,
          ),
          // height: 392.h,
          // width: 356.w,
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              CircleImagePlaceholder(
                radius: 40,
                backgroundImage: NetworkImage(booking.stylistUser!.imgUrl!),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                '${model.authService.bookingStylist.fullName}',
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
                    '${model.authService.bookingStylist.address}',
                    style: GoogleFonts.roboto(textStyle: o3),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(StyldImages.smCalendarIcon),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text('${booking.month} ${booking.date}',
                                    style: GoogleFonts.roboto(textStyle: r_10)),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(StyldImages.smTimeIcon),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text('${booking.timeSlot}',
                                    style: GoogleFonts.roboto(textStyle: r_10)),
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
                            Text('1hr & 30 Min',
                                style: GoogleFonts.roboto(textStyle: r_10)),
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
                          "\$ ${booking.price}",
                          style: GoogleFonts.roboto(textStyle: r_18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
