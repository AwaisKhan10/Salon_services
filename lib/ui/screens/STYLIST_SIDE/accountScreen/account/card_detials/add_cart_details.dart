import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/model/card.dart';
import 'package:styld_stylist/ui/custom_widgets/next_button.dart';
import 'package:styld_stylist/ui/custom_widgets/simple_text_field.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/images.dart';
import '../../../../../../core/constants/text_styles.dart';
import '../../../../../../core/enums/view_state.dart';
import 'cart_detail_view_model.dart';
import 'package:get/get.dart';

class AddCardDetailScreen extends StatelessWidget {
  final List<CardDetails> cards;
   AddCardDetailScreen(this.cards,{Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardDetialViewModel(false),
      child: Consumer<CardDetialViewModel>(
        builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: StyldColors.black,
                elevation: 0.0,
                centerTitle: true,
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: SvgPicture.asset(StyldImages.backIcon),
                ),
                title: Text(
                  'Add Cards',
                  style: GoogleFonts.roboto(textStyle: r_16),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///
                    /// contain add new group button,profile image, users
                    ///
                    // heading(model),
                    SizedBox(height: 20.h),
                    middleScreen(model),
                    SizedBox(height: 50.h),
                    // nextButton(model)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    
  }
  middleScreen(CardDetialViewModel model) {
    return Form(
      key: _formKey,
      child: Padding(
         padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleTextField(
              icon: Icons.credit_card,
              hintText: "Card No",
              onChange: (value) {
                model.card.cardNo = value;
              },
              validatorFunction: (value) {
                if (value.isEmpty) {
                  return "Required field";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              children: [
                Expanded(
                  child: SimpleTextField(
                    hintText: "Expiry Month",
                    icon: Icons.date_range,

                    onChange: (value) {
                      model.card.expiryMonth = value;
                    },
                    validatorFunction: (value) {
                      if (value.isEmpty) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                   
                     
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: SimpleTextField(
                    hintText: "Expiry Year",
                    icon: Icons.date_range,

                    onChange: (value) {
                      model.card.expiryYear = value;
                    },
                    validatorFunction: (value) {
                      if (value.isEmpty) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                   
                     
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            SimpleTextField(
                    hintText: "CVV",
                    icon: Icons.credit_card,
                    onChange: (value) {
                      model.card.cvv = value;
                    },
                    validatorFunction: (value) {
                      if (value.isEmpty) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                   
                     
                  ),

              SizedBox(height: 40.h),
              NextButton(title: 'add', action: (){
                model.addCardDetails(cards);
              })
           
          ],
        ),
      ),
    );
  }
}