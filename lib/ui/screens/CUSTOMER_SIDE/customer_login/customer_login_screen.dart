import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
import 'package:styld_stylist/ui/custom_widgets/dialogs/request-failed-dialogue.dart';
import 'package:styld_stylist/ui/custom_widgets/next_icon_button.dart';
import 'package:styld_stylist/ui/custom_widgets/simple_text_field.dart';
import 'package:styld_stylist/ui/custom_widgets/suffix_text_field.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_signup/custom_signup_view_model.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_signup/customer_signup_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:get/get.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/root/customer_root_screen.dart';

class CustomerLoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomSignupViewModel(),
      child: Consumer<CustomSignupViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(StyldImages.stylistLoginBg),
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
                          const Spacer(),
                          Center(child: Image.asset(StyldImages.mediumLogo)),
                          SizedBox(
                            height: 18.h,
                          ),
                          Center(
                            child: Text(
                              'Welcome Back'.toUpperCase(),
                              style: GoogleFonts.roboto(textStyle: welcomeText),
                            ),
                          ),
                          SizedBox(
                            height: 35.h,
                          ),
                          Text(
                            'Sign in to continue',
                            style: GoogleFonts.roboto(textStyle: authText),
                          ),
                          SizedBox(
                            height: 35.h,
                          ),
                          loginForm(model),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  loginForm(CustomSignupViewModel model) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SimpleTextField(
            fieldController: _emailController,
            hintText: "Email Address",
            iconPath: StyldImages.emailIcon,
            onChange: (value) {
              model.customerUser.email = value;
            },
            validatorFunction: (val) {
              if (val.isEmpty) {
                return 'Email required';
              } else {
                return null;
              }
            },
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
          SizedBox(
            height: 30.h,
          ),
          NextIconButton(
              action: () async {
                print('login');
                if (_formKey.currentState!.validate()) {
                  print('Login customer');
                  await model.loginWithEmailPassword();

                  if (model.status) {
                    print("Login Successfully");
                    Get.offAll(() => CustomerRootScreen());
                  } else {
                    Get.dialog(RequestFailedDialog(
                      errorMessage: model.errorMessage,
                    ));
                  }
                }
              },
              icon: StyldImages.forwardIcon,
              title: "SIGN IN"),
          SizedBox(
            height: 10.h,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password ?',
              style: GoogleFonts.roboto(textStyle: buttonStyle),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an Account?',
                style: GoogleFonts.roboto(textStyle: buttonStyle),
              ),
              TextButton(
                  onPressed: () => Get.off(() => CustomerSignUpScreen()),
                  child: Text(
                    'Sign Up',
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
