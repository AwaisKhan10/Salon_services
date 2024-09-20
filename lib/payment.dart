// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
// import 'package:get/get.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:project_1/core/enums/view_state.dart';
// import 'package:project_1/core/model/rent-car.dart';
// import 'package:project_1/core/view_models/admin-info-view-model.dart';
// import 'package:project_1/core/view_models/rent-auth-model.dart';
// import 'package:project_1/ui/custom_widgets/NavigationDrawer/app_drawer.dart';
// import 'package:project_1/ui/custom_widgets/constants.dart';
// import 'package:project_1/ui/custom_widgets/userType.dart';
// import 'package:project_1/ui/screens/RENT_A_CAR/costBreakdown/rent-costBreakdown-viewmodel.dart';
// import 'package:project_1/ui/screens/RENT_A_CAR/home/rent-user-home/rent-user-home.dart';
// import 'package:provider/provider.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:project_1/.env.example.dart';

// class RentCostBreakdown extends StatefulWidget {
//   final RentedCar car;
//   RentCostBreakdown({this.car});

//   @override
//   _RentCostBreakdownState createState() => _RentCostBreakdownState();
// }

// class _RentCostBreakdownState extends State<RentCostBreakdown> {
//   int groupValue = 0;

//   Map<String, dynamic> paymentIntentData;
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => RentCostBreakDownViewModel(),
//       child: Consumer<RentCostBreakDownViewModel>(
//         builder: (context, model, child) => ModalProgressHUD(
//           inAsyncCall: model.state == ViewState.loading,
//           child: Scaffold(
//             backgroundColor: Colors.grey[100],
//             drawer: AppDrawer(userType: UserType.carUser),
//             appBar: AppBar(
//               backgroundColor: SharedConstants().yellow,
//               centerTitle: true,
//               elevation: 0.0,
//               title: Text(
//                 'COST BREAKDOWN',
//                 style: TextStyle(
//                   fontSize: 25,
//                   color: SharedConstants().purple,
//                   fontFamily: 'Bison',
//                 ),
//               ),
//             ),
//             floatingActionButton: FloatingActionButton(
//               hoverColor: SharedConstants().purple,
//               key: Key("breakDownFAB"),
//               elevation: 0.0,
//               backgroundColor: SharedConstants().yellow,
//               mini: true,
//               onPressed:
//                   // () {
//                   //   Get.dialog(AlertDialog(
//                   //     title: Text(
//                   //       "Confirmation",
//                   //       style: TextStyle(
//                   //           color: SharedConstants().purple,
//                   //           fontFamily: 'OP_S',
//                   //           fontSize: 18),
//                   //     ),
//                   //     content: Text(
//                   //         "Do you want to confirm Booking of this car if yes press confirm button ! "),
//                   //     actions: [
//                   //       TextButton(
//                   //         child: Text("Confirm"),
//                   //         onPressed: () async {
//                   //           await model.addToBookedList(car);
//                   //           print("Testing=======================+>");
//                   //           Get.offAll(() => RentUserHome(),
//                   //               transition: Transition.leftToRight);
//                   //         },
//                   //       )
//                   //     ],
//                   //   ));
//                   // },
//                   () => showD(context, model),
//               child: Icon(
//                 CupertinoIcons.forward,
//                 color: Colors.black,
//               ),
//             ),
//             body: _body(
//               context,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _body(BuildContext context) {
//     return ListView(
//       children: [
//         _termCondition(context),
//         _priceBreakdown(context),
//       ],
//     );
//   }

