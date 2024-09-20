// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/services/local_storage_service.dart';
import 'package:styld_stylist/ui/custom_widgets/next_button.dart';
import 'package:styld_stylist/ui/custom_widgets/select_button.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_login/customer_login_screen.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/authentication/loginScreen/stylist_login_screen.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/introScreen/intro_screen.dart';
import 'package:styld_stylist/ui/screens/customer_side/onboardingModule/onboarding_screen.dart';

import '../../../locator.dart';
// import 'package:styld_stylist/utils/views/stylist_side/introScreen/intro_screen.dart';

class SelectionScreen extends StatelessWidget {
  SelectionScreen({Key? key}) : super(key: key);
  final ValueNotifier<bool> _firstSelected = ValueNotifier(false);
  final ValueNotifier<bool> _secondSelected = ValueNotifier(false);
  final _localStorage = locator<LocalStorageService>();
  _navigateNext() {
    if (_secondSelected.value) {
      if (_localStorage.onBoardingPageCountStylist == 0) {
        Get.to(() => const IntroScreen());
      } else {
        Get.to(() => StylistLoginScreen());
      }
    } else if (_firstSelected.value) {
      if (_localStorage.onBoardingPageCountCustomer == 0) {
        Get.to(() => const OnboardingScreen());
      } else {
        Get.to(() =>  CustomerLoginScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(StyldImages.selectionScreenBg2),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.33), BlendMode.darken),
            ),
          ),
          child: SafeArea(
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100.h),
                Image.asset(StyldImages.mainLogo),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  'Get Started As',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(textStyle: boldTitleWhite),
                ),
                SizedBox(
                  height: 60.h,
                ),
                ValueListenableBuilder(
                  valueListenable: _firstSelected,
                  builder: (context, hasError, child) {
                    return SelectButton(
                        isActive: _firstSelected.value,
                        title: 'Customer',
                        action: () {
                          _firstSelected.value = !_firstSelected.value;
                          _secondSelected.value = false;
                        });
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                ValueListenableBuilder(
                  valueListenable: _secondSelected,
                  builder: (context, hasError, child) {
                    return SelectButton(
                        isActive: _secondSelected.value,
                        title: 'Stylist',
                        action: () {
                          _secondSelected.value = !_secondSelected.value;
                          _firstSelected.value = false;
                        });
                  },
                ),
                SizedBox(
                  height: 130.h,
                ),
                NextButton(title: 'Next', action: () => _navigateNext())
              ],
            ),
          )),
    );
  }
}
