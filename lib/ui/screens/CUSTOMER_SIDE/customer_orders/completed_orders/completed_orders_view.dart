import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/ui/custom_widgets/schedule_order_tile.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_orders/customer_upcoming_orders/upcoming_order_breakdown.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_orders/order_view_model.dart';

class CompletedOrderReview extends StatelessWidget {
  final OrderViewModel model;
  CompletedOrderReview(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: model.completedBookings.isNotEmpty
            ? ListView.builder(
                itemCount: model.completedBookings.length,
                itemBuilder: (context, index) {
                  return ScheduleOrderTile(
                      onPressAction: () => Get.to(() => UpcomingOrdersBreakdown(
                          model.completedBookings[index],
                          isCompleted: true)),
                      booking: model.completedBookings[index]);
                })
            : Center(
                child: Text('No completed appointments found',
                    style:
                        TextStyle(color: StyldColors.white, fontSize: 16.sp))),
      ),
    ]);
  }
}
