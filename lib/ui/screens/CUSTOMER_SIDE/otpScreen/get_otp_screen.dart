import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
import 'package:styld_stylist/ui/custom_widgets/next_icon_button.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_signup/custom_signup_view_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class GetOTPScreen extends StatelessWidget {
  GetOTPScreen({Key? key}) : super(key: key);
  final TextEditingController _phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

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
                image: const AssetImage(StyldImages.otpBg1),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.55), BlendMode.darken),
              ),
            ),
            child: SafeArea(
              child: CustomScrollableView(
                widget: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        SvgPicture.asset(StyldImages.otpIllustration1),
                        SizedBox(
                          height: 45.h,
                        ),
                        Text('Get OTP',
                            style: GoogleFonts.roboto(textStyle: m_18)),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          'Enter Valid Phone number to verify.',
                          style: GoogleFonts.roboto(textStyle: r_16),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5.h),
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: StyldColors.blue,
                          ),
                          height: 60.h,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Row(
                            children: [
                              // Text('+1',
                              //     style: GoogleFonts.roboto(textStyle: m_18)),
                              // Container(
                              //   margin: EdgeInsets.symmetric(
                              //       vertical: 15.h, horizontal: 10.w),
                              //   child: const VerticalDivider(
                              //     thickness: 2.0,
                              //     color: StyldColors.lightGold,
                              //   ),
                              // ),
                              Flexible(
                                child: TextFormField(
                                  // keyboardType: TextInputType.number,
                                  controller: _phoneNumberController,
                                  onChanged: (value) {
                                    model.phone = value;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 11) {
                                      return 'Enter a valid number';
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: GoogleFonts.roboto(textStyle: r_17),
                                  cursorColor: StyldColors.white,
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hintStyle:
                                        GoogleFonts.roboto(textStyle: r_17),
                                    hintText: 'Phone Number with country code',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        NextIconButton(
                            action: () {
                              if (_formKey.currentState!.validate()) {
                                model.getOTP();
                              }
                            },
                            icon: StyldImages.forwardIcon,
                            title: 'GET OTP'),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
