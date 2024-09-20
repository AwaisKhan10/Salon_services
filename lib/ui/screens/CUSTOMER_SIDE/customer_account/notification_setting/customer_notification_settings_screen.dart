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
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_account/notification_setting/notification_sertting_view_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CustomerNotificationsSettingsScreen extends StatefulWidget {
  @override
  State<CustomerNotificationsSettingsScreen> createState() =>
      _CustomerNotificationsSettingsScreenState();
}

class _CustomerNotificationsSettingsScreenState
    extends State<CustomerNotificationsSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomerNotificationSettingViewModel(),
      child: Consumer<CustomerNotificationSettingViewModel>(
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
                  style: GoogleFonts.roboto(textStyle: r_16),
                ),
                centerTitle: true,
              ),
              body: Container(
                margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SafeArea(
                  ///
                  /// Toggle notification area
                  ///
                  child: Column(
                    children: [
                      notificationTile((val) {
                        setState(() {
                          model.stylistNotification!.allNotification =
                              !model.stylistNotification!.allNotification!;
                          if (model.stylistNotification!.allNotification!) {
                            model.stylistNotification!.appointments = true;
                            model.stylistNotification!.reminders = true;
                            model.stylistNotification!.bookingAndAppont = true;
                            model.stylistNotification!.newService = true;
                          } else {
                            model.stylistNotification!.appointments = false;
                            model.stylistNotification!.reminders = false;
                            model.stylistNotification!.bookingAndAppont = false;
                            model.stylistNotification!.newService = false;
                          }
                          model.updateNotificaitons();
                        });
                      }, 'All Notification',
                          model.stylistNotification!.allNotification!),
                      notificationTile((val) {
                        setState(() {
                          model.stylistNotification!.appointments =
                              !model.stylistNotification!.appointments!;
                          model.updateNotificaitons();
                        });
                      }, 'Appointments Notification',
                          model.stylistNotification!.appointments!),
                      notificationTile((val) {
                        setState(() {
                          model.stylistNotification!.reminders =
                              !model.stylistNotification!.reminders!;
                          model.updateNotificaitons();
                        });
                      }, 'Reminders', model.stylistNotification!.reminders!),
                      notificationTile((val) {
                        setState(() {
                          model.stylistNotification!.bookingAndAppont =
                              !model.stylistNotification!.bookingAndAppont!;
                          model.updateNotificaitons();
                        });
                      }, 'Booking & Payments',
                          model.stylistNotification!.bookingAndAppont!),
                      notificationTile((val) {
                        setState(() {
                          model.stylistNotification!.newService =
                              !model.stylistNotification!.newService!;
                          model.updateNotificaitons();
                        });
                      }, 'New Services',
                          model.stylistNotification!.newService!),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget notificationTile(onTap, String title, bool isSwitchedOn) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      height: 50.h,
      decoration: BoxDecoration(
        color: StyldColors.blue,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        leading: Text(title, style: GoogleFonts.roboto(textStyle: r_18)),
        trailing: Switch(
          value: isSwitchedOn,
          onChanged: onTap,
          activeTrackColor: StyldColors.lightGold,
          activeColor: const Color(0xFF5B6680),
          inactiveTrackColor: StyldColors.white,
          inactiveThumbColor: const Color(0xFF5B6680),
        ),
      ),
    );
  }
}
