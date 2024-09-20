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
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/ui/custom_widgets/stylist_side_widgets/prefix_text_field.dart';
import 'package:styld_stylist/ui/custom_widgets/stylist_side_widgets/tag_button.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/accountScreen/account_settings/account_setting_view_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../../locator.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({Key? key}) : super(key: key);

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _businessName = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _nameController.text = locator<AuthService>().stylistUser!.fullName!;
    _emailController.text = locator<AuthService>().stylistUser!.email!;
    _numberController.text = locator<AuthService>().stylistUser!.phoneNumber!;
    _locationController.text = locator<AuthService>().stylistUser!.address!;
    _aboutController.text = locator<AuthService>().stylistUser!.aboutService!;
    _businessName.text = locator<AuthService>().stylistUser!.businessName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AccountSettingViewModel(),
      child: Consumer<AccountSettingViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
              body: SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        ///
                        /// Profile and background images
                        ///
                        changeImagesArea(model),

                        ///
                        /// Form
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              Text(
                                '${model.authService.stylistUser!.fullName}',
                                style: buttonStyle,
                              ),
                              PrefixTextField(
                                  controller: _nameController,
                                  initialValue: model.editUser.fullName ?? '',
                                  onChange: (value) {
                                    model.editUser.fullName = value;
                                  },
                                  hintText: 'name',
                                  title: 'Name',
                                  iconPath: StyldImages.editIcon),
                              
                              PrefixTextField(
                                  controller: _businessName,
                                  initialValue: model.editUser.businessName ?? '',
                                  onChange: (value) {
                                    model.editUser.businessName = value;
                                  },
                                  hintText: 'business name',
                                  title: 'Business Name',
                                  iconPath: StyldImages.editIcon),
                              // PrefixTextField(
                              //     controller: _emailController,
                              //     onChange: (value) {
                              //       model.editUser.email = value;
                              //     },
                              //     title: 'Email',
                              //     hintText: 'email',
                              //     iconPath: StyldImages.editIcon),
                              PrefixTextField(
                                  initialValue:
                                      model.editUser.phoneNumber ?? '',
                                  controller: _numberController,
                                  onChange: (value) {
                                    model.editUser.phoneNumber = value;
                                  },
                                  title: 'Mobile',
                                  hintText: 'mobile',
                                  iconPath: StyldImages.editIcon),
                              PrefixTextField(
                                  initialValue: model.editUser.address ?? '',
                                  readOnly: false,
                                  controller: _locationController,
                                  onChange: (value) {
                                    model.editUser.address = value;
                                  },
                                  hintText: 'location',
                                  title: 'Real Time Location',
                                  iconPath: StyldImages.editIcon),

                              ///
                              /// about stylist

                              aboutArea((value) {
                                model.editUser.aboutService = value;
                              }, model),
                              // ExpandableContainer(
                              //     title: 'About', about: ourUser.about),
                              SizedBox(
                                height: 10.h,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 30.w),
                                  child: Text(
                                    'Tags for your Service',
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.roboto(textStyle: r_14),
                                  ),
                                ),
                              ),

                              ///
                              ///  tags of your service area
                              ///
                              Container(
                                // height: 100.h,
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 30.w),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: StyldColors.lightGrey),
                                    borderRadius: BorderRadius.circular(5)),
                                child: model.authService.stylistUser!.tags !=
                                        null
                                    ? Wrap(
                                        direction: Axis.horizontal,
                                        children: List.generate(
                                          model.services.length,
                                          (index) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: TagButton(
                                                tagValue:
                                                    model.services[index].name,
                                                selected: model
                                                    .services[index].active,
                                                callback: () =>
                                                    model.selectNewTag(index)),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              WidthButton(
                                  action: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (model.editUser.aboutService != null &&
                                          model.editUser.tags!.isNotEmpty) {
                                        model.updateProfile();
                                      } else {
                                        Get.snackbar('Required',
                                            'Please provide all required details',
                                            snackPosition: SnackPosition.BOTTOM,
                                            colorText: StyldColors.white);
                                      }
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
                        ),
                        // Spacer(),
                      ],
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

  changeImagesArea(AccountSettingViewModel model) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Stack(
        children: [
          Stack(
            children: [
              PreferredSize(
                preferredSize: Size.fromHeight(224.h),
                child: AppBar(
                  leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: SvgPicture.asset(StyldImages.backIcon),
                  ),
                  // title: Text('App Bar!'),
                  flexibleSpace: model.backgroundImage == null
                      ? model.authService.stylistUser!.backgroundImgUrl == null
                          ? const Image(
                              image: AssetImage(StyldImages.headerImage),
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              model.authService.stylistUser!.backgroundImgUrl!,
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height * 0.27,
                              width: double.infinity)
                      : Image.file(model.backgroundImage!,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.27,
                          width: double.infinity),
                  backgroundColor: Colors.transparent,
                  actions: [
                    IconButton(
                      onPressed: () {
                        model.getBackgroundImage();
                      },
                      icon: SvgPicture.asset(StyldImages.editIcon),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0.35.sw,
                top: 135,
                child:
                    // TODO: CIrculear Picker already implemented use it
                    // UserImagePicker(radius: 60, imageType: (file) {}),
                    Stack(
                  children: [
                    model.profileImage == null
                        ? CircleAvatar(
                            radius: 60.r,
                            backgroundColor: StyldColors.black,
                            foregroundColor: StyldColors.black,
                            backgroundImage: NetworkImage(
                                locator<AuthService>().stylistUser!.imgUrl!),
                            // const AssetImage(StyldImages.femaleImage),
                          )
                        : CircleAvatar(
                            radius: 60.r,
                            backgroundColor: StyldColors.black,
                            foregroundColor: StyldColors.black,
                            backgroundImage: FileImage(model.profileImage!),
                            // const AssetImage(StyldImages.femaleImage),
                          ),
                    // SizedBox(
                    //   height: 5.h,
                    // ),
                    Positioned(
                        left: MediaQuery.of(context).size.width * 0.13,
                        top: MediaQuery.of(context).size.height * 0.06,
                        child: GestureDetector(
                          onTap: () {
                            model.getProfileImg();
                          },
                          child: SvgPicture.asset(StyldImages.addPhoto),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  aboutArea(onChange, AccountSettingViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.h,
        ),
        Text(
          'About',
          style: GoogleFonts.roboto(textStyle: r_14),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          decoration: BoxDecoration(
            color: StyldColors.blue,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: AutoSizeTextField(
            onChanged: onChange,
            keyboardType: TextInputType.multiline,
            controller: model.controller,
            minLines: 1, //Normal textInputField will be displayed
            maxLines: 6,
            style: GoogleFonts.roboto(textStyle: r_17),
            cursorColor: StyldColors.white,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: "Add service details here...",
              hintStyle: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic)
                      .copyWith(color: StyldColors.lightGrey)),
            ),
          ),
        ),
      ],
    );
  }
}
