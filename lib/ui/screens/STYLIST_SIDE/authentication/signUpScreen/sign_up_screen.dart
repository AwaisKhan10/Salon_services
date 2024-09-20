import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/ui/custom_widgets/dialogs/request-failed-dialogue.dart';
import 'package:styld_stylist/ui/custom_widgets/document_upload_image_picker.dart';
import 'package:styld_stylist/ui/custom_widgets/next_icon_button.dart';
import 'package:styld_stylist/ui/custom_widgets/simple_text_field.dart';
import 'package:styld_stylist/ui/custom_widgets/suffix_text_field.dart';
import 'package:styld_stylist/ui/custom_widgets/user_image_picker.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/add_service_dialog/add_service_dialog.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/add_service_dialog/add_service_states.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/home_stylist/home_screen.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../stylist-auth-view-model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? _image = null;
  GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _salonController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final _items = ['Beauty Salon', 'Makeup Salon'];
  bool _hidePassword = true;
  @override
  void initState() {
    super.initState();
    _locationController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StylistAuthViewModel>(builder: (context, model, child) {
      return ModalProgressHUD(
        inAsyncCall: model.state == ViewState.busy,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(StyldImages.selectionScreenBg2),
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
                      SizedBox(
                        height: 18.h,
                      ),

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
                          imageType: (File file) {
                            _image = file;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Sign up as Stylist',
                        style: GoogleFonts.roboto(textStyle: authText),
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      ////
                      ///form
                      ///
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SimpleTextField(
                              onsaved: (value) {
                                model.stylistUser.fullName = value;
                                model.stylistUser.fullName = value;
                              },
                              fieldController: _nameController,
                              hintText: "Full Name",
                              iconPath: StyldImages.userIconCircle,
                              validatorFunction: (val) => val!.isEmpty
                                  ? 'Please Provide your Full Name'.toString()
                                  : null,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            SimpleTextField(
                              onsaved: (value) {
                                model.stylistUser.email = value;
                                model.stylistUser.email = value;
                              },
                              fieldController: _emailController,
                              hintText: "Email Address",
                              iconPath: StyldImages.emailIcon,
                              validatorFunction: (val) => val!.isEmpty
                                  ? 'Please Provide your Email'.toString()
                                  : null,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            SimpleTextField(
                              onsaved: (value) {
                                model.stylistUser.phoneNumber = value;
                                model.stylistUser.phoneNumber = value;
                              },
                              fieldController: _phoneNumberController,
                              hintText: "Phone Number",
                              iconPath: StyldImages.mobileIcon,
                              validatorFunction: (val) => val!.isEmpty
                                  ? 'Please Provide your Phone Number'
                                      .toString()
                                  : null,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                  width: 2.0,
                                  color: StyldColors.lightGold,
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      validator: (value) => value!.isEmpty
                                          ? "Invalid feild"
                                          : null,
                                      onSaved: (value) {
                                        model.stylistUser.salonType = value;
                                      },
                                      style: const TextStyle(
                                          color: StyldColors.white),
                                      controller: _salonController,
                                      readOnly: true,
                                      cursorColor: StyldColors.lightGold,
                                      decoration: InputDecoration(
                                        hintText: "Salon",
                                        hintStyle: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: StyldColors.white,
                                                fontSize: 18.sp)),
                                        prefixIcon: IconButton(
                                          onPressed: () {},
                                          icon: SvgPicture.asset(
                                            StyldImages.beautyParlorIcon,
                                            height: 22.h,
                                            // height: 10.h,
                                          ),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  PopupMenuButton<String>(
                                    icon: SvgPicture.asset(
                                        StyldImages.dropdownIcon),
                                    onSelected: (String value) {
                                      _salonController.text = value;
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return _items.map<PopupMenuItem<String>>(
                                          (String value) {
                                        return PopupMenuItem(
                                            child: Text(value), value: value);
                                      }).toList();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            SuffixTextField(
                                onsaved: (value) {
                                  model.stylistUser.password = value;
                                },
                                fieldController: _passwordController,
                                hintText: "Password",
                                iconPath: StyldImages.passwordLockIcon,
                                hideText: _hidePassword,
                                suffixIconPath: StyldImages.eyeIconOff,
                                validatorFunction: (val) => val!.length < 6
                                    ? 'Enter a Password 6+ Characters'
                                    : null,
                                suffixAction: () {
                                  if (_passwordController.text.isNotEmpty) {
                                    setState(() {
                                      _hidePassword = !_hidePassword;
                                    });
                                  }
                                }),
                            SizedBox(
                              height: 15.h,
                            ),
                            DocumentUploadImagePicker(
                                onTap: () {
                                  model.pickFile();
                                },
                                name: model.stylistUser.certificate!.name ??
                                    'Upload Document (Certificate)',
                                imageType: (File file) {}),
                            SizedBox(
                              height: 15.h,
                            ),
                            SimpleTextField(
                                fieldController: _locationController,
                                hintText:
                                    "23 St, Mall Road Near Ware House, New York",
                                validatorFunction: (value) {
                                  if (value.isEmpty) {
                                    return 'locaiton required';
                                  } else {
                                    return null;
                                  }
                                },
                                onChange: (value) {
                                  model.stylistUser.address = value;
                                },
                                iconPath: StyldImages.locationPictureIcon),
                            // SimpleTextField(
                            //     fieldController: _locationController,
                            //     hintText:
                            //         "23 St, Mall Road Near Ware House, New York",
                            //     iconPath: StyldImages.locationPictureIcon),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(StyldImages.selectionIcon,
                                    color: StyldColors.lightGold),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  'By creating account I agree with Terms & Conditions',
                                  style:
                                      GoogleFonts.roboto(textStyle: tinyText),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            NextIconButton(
                                action: () async {
                                  // if (_formKey.currentState!.validate()) {
                                  //   _formKey.currentState!.save();

                                  //   FocusScope.of(context)
                                  //       .requestFocus(FocusNode());
                                  //   // Get.offAll(() => CompleteRegistrationView());
                                  // showDialog(
                                  //     barrierDismissible: false,
                                  //     context: context,
                                  //     builder: (context) =>
                                  //         ChangeNotifierProvider(
                                  //             create: (_) =>
                                  //                 AddServiceStates(),
                                  //             child:
                                  //                 const AddServiceDialog()));
                                  // } else {
                                  //   _emailController.clear();
                                  //   _passwordController.clear();
                                  // }
                                  if (_image != null) {
                                    model.stylistUser.createdAt =
                                        DateTime.now().toString();
                                    // Get.to(() => RootProviderScreen());
                                    if (_formKey.currentState!.validate()) {
                                      if (model.file != null) {
                                        _formKey.currentState!.save();
                                        model.stylistUser.imgFile = _image;
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) =>
                                                ChangeNotifierProvider(
                                                    create: (_) =>
                                                        AddServiceStates(),
                                                    child:
                                                        const AddServiceDialog()));
                                      } else {
                                        Get.dialog(RequestFailedDialog(
                                            errorMessage:
                                                "Add certificate before moving ahead"));
                                      }
                                    } else {
                                      _emailController.clear();
                                      _passwordController.clear();
                                    }
                                  } else {
                                    Get.dialog(RequestFailedDialog(
                                        errorMessage:
                                            "add business logo before moving ahead "));
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
                                  style: GoogleFonts.roboto(
                                      textStyle: buttonStyle),
                                ),
                                TextButton(
                                    onPressed: () async {},
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
                      )
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
}
