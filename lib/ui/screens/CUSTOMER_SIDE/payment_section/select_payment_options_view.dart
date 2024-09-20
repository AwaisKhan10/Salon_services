import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:styld_stylist/ui/custom_widgets/customer_side_widgets/payment_method_tile.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/accountScreen/account/card_detials/add_cart_details.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/accountScreen/account/card_detials/cart_detail_view_model.dart';

class SelectPaymentMethodView extends StatelessWidget {
  const SelectPaymentMethodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardDetialViewModel(true),
      child: Consumer<CardDetialViewModel>(
        builder: (context, model, child){
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
            floatingActionButton: GestureDetector(
              onTap: () async{
                model.cards = await  Get.to(() => AddCardDetailScreen(model.cards)) ?? model.cards;
                model.setState(ViewState.idle);
              },
              child: Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  color: StyldColors.blue,
                  shape: BoxShape.circle
                ),
                child: Center(
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
            appBar: AppBar(
              backgroundColor: StyldColors.black,
              elevation: 0.0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: SvgPicture.asset(StyldImages.backIcon),
              ),
              title: Text(
                'Payment Methods',
                style: GoogleFonts.roboto(textStyle: r_16),
              ),
            ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11.0),
                      color: StyldColors.blue,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.cards.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index){
                        return PaymentMethodTile(
                            cardType: StyldImages.visaIcon,
                            expiryDate: '${model.cards[index].expiryMonth}/${model.cards[index].expiryYear}',
                            lastFourDigits: '${model.cards[index].cardNo!.substring(0,4)}');
                      })
                  ),
                ],
              ),
            ),
                  ),
          );
        },
      ),
    );
  }
}
