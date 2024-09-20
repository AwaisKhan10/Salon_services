import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/notifications/stylist_notification_view_model.dart';

class StylistNotificaitonScreen extends StatelessWidget {
  StylistNotificaitonScreen({Key? key}) : super(key: key);

  final List<String> _settings = [
    'All Notification',
    'Appointments Notification',
    'Reminders',
    'Booking & Payments',
    'New Services',
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StylistNotificationViewModel(),
      child: Consumer<StylistNotificationViewModel>(
          builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: StyldColors.black,
              elevation: 0.0,
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: SvgPicture.asset(StyldImages.backIcon),
              ),
              title: Text(
                'Notification',
                style: GoogleFonts.roboto(textStyle: m_18),
              ),
              centerTitle: true,
            ),
            body: Container(
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                        // height: MediaQuery.of(context).size.height * 0.84,
                        child: model.notificaiton.isEmpty
                            ? Center(
                                child: Text('Notifications empty',
                                    style: TextStyle(
                                        color: StyldColors.white,
                                        fontSize: 16.sp)))
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 0.h),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    // height: 80.h,
                                    decoration: BoxDecoration(
                                      // color: StyldColors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: ListTile(
                                      leading: Container(
                                        // width: 80.w,
                                        // height: 80.w,
                                        decoration: BoxDecoration(
                                          color: StyldColors.blue,
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                        ),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: SvgPicture.asset(StyldImages
                                              .bookingNotificationIcon),
                                        ),
                                      ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${model.notificaiton[index].title}',
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                fontSize: 12.sp,
                                                color: StyldColors.lightGrey,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${model.notificaiton[index].text}',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 12.sp,
                                                color: StyldColors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                        '11 minutes ago',
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 12.sp,
                                            color: StyldColors.lightGrey,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                    ),
                                    child: const Divider(
                                        thickness: 1.0,
                                        color: StyldColors.white),
                                  );
                                },
                                itemCount: model.notificaiton.length)),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
