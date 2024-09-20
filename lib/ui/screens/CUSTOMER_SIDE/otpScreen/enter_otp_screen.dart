import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_signup/custom_signup_view_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EnterOTPScreen extends StatefulWidget {
  const EnterOTPScreen({Key? key}) : super(key: key);

  @override
  State<EnterOTPScreen> createState() => _EnterOTPScreenState();
}

class _EnterOTPScreenState extends State<EnterOTPScreen> {
  final _pinPutController = TextEditingController();

  final _pinPutFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomSignupViewModel>(builder: (context, model, child) {
      return ModalProgressHUD(
        inAsyncCall: model.state == ViewState.busy,
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(StyldImages.otpBg2),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.55), BlendMode.darken),
              ),
            ),
            child: SafeArea(
              child: CustomScrollableView(
                widget: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Center(
                          child:
                              SvgPicture.asset(StyldImages.otpIllustration2)),
                      SizedBox(
                        height: 45.h,
                      ),
                      Text('Enter OTP',
                          style: GoogleFonts.roboto(textStyle: m_18)),
                      SizedBox(height: 15.h),
                      Text(
                        'Enter the verification code \nreceived in notification', //${model.customerUser.phoneNumber}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(textStyle: r_16),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      _otpField(),
                      SizedBox(height: 30.h),
                      WidthButton(
                        buttonColor: StyldColors.lightGold,
                        buttonColor2: StyldColors.darkGold,
                        titleText: 'VERIFY & CONTINUE',
                        width: 356.w,
                        action: () {
                          if (_pinPutController.text == model.otp) {
                            model.createAccount();
                          } else {
                            Get.snackbar('Error', 'Correct Pin Code Required');
                          }
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _otpField() {
    final PinTheme pinPutDecoration = PinTheme(
        height: 55.0,
        width: 55.0,
        textStyle: GoogleFonts.roboto(textStyle: r_22),
        decoration: BoxDecoration(
          color: StyldColors.blue,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: StyldColors.lightGold,
          ),
        ));

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Pinput(
        length: 4,
        showCursor: true,
        // onSubmit: (String pin) => {
        //   if (pin.isNotEmpty)
        //     {
        //       // Get.offAll(page)
        //     }
        //   else
        //     {Get.snackbar('Error', 'Correct Pin Code Required')}
        // },
        focusNode: _pinPutFocusNode,
        controller: _pinPutController,
        defaultPinTheme: pinPutDecoration,

        pinAnimationType: PinAnimationType.fade,
      ),
    );
  }
}
