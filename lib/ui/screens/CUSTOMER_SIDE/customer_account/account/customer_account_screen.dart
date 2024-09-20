import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/ui/custom_widgets/left_nexticon.dart';
import 'package:styld_stylist/ui/custom_widgets/stylist_side_widgets/account_settings_tile.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_account/account/customer_account_view_model.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_account/account_setting/customer_account_setting.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/payment_section/select_payment_options_view.dart';
import 'package:styld_stylist/ui/screens/SELECTION_SIDE/selection_screen.dart';
import '../../../../../locator.dart';
import '../customer_all_notifications_screen.dart';
import '../notification_setting/customer_notification_settings_screen.dart';

class CustomerAccountScreen extends StatelessWidget {
  const CustomerAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomerAccountViewModel(),
      child:
          Consumer<CustomerAccountViewModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: StyldColors.black,
            elevation: 0.0,
            title: Text(
              'Account',
              style: GoogleFonts.roboto(textStyle: r_18),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => Get.to(() => CustomerAllNotificationsScreen()),
                icon: SvgPicture.asset(StyldImages.notificationIcon),
              ),
            ],
          ),
          body: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  Center(
                    child: model.authService.customerUser!.imageUrl == null
                        ? CircleAvatar(
                            radius: 45.h,
                            backgroundColor: StyldColors.black,
                            foregroundColor: StyldColors.black,
                            backgroundImage:
                                const AssetImage(StyldImages.femaleImage),
                          )
                        : CircleAvatar(
                            radius: 45.h,
                            backgroundColor: StyldColors.black,
                            foregroundColor: StyldColors.black,
                            backgroundImage: NetworkImage(
                                model.authService.customerUser!.imageUrl!)),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '${model.authService.customerUser!.name}',
                          style: GoogleFonts.roboto(textStyle: buttonStyle),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          '${model.authService.customerUser!.email}',
                          style: GoogleFonts.roboto(textStyle: r_16_g),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          '${model.authService.customerUser!.phoneNumber}',
                          style: GoogleFonts.roboto(textStyle: r_16_g),
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
                              model.authService.customerUser = await Get.to(
                                      () => CustomerAccountSetting()) ??
                                  model.authService.customerUser;
                              model.setState(ViewState.idle);
                            },
                            iconPath: StyldImages.accountSettingsIcon,
                            title: 'Account Settings'),
                        AccountSettingsTile(
                            action: () => Get.to(
                                () => CustomerNotificationsSettingsScreen()),
                            iconPath: StyldImages.notificationSettingIcon,
                            title: 'Manage Notifications Settings'),
                        AccountSettingsTile(
                            action: () {},
                            iconPath: StyldImages.recentAppointmentsIcon,
                            title: 'Recent Appointments'),
                        AccountSettingsTile(
                            action: () => null,
                            //  Get.to(() => const SelectPaymentMethodView()),
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
      }),
    );
  }
}
