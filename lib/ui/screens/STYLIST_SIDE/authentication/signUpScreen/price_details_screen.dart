import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
import 'package:styld_stylist/ui/custom_widgets/dialogs/request-failed-dialogue.dart';
import 'package:styld_stylist/ui/custom_widgets/next_icon_button.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/authentication/stylist-auth-view-model.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/request_approval/approval_screen.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/root/stylist_root_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PriceDetailsScreen extends StatefulWidget {
  // const PriceDetailsScreen({Key? key}) : super(key: key);
  @override
  State<PriceDetailsScreen> createState() => _PriceDetailsScreenState();
}

class _PriceDetailsScreenState extends State<PriceDetailsScreen> {
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<StylistAuthViewModel>(
      builder: (context, model, child) => ModalProgressHUD(
        inAsyncCall: model.state == ViewState.busy,
        child: Scaffold(
          body: SafeArea(
            child: CustomScrollableView(
              widget: Form(
                key: formkey,
                child: Column(
                  children: [
                    const Spacer(),
                    Center(child: Image.asset(StyldImages.mediumLogo)),
                    SizedBox(
                      height: 18.h,
                    ),

                    // const Spacer(),
                    Center(
                      child: Text(
                        'Pricing Details',
                        style: GoogleFonts.roboto(textStyle: welcomeText),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // for (var index in pricingDetailsList)
                    pricingDetails('Basic', model, context, (value) {
                      model.pricingDetails.basicPrice = value;
                    }, (value) {
                      model.pricingDetails.basicDetails = value;
                    }, model.basicDetailsController),
                    pricingDetails('Standard', model, context, (value) {
                      model.pricingDetails.standardPrice = value;
                    }, (value) {
                      model.pricingDetails.standardDetails = value;
                    }, model.standardDetailsController),
                    pricingDetails('premium', model, context, (value) {
                      model.pricingDetails.premiumPrice = value;
                    }, (value) {
                      model.pricingDetails.premiumDetails = value;
                    }, model.premiumDetailsController),
                    SizedBox(
                      height: 5.h,
                    ),
                    NextIconButton(
                        action: () async {
                          if (model.pricingDetails.basicPrice != null &&
                              model.pricingDetails.basicDetails != null &&
                              model.pricingDetails.standardPrice != null &&
                              model.pricingDetails.standardDetails != null &&
                              model.pricingDetails.premiumPrice != null &&
                              model.pricingDetails.premiumDetails != null) {
                            print('user data => ${model.stylistUser.toJson()}');
                            print(
                                'pricing details => ${model.pricingDetails.toJson()}');
                            var status = await model.createAccount();
                            if (status) {
                              print("SignUp Successfully");

                              Get.offAll(() => ApprovalPendingScreen());
                            } else {
                              Get.dialog(RequestFailedDialog(
                                errorMessage: model.errorMessage,
                              ));
                            }
                          } else {
                            Get.snackbar('Required',
                                "Please enter prices and details for all packages",
                                colorText: StyldColors.white,
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                        icon: StyldImages.forwardIcon,
                        title: "SAVE & GETSTARTED"),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget pricingDetails(String title, StylistAuthViewModel model, context,
      onPriceChange, onDetailsChange, controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.0),
        color: StyldColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: GoogleFonts.roboto(textStyle: r_18_b),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Package Price',
                style: GoogleFonts.lato(textStyle: b_13_b),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 28,
                width: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  color: StyldColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                    child: TextFormField(
                        cursorColor: StyldColors.black,
                        onChanged: onPriceChange,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5, bottom: 15),
                          hintText: '\$ 15',
                          hintStyle:
                              TextStyle(color: Color(0xFF262A34), fontSize: 14),
                          border: InputBorder.none,
                        ))),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Package Details',
            style: GoogleFonts.lato(textStyle: b_13_b),
          ),
          SizedBox(height: 10),
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: StyldColors.grey.withOpacity(0.33),
              ),
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: AutoSizeTextField(
              onChanged: onDetailsChange,
              keyboardType: TextInputType.multiline,

              controller: controller,
              minLines: 1, //Normal textInputField will be displayed
              maxLines: 6,
              style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic)
                  .copyWith(color: StyldColors.black),
              cursorColor: StyldColors.black,
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
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
