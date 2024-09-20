import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/model/booking.dart';
import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
import 'package:styld_stylist/ui/custom_widgets/customer_side_widgets/big_checkout_row.dart';
import 'package:styld_stylist/ui/custom_widgets/customer_side_widgets/check_out_widget.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/payment_section/payment_view_model.dart';

import 'order_confirm_details_view.dart';

class SelectDateTimeView extends StatefulWidget {
  final Booking booking;
  final String? price;
  SelectDateTimeView(this.booking, {this.price});
  @override
  State<SelectDateTimeView> createState() => _SelectDateTimeViewState();
}

class _SelectDateTimeViewState extends State<SelectDateTimeView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: StyldColors.black,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: SvgPicture.asset(StyldImages.backIcon),
            ),
            title: Text(
              'Selected Date & Time',
              style: GoogleFonts.roboto(textStyle: r_16),
            ),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            child: CustomScrollableView(
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      StyldImages.timeline2Icon,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CheckOutWidget(
                      text1: 'Date & Time',
                      text2: '${widget.booking.month} ${widget.booking.date}',
                      text3: '${widget.booking.timeSlot}'),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 5.h),
                      child: const Divider(
                          thickness: 1.0, color: StyldColors.white)),
                  CheckOutWidget(
                    picture: '${model.authService.bookingStylist.imgUrl}',
                    text1: 'Stylist',
                    text2: '${model.authService.bookingStylist.fullName}',
                    text3: 'Available',
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 5.h),
                      child: const Divider(
                          thickness: 1.0, color: StyldColors.white)),

                  ///
                  /// payment method
                  _debitCardSection(),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 5.h),
                      child: const Divider(
                          thickness: 1.0, color: StyldColors.white)),

                  ///
                  /// services
                  _checkOutDetailsSection(model, price: widget.price),
                  SizedBox(
                    height: 45.h,
                  ),

                  ///
                  /// proceed button
                  WidthButton(
                      action: () {
                        widget.booking.price = (int.parse(widget.price ??
                                    model
                                        .authService.bookingPrice.basicPrice!) *
                                widget.booking.services.length)
                            .toString();
                        Get.to(() => OrderConfirmDetailsView(widget.booking));
                      },
                      buttonColor: StyldColors.lightGold,
                      buttonColor2: StyldColors.darkGold,
                      titleText: 'Proceed to Payment',
                      width: 356.w),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _debitCardSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Method',
              style: GoogleFonts.roboto(textStyle: b_12_g),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                SvgPicture.asset(StyldImages.smDebitCardIcon),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'Credit Card',
                  style: GoogleFonts.roboto(textStyle: b_14_g),
                ),
              ],
            ),
          ],
        ),
        InkWell(
            // onTap: () => Get.to(() => const SelectPaymentMethodView()),
            onTap: () {},
            child: SvgPicture.asset(StyldImages.nextIcon)),
      ],
    );
  }

  _checkOutDetailsSection(PaymentViewModel model, {price}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected Service',
          style: GoogleFonts.roboto(textStyle: b_12_g),
        ),
        Container(
          height: 0.2.sh,
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.booking.services.length,
            itemBuilder: (context, index) {
              return BigCheckoutRow(
                  text1: '${widget.booking.services[index]}',
                  text2:
                      '${price ?? model.authService.bookingPrice.basicPrice}',
                  fontSize: 18.sp);
            },
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 5.h),
            child: const Divider(thickness: 1.0, color: StyldColors.white)),
        BigCheckoutRow(
            text1: 'Total',
            text2:
                '${int.parse(price ?? model.authService.bookingPrice.basicPrice!) * widget.booking.services.length}',
            fontSize: 20.sp),
      ],
    );
  }
}
