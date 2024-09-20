import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
import 'package:styld_stylist/ui/custom_widgets/next_icon_button.dart';
import 'package:styld_stylist/ui/custom_widgets/simple_text_field.dart';
import 'package:styld_stylist/ui/custom_widgets/suffix_text_field.dart';
import 'package:styld_stylist/ui/custom_widgets/user_image_picker.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_login/customer_login_screen.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_signup/custom_signup_view_model.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/otpScreen/get_otp_screen.dart';
import 'package:get/get.dart';

class CustomerSignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomSignupViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(StyldImages.customerSignUpBg),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.45), BlendMode.darken),
                ),
              ),
              child: SafeArea(
                child: CustomScrollableView(
                  widget: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Image.asset(StyldImages.mediumLogo)),
                        SizedBox(height: 18.h),

                        // const Spacer(),
                        Center(
                          child: Text(
                            'Welcome'.toUpperCase(),
                            style: GoogleFonts.roboto(textStyle: welcomeText),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: UserImagePicker(
                            imageType: (file) {
                              model.image = file;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'Sign up to Join',
                          style: GoogleFonts.roboto(textStyle: authText),
                        ),
                        SizedBox(
                          height: 35.h,
                        ),

                        ///
                        /// Signup form
                        ///
                        signupForm(model),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  signupForm(CustomSignupViewModel model) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SimpleTextField(
            fieldController: _nameController,
            hintText: "Full Name",
            iconPath: StyldImages.userIconCircle,
            onChange: (value) {
              model.customerUser.name = value;
            },
            validatorFunction: (val) => val!.isEmpty
                ? 'Please Provide your Full Name'.toString()
                : null,
          ),
          SizedBox(
            height: 15.h,
          ),
          SimpleTextField(
            fieldController: _emailController,
            hintText: "Email Address",
            iconPath: StyldImages.emailIcon,
            onChange: (value) {
              model.customerUser.email = value;
            },
            validatorFunction: (val) =>
                val!.isEmpty ? 'Please Provide your Email'.toString() : null,
          ),
          SizedBox(
            height: 15.h,
          ),
          SimpleTextField(
            fieldController: _phoneNumberController,
            hintText: "Phone Number",
            iconPath: StyldImages.mobileIcon,
            onChange: (value) {
              model.customerUser.phoneNumber = value;
            },
            validatorFunction: (val) => val!.isEmpty
                ? 'Please Provide your Phone Number'.toString()
                : null,
          ),
          SizedBox(
            height: 15.h,
          ),
          SuffixTextField(
              fieldController: _passwordController,
              hintText: "Password",
              iconPath: StyldImages.passwordLockIcon,
              hideText: _hidePassword,
              suffixIconPath: StyldImages.eyeIconOff,
              onChange: (value) {
                model.customerUser.password = value;
              },
              validatorFunction: (val) =>
                  val!.length < 6 ? 'Enter a Password 6+ Characters' : null,
              suffixAction: () {
                if (_passwordController.text.isNotEmpty) {
                  _hidePassword = !_hidePassword;
                  model.setState(ViewState.idle);
                }
              }),
          SizedBox(height: 15.h),
          Row(
            children: [
              SvgPicture.asset(StyldImages.selectionIcon,
                  color: StyldColors.lightGold),
              SizedBox(width: 10.w),
              Text(
                'By creating account I agree with Terms & Conditions',
                style: GoogleFonts.roboto(textStyle: tinyText),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          NextIconButton(
              action: () async {
                if (_formKey.currentState!.validate()) {
                  // FocusScope.of(context).requestFocus(FocusNode());
                  print('customerUserData => ${model.customerUser.toJson()}');
                  Get.to(() => GetOTPScreen());
                  // }
                  // else {
                  //   _emailController.clear();
                  //   _passwordController.clear();
                }
              },
              icon: StyldImages.forwardIcon,
              title: "NEXT"),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an Account?',
                style: GoogleFonts.roboto(textStyle: buttonStyle),
              ),
              TextButton(
                  onPressed: () => Get.off(() => CustomerLoginScreen()),
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: StyldColors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
