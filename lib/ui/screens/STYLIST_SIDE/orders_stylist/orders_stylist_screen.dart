import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/orders_stylist/completed_booking.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/orders_stylist/pending_stylist_view.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/orders_stylist/stylist_order_view_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'schedule_orders_view.dart';

class StylistOrderScreen extends StatelessWidget {
  const StylistOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StylistOrderViewModel(),
      child: Consumer<StylistOrderViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: StyldColors.black,
                  elevation: 0.0,
                  title: Text(
                    'Orders',
                    style: GoogleFonts.roboto(textStyle: r_18),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(StyldImages.backIcon),
                  ),
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
                          child: const TabBar(
                            indicatorColor: StyldColors.gold,
                            tabs: [
                              Tab(
                                text: "Scheduled",
                              ),
                              Tab(
                                text: "Pending",
                              ),
                              Tab(
                                text: "Completed",
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 10.h),
                            child: TabBarView(
                              physics: BouncingScrollPhysics(),
                              children: [
                                ScheduleOrderView(model),
                                PendingStylistView(model),
                                CompletedBookings(model),
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