//   Widget _termCondition(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.315,
//       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'TERMS & CONDITION',
//             style: TextStyle(fontFamily: 'OP_B', fontSize: 20),
//           ),
//           Divider(
//             color: Colors.grey[800],
//             thickness: 1.2,
//           ),
//           Flexible(
//             child: Text(
//               // "",
//               '${Provider.of<AdminInfoViewModel>(context, listen: false).termsCondition ?? "null"}',
//               // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ',
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _priceBreakdown(BuildContext context) {
//     return Container(
//       // height: MediaQuery.of(context).size.height * 0.60,
//       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'PRICE BREAKDOWN',
//             style: TextStyle(fontFamily: 'OP_B', fontSize: 20),
//           ),
//           Divider(
//             color: Colors.grey[800],
//             thickness: 1.2,
//           ),
//           // for (int index = 0;
//           //     index < 2; // PriceBreakDownRepo().priceBreakdownList.length;
//           //     index++)
//           detail(
//             title:
//                 "SubTotal", //PriceBreakDownRepo().priceBreakdownList[index].type,
//             detail: "${widget.car.subTotal}",
//           ),
//           detail(
//             title:
//                 'Charges', //PriceBreakDownRepo().priceBreakdownList[index].type,
//             detail:
//                 '${Provider.of<AdminInfoViewModel>(context, listen: false).serviceCharges ?? ""}', //PriceBreakDownRepo().priceBreakdownList[index].cost,
//           ),
//           Divider(
//             color: Colors.grey[600],
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 15.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Total: ',
//                   style: TextStyle(fontSize: 19, fontFamily: 'OP_S'),
//                 ),
//                 Text(
//                   '\$${Provider.of<AdminInfoViewModel>(context, listen: false).serviceCharges + int.parse(widget.car.totalPrice) ?? ""}',
//                   style: TextStyle(fontSize: 20, fontFamily: 'OP_B'),
//                 ),
//               ],
//             ),
//           ),
//           Text(
//             'Continue With Payment',
//             style: TextStyle(fontSize: 17),
//           ),
//         ],
//       ),
//     );
//   }

//   showD(BuildContext context, RentCostBreakDownViewModel model) {
//     return showAnimatedDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return ClassicGeneralDialogWidget(
//           negativeText: '',
//           positiveText: "Confirm",
//           positiveTextStyle: TextStyle(
//               color: SharedConstants().purple,
//               fontFamily: 'OP_S',
//               fontSize: 18),
//           titleText: 'Confirmation',
//           contentText:
//               'Do you want to confirm Booking of this car if yes press confirm button ! ',
//           onPositiveClick: () async {
//             Get.back();
//             showBookingModeDialogue(model);
//             // await model.addToBookedList(
//             //     car, Provider.of<RentAuthModel>(context, listen: false).user);
//             // print("Testing=======================+>");
//             // Get.offAll(() => RentUserHome(),
//             //     transition: Transition.leftToRight);
//           },
//         );
//       },
//       animationType: DialogTransitionType.size,
//       curve: Curves.fastOutSlowIn,
//       duration: Duration(seconds: 1),
//     );
//   }

//   showBookingModeDialogue(RentCostBreakDownViewModel model) {
//     return showAnimatedDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return Container(
//             height: 300,
//             child: StatefulBuilder(
//               builder: (_, setstate) => AlertDialog(
//                 title: Text("Select mode of booking"),
//                 content: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Radio(
//                             value: 0,
//                             groupValue: groupValue,
//                             onChanged: (value) {
//                               setstate(() {
//                                 groupValue = value;
//                               });

//                               print(groupValue.toString());
//                             }),
//                         Text('Pick Up'),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Radio(
//                             value: 1,
//                             groupValue: groupValue,
//                             onChanged: (value) {
//                               setstate(() {
//                                 groupValue = value;
//                               });

//                               print(groupValue.toString());
//                             }),
//                         Text('Delivery'),
//                       ],
//                     ),
//                     Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                       FlatButton(
//                           color: Colors.yellow,
//                           textColor: Colors.black,
//                           onPressed: () async {
//                             var totalAmount = Provider.of<AdminInfoViewModel>(
//                                             context,
//                                             listen: false)
//                                         .serviceCharges +
//                                     int.parse(widget.car.totalPrice) ??
//                                 0;
//                             Get.back();

//                             ///TODO : firstly i have to checked this car is already booked by someone or not and this can be done ny
//                             ///by checking this car in host collection if exist than avoid it if not then proceed
//                             bool isAlreadyBooked = await model.isAlreadyBooked(
//                                 widget.car.hostUserId, widget.car.id);
//                             if (!isAlreadyBooked) {
//                               makePayment(totalAmount, model);
//                             } else {
//                               ///TODO: here i have to show the user that this car is already booked plz try again next time
//                               Get.dialog(AlertDialog(
//                                 title: Text('Booking Failed'),
//                                 content: Text(
//                                     "This Car is Currently booked please try another car for Booking"),
//                                 actions: [
//                                   FlatButton(
//                                     color: Colors.yellow,
//                                     textColor: Colors.black,
//                                     onPressed: () {
//                                       Get.offAll(() => RentUserHome());
//                                     },
//                                     child: Text("OK"),
//                                   ),
//                                 ],
//                               ));
//                             }
//                           },
//                           child: Text("Continue")),
//                     ])
//                   ],
//                 ),
//               ),
//             ));
//       },
//       animationType: DialogTransitionType.size,
//       curve: Curves.fastOutSlowIn,
//       duration: Duration(seconds: 1),
//     );
//   }

//   Widget detail({String title, String detail}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 5.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title + ' ',
//             style: TextStyle(fontSize: 18),
//           ),
//           Text(
//             detail,
//             style: TextStyle(fontSize: 19, fontFamily: 'OP_S'),
//           ),
//         ],
//       ),
//     );
//   }

//   ////
//   ///
//   ///
//   ///PAYMENT GATEWAY INTEGRATION WITH STRIPE
//   ///
//   ///
//   ///
//   Future<void> makePayment(totalAmount, model) async {
//     try {
//       paymentIntentData = await createPaymentIntent(
//           totalAmount.toString(), 'USD'); //json.decode(response.body);
//       // print('Response body==>${response.body.toString()}');
//       await Stripe.instance.initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//               paymentIntentClientSecret: paymentIntentData['client_secret'],
//               applePay: true,
//               googlePay: true,
//               style: ThemeMode.dark,
//               merchantCountryCode: 'US',
//               merchantDisplayName: 'ANNIE'));
//       // setState(() {});

//       ///
//       ///now finally display payment sheeet
//       ///
//       displayPaymentSheet(model);
//     } catch (e, s) {
//       print('@@Exception==========>$e, $s');
//     }
//   }

//   displayPaymentSheet(model) async {
//     print(
//         "Display payment sheet started=====>${paymentIntentData['client_secret']}");
//     try {
//       await Stripe.instance.presentPaymentSheet(
//           parameters: PresentPaymentSheetParameters(
//         clientSecret: paymentIntentData['client_secret'],
//         confirmPayment: true,
//       ));
//       setState(() {
//         paymentIntentData = null;
//       });

//       ///****************** */
//       //if payment is successfull then add the car to booked list
//       //otherwise cancelled
//       await model.addToBookedList(
//           widget.car, Provider.of<RentAuthModel>(context, listen: false).user);
//       print("Testing=======================+>");
//       Get.offAll(() => RentUserHome(), transition: Transition.leftToRight);

//       ///****************** */
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("car booked successfully")));
//     } on StripeException catch (e) {
//       print('Exception/DISPLAYPAYMENTSHEET==> $e');
//       showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//                 content: Text("Booking Cancelled unexpectedly"),
//                 actions: [
//                   FlatButton(
//                       color: Colors.yellow,
//                       textColor: Colors.black,
//                       onPressed: () {
//                         var totalAmount = Provider.of<AdminInfoViewModel>(
//                                         context,
//                                         listen: false)
//                                     .serviceCharges +
//                                 int.parse(widget.car.totalPrice) ??
//                             0;
//                         Get.back();
//                         makePayment(totalAmount, model);
//                       },
//                       child: Text("Try again")),
//                 ],
//               ));
//     } catch (e) {
//       print('$e');
//     }
//   }

//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//         'payment_method_types[]': 'card'
//       };
//       print(body);
//       var response = await http.post(
//           Uri.parse('https://api.stripe.com/v1/payment_intents'),
//           body: body,
//           headers: {
//             'Authorization': 'Bearer $clientSecret',
//             'Content-Type': 'application/x-www-form-urlencoded'
//           });
//       print('Create Intent reponse ===> ${response.body.toString()}');
//       return jsonDecode(response.body);
//     } catch (err) {
//       print('err charging user: ${err.toString()}');
//     }
//   }

//   calculateAmount(String amount) {
//     final a = (int.parse(amount) * 100);
//     return a.toString();
//   }
// }