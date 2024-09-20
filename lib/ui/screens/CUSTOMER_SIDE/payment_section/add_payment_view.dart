// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/booking.dart';
import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/payment_section/payment_view_model.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class AddPaymentView extends StatefulWidget {
  final Booking booking;
  AddPaymentView(this.booking);

  @override
  State<AddPaymentView> createState() => _AddPaymentViewState();
}

class _AddPaymentViewState extends State<AddPaymentView> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expDateController = TextEditingController();
  final TextEditingController _cvvCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final List<String> _cardTypes = [
    StyldImages.pinkVisaCard,
    StyldImages.greenVisaCard,
  ];

  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentViewModel(),
      child: Consumer<PaymentViewModel>(
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
                  'Payment',
                  style: GoogleFonts.roboto(textStyle: r_16),
                ),
                actions: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'Add New Card',
                        style: GoogleFonts.roboto(textStyle: r_13),
                      ),
                    ),
                  ),
                ],
              ),
              body: model.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 15.w),
                      child: CustomScrollableView(
                        widget: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                StyldImages.timeline3Icon,
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            SizedBox(
                              height: 180.h,
                              child: ListView.builder(
                                  itemCount: _cardTypes.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkResponse(
                                      onTap: () {},
                                      child: Container(
                                          margin: index ==
                                                  (_cardTypes.length - 1)
                                              ? EdgeInsets.only(right: 0.w)
                                              : EdgeInsets.only(right: 10.w),
                                          child: SvgPicture.asset(
                                              _cardTypes[index])),
                                    );
                                  }),
                            ),
                            SizedBox(height: 15.h),
                            Text(
                              'Press Pay now button below to pay for the service',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                textStyle: r_18,
                              ),
                            ),

                            ///
                            /// credit card details
                            ///
                            // _cardInputView(model),
                            Spacer(),

                            // Row(children: [
                            //   Checkbox(
                            //     value: true,
                            //     onChanged: (val) {},
                            //     activeColor: StyldColors.blue,
                            //     // fillColor: StyldColors.blue,
                            //     checkColor: StyldColors.lightGold,
                            //   ),
                            //   Text(
                            //     'Save Credit Card information',
                            //     style: GoogleFonts.roboto(
                            //       textStyle: r_13,
                            //     ),
                            //   ),
                            // ]),
                            WidthButton(
                                action: () async {
                                  // if (_formKey.currentState!.validate()) {
                                  print(widget.booking.toJson());
                                  print(model.creditCard.toJson());
                                  await makePayment(widget.booking.price, model,
                                      widget.booking);
                                  // }
                                },
                                buttonColor: StyldColors.lightGold,
                                buttonColor2: StyldColors.darkGold,
                                titleText: 'Pay Now',
                                width: 356.w),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'All Transactions and payments are secured with high SSL protocol encryption.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                textStyle: r_12,
                              ),
                            ),
                            // const Spacer(),
                          ],
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  ////
  ///
  ///
  ///PAYMENT GATEWAY INTEGRATION WITH STRIPE
  ///
  ///
  ///
  Future<void> makePayment(
      totalAmount, PaymentViewModel model, Booking booking) async {
    try {
      model.setState(ViewState.busy);
      paymentIntentData = await createPaymentIntent(
          totalAmount.toString(), 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      print(
          "Display payment sheet started=====>${paymentIntentData!['client_secret']}");
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              // customerId: paymentIntentData!['id'],
              // customerEphemeralKeySecret: stripePublishableKey,
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              // applePay: true,
              // googlePay: true,
              style: ThemeMode.dark,

              // merchantCountryCode: 'US',
              // billingDetails: BillingDetails(),
              merchantDisplayName: '${model.authService.customerUser!.name}'));

      model.setState(ViewState.idle);

      ///
      ///now finally display payment sheeet
      ///
      displayPaymentSheet(totalAmount, model, booking);
    } catch (e, s) {
      print('@@Exception==========>$e, $s');
    }
    model.setState(ViewState.idle);
  }

  displayPaymentSheet(
      totalAmount, PaymentViewModel model, Booking booking) async {
    model.setState(ViewState.busy);
    print(
        "Display payment sheet started=====>${paymentIntentData!['client_secret']}");
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          style: ThemeMode.light, // or dark
          merchantDisplayName: 'Your Merchant Name',
        ),
      );

      setState(() {
        paymentIntentData = null;
      });

      ///****************** */
      //if payment is successfull then add the car to booked list
      //otherwise cancelled
      model.bookNewService(booking);

      ///****************** */
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Booking Cancelled unexpectedly"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                        makePayment(totalAmount, model, booking);
                      },
                      child: Text("Try again")),
                ],
              ));
    } catch (e) {
      print('$e');
    }
    model.setState(ViewState.idle);
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer $clientSecret',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount) * 100);
    return a.toString();
  }

  _cardInputView(PaymentViewModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),

      // width: 356.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.0),
        color: StyldColors.blue,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Card Number',
              style: GoogleFonts.roboto(textStyle: r_16),
            ),
            TextFormField(
              onChanged: (value) {
                model.creditCard.cardNo = value;
              },
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                fontSize: 14.sp,
                color: StyldColors.white,
              )),
              cursorColor: StyldColors.white,
              validator: (value) {
                if (value!.isEmpty)
                  return "required field";
                else
                  return null;
              },
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: StyldColors.white, width: 1.5)),
                border: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: StyldColors.white, width: 1.5)),
                hintText: '2376  65XX  XXXX  XXXX',
                hintStyle: GoogleFonts.roboto(
                    textStyle: TextStyle(
                  fontSize: 14.sp,
                  color: StyldColors.white,
                )),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Exp. Date',
                        style: GoogleFonts.roboto(textStyle: r_16),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          model.creditCard.expDate = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty)
                            return "required field";
                          else
                            return null;
                        },
                        controller: _expDateController,
                        keyboardType: TextInputType.datetime,
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                          fontSize: 14.sp,
                          color: StyldColors.white,
                        )),
                        cursorColor: StyldColors.white,
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: StyldColors.white, width: 1.5)),
                          border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: StyldColors.white, width: 1.5)),
                          hintText: 'DD.MM.YYYY',
                          hintStyle: GoogleFonts.roboto(
                              textStyle: TextStyle(
                            fontSize: 14.sp,
                            color: StyldColors.white,
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CVV Code',
                        style: GoogleFonts.roboto(textStyle: r_16),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          model.creditCard.cvv = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty)
                            return "required field";
                          else
                            return null;
                        },
                        controller: _cvvCodeController,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                          fontSize: 14.sp,
                          color: StyldColors.white,
                        )),
                        cursorColor: StyldColors.white,
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: StyldColors.white, width: 1.5)),
                          border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: StyldColors.white, width: 1.5)),
                          hintText: '000',
                          hintStyle: GoogleFonts.roboto(
                              textStyle: TextStyle(
                            fontSize: 14.sp,
                            color: StyldColors.white,
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
