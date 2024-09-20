import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_orders/order_view_model.dart';
import 'completed_orders/completed_orders_view.dart';
import 'customer_upcoming_orders/upcoming_orders_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OrdersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderViewModel(),
      child: Consumer<OrderViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: StyldColors.black,
                  elevation: 0.0,
                  title: Text(
                    'Orders',
                    style: GoogleFonts.roboto(textStyle: r_18),
                  ),
                  centerTitle: true,
                ),
                body: SafeArea(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.w),
                          height: 50.h,
                          child: TabBar(
                            indicatorColor: StyldColors.gold,
                            indicatorWeight: 4,
                            indicatorPadding:
                                EdgeInsets.symmetric(horizontal: 30.w),
                            tabs: [
                              Tab(
                                child: Container(
                                  width: 150,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [
                                        StyldColors.lightGold,
                                        StyldColors.darkGold,
                                      ],
                                    ),
                                    // color: buttonColor,
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        StyldImages.processBookingIcon,
                                        height: 15.82.h,
                                        color: StyldColors.white,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        'Upcoming',
                                        style:
                                            GoogleFonts.roboto(textStyle: b_18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  width: 150,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [
                                        StyldColors.lightGold,
                                        StyldColors.darkGold,
                                      ],
                                    ),
                                    // color: buttonColor,
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        StyldImages.bookingNotificationIcon,
                                        height: 15.82.h,
                                        color: StyldColors.white,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        'Completed',
                                        style:
                                            GoogleFonts.roboto(textStyle: b_18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 10.h),
                            child: TabBarView(
                              children: [
                                UpcomingOrdersView(model),
                                CompletedOrderReview(model),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
