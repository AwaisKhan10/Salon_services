import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/providers/time_slots_available.dart';
import 'package:styld_stylist/ui/custom_widgets/time_slot/time_slot_widget.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/payment_section/payment_view_model.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/payment_section/select_datetime_view.dart';

class SelectServiceView extends StatefulWidget {
  final String? price;
  SelectServiceView({this.price});
  // final List<ServiceModel> services;
  // SelectServiceView(this.services);

  @override
  State<SelectServiceView> createState() => _SelectServiceViewState();
}

class _SelectServiceViewState extends State<SelectServiceView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentViewModel(),
      child: Consumer<PaymentViewModel>(builder: (context, model, child) {
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
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Center(
                      child: SvgPicture.asset(
                        StyldImages.timeline1Icon,
                      ),
                    ),
                    SizedBox(height: 30.h),

                    ///
                    /// Months and days of stylist user
                    ///
                    monthSelection(model),
                    SizedBox(height: 20.h),

                    ///
                    /// Time slots of stylist user
                    ///

                    Center(
                      child: Text(
                        'Available Time Slot',
                        style: GoogleFonts.roboto(textStyle: b_25),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: model.authService.bookingStylist
                            .availableTimings!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemBuilder: (context, index) {
                          return Consumer<AvailableTimeSlotsStatus>(
                            builder: (context, status, child) {
                              return TimeSlotWidget(
                                  action: () {
                                    model.selectTimeSlot(index);
                                  },
                                  isActive: model.booking.timeSlot ==
                                          model.authService.bookingStylist
                                              .availableTimings![index].time
                                      ? true
                                      : false,
                                  value:
                                      '${model.authService.bookingStylist.availableTimings![index].time}');
                            },
                          );
                        }),

                    ///
                    ///   Services
                    ///
                    Center(
                      child: Text(
                        'Available Services',
                        style: GoogleFonts.roboto(textStyle: b_25),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: model.authService.bookingServices.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 4 / 1.3, crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                model.updateService(index);
                              },
                              child: Container(
                                height: 20.h,
                                decoration: BoxDecoration(
                                    color: model.booking.services.contains(model
                                            .authService
                                            .bookingServices[index]
                                            .title)
                                        ? StyldColors.lightGold
                                        : StyldColors.lightGold
                                            .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(14)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4),
                                child: Center(
                                    child: Row(
                                  children: [
                                    SizedBox(width: 4.w),
                                    SvgPicture.asset(
                                        model.authService.bookingServices[index]
                                            .iconPath,
                                        height: 20.h),
                                    SizedBox(width: 4.w),
                                    Text(model.authService
                                        .bookingServices[index].title),
                                  ],
                                )),
                              ),
                            ),
                          );
                        }),
                  ]),
                  SizedBox(height: 40.h),
                  Column(children: [
                    Container(
                      height: 58.h,
                      // width: 50.w,
                      margin: EdgeInsets.symmetric(horizontal: 25.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: StyldColors.lightGrey,
                      ),
                      child: Center(
                        child: Text(
                          '${model.booking.month} ${model.booking.date}, ${model.booking.timeSlot}',
                          style: GoogleFonts.roboto(textStyle: r_18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    WidthButton(
                        action: () {
                          if (model.currentMonth == DateTime.now().month - 1 &&
                              int.parse(model.booking.date!) <
                                  DateTime.now().day) {
                            Get.snackbar('Date Incorrect',
                                'Please select a valid future date',
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: StyldColors.white);
                          } else {
                            if (model.booking.services.isEmpty) {
                              Get.snackbar('Service Required',
                                  'Please select a service for booking',
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: StyldColors.white);
                            } else {
                              model.booking.customerId =
                                  model.authService.customerUser!.id;
                              model.booking.customerUser =
                                  model.authService.customerUser;
                              model.booking.stylistId =
                                  model.authService.bookingStylist.id;
                              model.booking.stylistUser =
                                  model.authService.bookingStylist;
                              Get.to(() => SelectDateTimeView(model.booking,
                                  price: widget.price));
                            }
                          }
                        },
                        buttonColor: StyldColors.lightGold,
                        buttonColor2: StyldColors.darkGold,
                        titleText: 'Save & Continue',
                        width: 356.w),
                    SizedBox(
                      height: 5.h,
                    ),
                  ])
                  // const Spacer(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  monthSelection(PaymentViewModel model) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                model.updateMonth(false);
              },
              icon: Icon(Icons.keyboard_arrow_left,
                  color: StyldColors.white, size: 40)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${model.months[model.currentMonth]}',
                style: TextStyle(
                    color: StyldColors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold),
              ),
              Text('${DateTime.now().year}',
                  style: TextStyle(
                      color: StyldColors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold))
            ],
          ),
          IconButton(
              onPressed: () {
                model.updateMonth(true);
              },
              icon: Icon(Icons.keyboard_arrow_right,
                  color: StyldColors.white, size: 40))
        ],
      ),
      SizedBox(height: 15.h),
      Container(
          height: 70.h,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: model.totalDays,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 13.0),
                  child: GestureDetector(
                    onTap: () {
                      model.updateDate((model.startDate + index).toString());
                    },
                    child: Container(
                      height: 67.h,
                      width: 67.w,
                      decoration: BoxDecoration(
                          color: int.parse(model.booking.date!) ==
                                  model.startDate + index
                              ? StyldColors.lightGold
                              : Color(0xFF262A34),
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text('${model.startDate + index}',
                            style: TextStyle(
                                color: int.parse(model.booking.date!) ==
                                        model.startDate + index
                                    ? Color(0xFF262A34)
                                    : StyldColors.white,
                                fontSize: 27.sp,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                );
              }))
    ]);
  }
}
