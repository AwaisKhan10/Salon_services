import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/services/local_storage_service.dart';
import 'package:styld_stylist/ui/custom_widgets/next_button.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/authentication/loginScreen/stylist_login_screen.dart';
import '../../../../locator.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  const Spacer(),
                  const Spacer(),
                  SvgPicture.asset(StyldImages.introIllustration),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    'STYLD Beauty Salon App',
                    style: GoogleFonts.roboto(textStyle: buttonStyle),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    'Fully Online Appointment scheduling with clients.\nEasy fast and Simply Track the client location to deliver your services.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(textStyle: regular),
                  ),
                  const Spacer(),
                  Container(
                    height: 10.h,
                    width: 42.w,
                    decoration: BoxDecoration(
                        color: StyldColors.lightGold,
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                  NextButton(
                      title: 'Get Started',
                      action: () {
                        locator<LocalStorageService>()
                            .setOnBoardingPageCountStylist = 1;
                        Get.offAll(() => StylistLoginScreen());
                      }),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
