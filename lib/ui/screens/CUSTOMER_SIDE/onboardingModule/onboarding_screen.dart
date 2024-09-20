import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/services/local_storage_service.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_login/customer_login_screen.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_signup/customer_signup_screen.dart';

import '../../../../locator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  double? height;
  final List<PageViewModel> _listOfPages = [
    PageViewModel(
      title: "Explore Nearby Saloons",
      body:
          "Search the service, specialist saloons or stylist nearby. Book appointments and track Realtime Stylist location.",
      image: SvgPicture.asset(StyldImages.screen1),
      decoration: PageDecoration(
        titleTextStyle: GoogleFonts.roboto(textStyle: b_20),
        // imageFlex: 5,
        imageAlignment: Alignment.center,
        bodyTextStyle: GoogleFonts.roboto(textStyle: r_16),
      ),
    ),
    PageViewModel(
      title: "Book your Favourite Stylist",
      body:
          'Schedule your appointment with your favourite specialist as per your convenience.',
      image: SvgPicture.asset(StyldImages.screen2),
      decoration: PageDecoration(
        titleTextStyle: GoogleFonts.roboto(textStyle: b_20),
        // imageFlex: 5,
        imageAlignment: Alignment.center,
        bodyTextStyle: GoogleFonts.roboto(textStyle: r_16),
      ),
    ),
    PageViewModel(
      title: "Avails Offers & Promos",
      body:
          'Enjoy the best offers and promos for time to time to get discounts on your favourite services.',
      image: SvgPicture.asset(StyldImages.screen3),
      decoration: PageDecoration(
        titleTextStyle: GoogleFonts.roboto(textStyle: b_20),
        // imageFlex: 5,
        imageAlignment: Alignment.center,
        bodyTextStyle: GoogleFonts.roboto(textStyle: r_16),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.h, bottom: 10.h),
        child: IntroductionScreen(
          pages: _listOfPages,
          onDone: () {
            locator<LocalStorageService>().setOnBoardingPageCountCustomer = 1;
            // When done button is press
            Get.offAll(() =>  CustomerLoginScreen());
          },
          onSkip: () {
            locator<LocalStorageService>().setOnBoardingPageCountCustomer = 1;
            // You can also override onSkip callback
            Get.offAll(() =>  CustomerLoginScreen());
          },
          showSkipButton: true,
          skip: Text('SKIP', style: GoogleFonts.roboto(textStyle: m_18)),
          next: Container(
              height: 50.h,
              // width: width,
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
              child: Center(
                child: Text(
                  'NEXT',
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                    fontSize: 15.sp,
                    color: StyldColors.white,
                    fontWeight: FontWeight.w500,
                  )),
                ),
              )),
          done: Container(
              height: 50.h,
              // width: width,
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
              child: Center(
                child: Text(
                  'GET STARTED',
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                    fontSize: 15.sp,
                    color: StyldColors.white,
                    fontWeight: FontWeight.w500,
                  )),
                ),
              )),
          dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              activeColor: StyldColors.lightGold,
              color: Colors.white,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0))),
        ),
      ),
    );
  }
}
