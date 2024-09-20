import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/ui/custom_widgets/stylist_schedule_order_tile.dart';
import 'package:get/get.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/orders_stylist/booking_details/booking_detail_screen.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/orders_stylist/stylist_order_view_model.dart';

class ScheduleOrderView extends StatelessWidget {
  final StylistOrderViewModel model;
  ScheduleOrderView(this.model);

  bool scheduled = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<StylistOrderViewModel>(builder: (context, model, child) {
      return Column(children: [
        Expanded(
          child: model.scheduledBookings.isNotEmpty
              ? ListView.builder(
                  itemCount: model.scheduledBookings.length,
                  itemBuilder: (context, index) {
                    return StylistScheduleOrderTile(
                      onPressAction: () => Get.to(
                        () => StylistBookingDetailScreen(
                          model.scheduledBookings[index],
                          onPress: () {
                            model.markCompleted(model.scheduledBookings[index]);
                          },
                        ),
                      ),
                      booking: model.scheduledBookings[index],
                    );
                  })
              : Center(
                  child: Text('No Scheduled appointments found',
                      style: TextStyle(
                          color: StyldColors.white, fontSize: 16.sp))),
        ),
      ]);
    });
  }
}
