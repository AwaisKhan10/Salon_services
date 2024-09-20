import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/locator.dart';
import 'package:styld_stylist/ui/custom_widgets/left_nexticon.dart';
import 'package:styld_stylist/ui/custom_widgets/stylist_side_widgets/account_settings_tile.dart';
import 'package:styld_stylist/ui/screens/SELECTION_SIDE/selection_screen.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/accountScreen/account/account_view_model.dart';
import '../../../CUSTOMER_SIDE/payment_section/select_payment_options_view.dart';
import '../account_settings/account_setting_screen.dart';
import '../notification_setting/notification_settings_view.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AccountViewModel(),
      child: Consumer<AccountViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: StyldColors.black,
              elevation: 0.0,
              title: Text(
                'Account',
                style: GoogleFonts.roboto(textStyle: r_18),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30.w),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 45.h,
                        backgroundColor: StyldColors.black,
                        foregroundColor: StyldColors.black,
                        backgroundImage: NetworkImage(
                            locator<AuthService>().stylistUser!.imgUrl!),
                        // const AssetImage(StyldImages.femaleImage),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            '${model.authService.stylistUser!.fullName}',
                            style: GoogleFonts.roboto(textStyle: buttonStyle),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            '${model.authService.stylistUser!.email}',
                            style: GoogleFonts.roboto(textStyle: r_16_g),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      // height: 313.h,
                      // width: 270.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: StyldColors.blue,
                      ),
                      child: Column(
                        children: [
                          AccountSettingsTile(
                              action: () async {
                                model.authService.stylistUser = await Get.to(
                                        () => const AccountSettingScreen()) ??
                                    model.authService.stylistUser;
                              },
                              iconPath: StyldImages.accountSettingsIcon,
                              title: 'Account Settings'),
                          AccountSettingsTile(
                              action: () =>
                                  Get.to(() => NotificationSettingsView()),
                              iconPath: StyldImages.notificationSettingIcon,
                              title: 'Manage Notifications Settings'),
                          AccountSettingsTile(
                              action: () {},
                              iconPath: StyldImages.recentAppointmentsIcon,
                              title: 'Recent Appointments'),
                          AccountSettingsTile(
                              action: () { 
                                 Get.to( () => SelectPaymentMethodView());
                                },
                              iconPath: StyldImages.paymentIcon,
                              title: 'Payments and Pricing'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    LeftNextIconButton(
                        action: () {
                          locator<AuthService>().logout();
                          Get.offAll(() => SelectionScreen());
                        },
                        icon: StyldImages.logoutIcon,
                        title: 'Log Out'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
