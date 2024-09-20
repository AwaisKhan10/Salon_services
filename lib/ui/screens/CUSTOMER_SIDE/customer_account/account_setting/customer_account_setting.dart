import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/ui/custom_widgets/stylist_side_widgets/prefix_text_field.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_account/account_setting/account_setting_view_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CustomerAccountSetting extends StatefulWidget {
  const CustomerAccountSetting({Key? key}) : super(key: key);

  @override
  State<CustomerAccountSetting> createState() => _AccountSettingsViewState();
}

class _AccountSettingsViewState extends State<CustomerAccountSetting> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomerAccountSettingViewModel(),
      child: Consumer<CustomerAccountSettingViewModel>(
          builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: StyldColors.black,
              elevation: 0.0,
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: SvgPicture.asset(StyldImages.backIcon),
              ),
              title: Text(
                'Account Settings',
                style: GoogleFonts.roboto(textStyle: r_16),
              ),
            ),
            body: SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      SizedBox(height: 25.h),
                      GestureDetector(
                        onTap: () {
                          model.getProfileImg();
                        },
                        child: Center(
                          child: Stack(
                            children: [
                              model.profileImage == null
                                  ? model.authService.customerUser!.imageUrl ==
                                          null
                                      ? CircleAvatar(
                                          radius: 45.h,
                                          backgroundColor: StyldColors.black,
                                          foregroundColor: StyldColors.black,
                                          backgroundImage: const AssetImage(
                                              StyldImages.femaleImage),
                                        )
                                      : CircleAvatar(
                                          radius: 60.r,
                                          backgroundColor: StyldColors.black,
                                          foregroundColor: StyldColors.black,
                                          backgroundImage: NetworkImage(
                                              model.editUser.imageUrl!),
                                          // const AssetImage(StyldImages.femaleImage),
                                        )
                                  : CircleAvatar(
                                      radius: 60.r,
                                      backgroundColor: StyldColors.black,
                                      foregroundColor: StyldColors.black,
                                      backgroundImage:
                                          FileImage(model.profileImage!),
                                      // const AssetImage(StyldImages.femaleImage),
                                    ),
                              Positioned(
                                  left:
                                      MediaQuery.of(context).size.width * 0.13,
                                  top:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child:
                                      SvgPicture.asset(StyldImages.addPhoto)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${model.editUser.name}',
                            style: GoogleFonts.roboto(textStyle: buttonStyle),
                          ),
                          PrefixTextField(
                              controller: TextEditingController(
                                  text: model.editUser.name ?? ''),
                              onChange: (value) {
                                model.editUser.name = value;
                              },
                              initialValue: model.editUser.name,
                              title: 'Name',
                              iconPath: StyldImages.editIcon),
                          PrefixTextField(
                              controller: TextEditingController(
                                  text: model.editUser.phoneNumber ?? ''),
                              onChange: (value) {
                                model.editUser.phoneNumber = value;
                              },
                              initialValue: model.editUser.phoneNumber,
                              title: 'Mobile',
                              iconPath: StyldImages.editIcon),
                          SizedBox(height: 8.h),

                          ///
                          /// about customer
                          Row(
                            children: [
                              Text(
                                'About',
                                style: GoogleFonts.roboto(textStyle: r_14),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.16,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            decoration: BoxDecoration(
                              color: StyldColors.blue,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: AutoSizeTextField(
                              onChanged: (value) {
                                model.editUser.about = value;
                              },
                              keyboardType: TextInputType.multiline,
                              controller: model.controller,
                              minLines:
                                  1, //Normal textInputField will be displayed
                              maxLines: 6,
                              style: GoogleFonts.roboto(textStyle: r_17),
                              cursorColor: StyldColors.white,
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintText: "Write something about yourself...",
                                hintStyle: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.italic)
                                        .copyWith(
                                            color: StyldColors.lightGrey)),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          WidthButton(
                              action: () {
                                if (_formKey.currentState!.validate()) {
                                  model.updateProfile();
                                }
                              },
                              buttonColor: StyldColors.lightGold,
                              titleText: 'Save Changes',
                              width: 356.w),
                          SizedBox(
                            height: 15.h,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
