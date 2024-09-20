import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
import 'package:styld_stylist/ui/custom_widgets/dialogs/request-failed-dialogue.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/authentication/stylist-auth-view-model.dart';
import 'package:get/get.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/root/stylist_root_screen.dart';
import 'login_form.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class StylistLoginScreen extends StatelessWidget {
  // const StylistLoginScreen({Key? key}) : super(key: key);
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<StylistAuthViewModel>(
      builder: (context, model, child) => ModalProgressHUD(
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
                  child: Form(
                    key: formkey,
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
                        LoginForm(
                          validator: (val) {
                            if (!val.toString().isEmail) {
                              return 'Please Enter a Valid Email';
                            } else {
                              return null;
                            }
                          },
                          onEmailSaved: (value) {
                            model.stylistUser.email = value;
                          },
                          onPasswordSaved: (value) {
                            model.stylistUser.password = value;
                          },
                          onSignInPressed: () async {
                            if (formkey.currentState!.validate()) {
                              formkey.currentState!.save();

                              await model.loginWithEmailPassword();

                              if (model.status) {
                                print("Login Successfully");
                                Get.offAll(() => StylistRootScreen());
                              } else {
                                Get.dialog(RequestFailedDialog(
                                  errorMessage: model.errorMessage,
                                ));
                              }
                            }
                          },
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
