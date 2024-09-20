import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/ui/custom_widgets/dialog_button.dart';
import 'package:styld_stylist/ui/custom_widgets/stylist_side_widgets/approval_button.dart';
import 'stylist_order_view_model.dart';

class PendingStylistView extends StatelessWidget {
  final StylistOrderViewModel model;
  PendingStylistView(this.model);
  bool pending = true;

  Future<void> _showDeleteBlockUserDialog(
      context, onPress, String title) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            elevation: 1.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: IntrinsicWidth(
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        '$title Appointment',
                        style: GoogleFonts.roboto(textStyle: mediumTitle),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Are you sure to ${title.toLowerCase()} the appointment?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(textStyle: regularBlack),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: DialogButton(
                              buttonColor: StyldColors.grey,
                              titleText: 'Cancel',
                              action: () => Get.back(),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Flexible(
                            child: DialogButton(
                              buttonColor: StyldColors.pink,
                              titleText: 'Yes',
                              action: onPress,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StylistOrderViewModel>(builder: (context, model, child) {
      return Column(children: [
        // StylistOrderApprovalTile(orderApproval: stylistOrderApprovalList[0]),

        Expanded(
          child: model.pendingBookings.isNotEmpty
              ? ListView.builder(
                  itemCount: model.pendingBookings.length,
                  itemBuilder: (context, index) {
                    return pendingOrdersTile(model, index, context);
                  })
              : Center(
                  child: Text('No pending appointments found',
                      style: TextStyle(
                          color: StyldColors.white, fontSize: 16.sp))),
        ),
      ]);
    });
  }

  pendingOrdersTile(StylistOrderViewModel model, int index, context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      // height: 230.h,
      // width: 356.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: StyldColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                model.pendingBookings[index].customerUser!.imageUrl == null
                    ? CircleAvatar(
                        radius: 30.h,
                        backgroundColor: StyldColors.blue,
                        foregroundColor: StyldColors.blue,
                        backgroundImage: AssetImage('$staticAsset/profile.png'),
                      )
                    : CircleAvatar(
                        radius: 30.h,
                        backgroundColor: StyldColors.blue,
                        foregroundColor: StyldColors.blue,
                        backgroundImage: NetworkImage(model
                            .pendingBookings[index].customerUser!.imageUrl!),
                      ),
                SizedBox(width: 10.w),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,

                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model.pendingBookings[index].customerUser!.name}',
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: 18.sp,
                                color: StyldColors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '${model.pendingBookings[index].customerUser!.phoneNumber}',
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: 15.sp, color: StyldColors.grey)),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Text(
                          'Appointment On',
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 8.sp,
                              color: StyldColors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        height: 22.h,
                        width: 125.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: StyldColors.blue,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(StyldImages.smCalendarIcon),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    '${model.pendingBookings[index].month} ${model.pendingBookings[index].date}',
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        fontSize: 7.sp,
                                        color: StyldColors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(StyldImages.smTimeIcon),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    '${model.pendingBookings[index].timeSlot}',
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        fontSize: 7.sp,
                                        color: StyldColors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Center(
                            child: Text(
                              'Duration',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 8.sp,
                                  color: StyldColors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              height: 22.h,
                              width: 75.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.0),
                                color: StyldColors.blue,
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                        StyldImages.smCalendarIcon),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      '1hr & 30 Min',
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                          fontSize: 7.sp,
                                          color: StyldColors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Services',
                  style: GoogleFonts.roboto(textStyle: r_9_g),
                ),
                Container(
                  height: 15.h,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: model.pendingBookings[index].services.length,
                      itemBuilder: (context, i) {
                        return Text(
                          '${model.pendingBookings[index].services[i]}',
                          style: GoogleFonts.roboto(textStyle: m_9_b),
                        );
                      }),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price',
                  style: GoogleFonts.roboto(textStyle: r_9_g),
                ),
                Text(
                  '\$ ${model.pendingBookings[index].price}',
                  style: GoogleFonts.roboto(textStyle: m_9_b),
                ),
              ],
            ),
            const Divider(thickness: 1.5, color: StyldColors.lightGrey),
            Row(
              children: [
                SvgPicture.asset(StyldImages.locationPointerSmall,
                    color: StyldColors.lightGold),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '${model.pendingBookings[index].customerAddress}',
                  style: GoogleFonts.roboto(textStyle: r_10_b),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ApprovalButtonColor(
                  color: StyldColors.grey.withOpacity(0.35),
                  title: 'Decline',
                  isBlack: true,
                  action: () => _showDeleteBlockUserDialog(context, () {
                        model.declineBooking(model.pendingBookings[index]);
                      }, 'Decline')),
              ApprovalButtonColor(
                  isBlack: false,
                  color: StyldColors.lightGold,
                  title: 'Approve',
                  action: () => _showDeleteBlockUserDialog(context, () {
                        model.approveBooking(model.pendingBookings[index]);
                      }, 'Approve')),
            ]),
          ],
        ),
      ),
    );
  }
}
