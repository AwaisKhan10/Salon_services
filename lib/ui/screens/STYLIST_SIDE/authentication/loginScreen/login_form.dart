import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/ui/custom_widgets/next_icon_button.dart';
import 'package:styld_stylist/ui/custom_widgets/simple_text_field.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/authentication/signUpScreen/sign_up_screen.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/root/stylist_root_screen.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  final onEmailSaved;
  final onPasswordSaved;
  final validator;
  final onSignInPressed;
  LoginForm(
      {this.onEmailSaved,
      this.onPasswordSaved,
      this.onSignInPressed,
      this.validator});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SimpleTextField(
          fieldController: _emailController,
          hintText: "Email Address",
          onsaved: widget.onEmailSaved,
          iconPath: StyldImages.emailIcon,
          validatorFunction: widget.validator,
        ),
        SizedBox(
          height: 15.h,
        ),
        TextFormField(
          validator: (val) =>
              val!.length < 6 ? 'Enter a Password 6+ Characters' : null,
          obscureText: _hidePassword,
          controller: _passwordController,
          onSaved: widget.onPasswordSaved,
          cursorColor: StyldColors.lightGold,
          style: const TextStyle(color: StyldColors.white),
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: () {
                if (_passwordController.text.isNotEmpty) {
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                }
              },
              child: const ImageIcon(
                Svg(StyldImages.eyeIconOff),
                color: StyldColors.white,
              ),
            ),
            hintText: "Password",
            hintStyle: GoogleFonts.roboto(
                textStyle:
                    TextStyle(color: StyldColors.white, fontSize: 18.sp)),
            prefixIcon: const ImageIcon(
              Svg(StyldImages.passwordLockIcon),
              color: StyldColors.white,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 2.0, color: StyldColors.lightGold),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 2.0, color: StyldColors.lightGold),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        NextIconButton(
            action: widget.onSignInPressed,
            // () async {
            //   // if (_formKey.currentState!.validate()) {
            //   //   FocusScope.of(context).requestFocus(FocusNode());
            //   Get.offAll(() => const StylistRootScreen());
            //   // } else {
            //   //   _emailController.clear();
            //   //   _passwordController.clear();
            //   // }
            // },
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
                onPressed: () => Get.off(() => const SignUpScreen()),
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
    );
  }
}
