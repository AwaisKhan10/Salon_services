// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:styld_stylist/core/constants/colors.dart';
// import 'package:styld_stylist/core/constants/images.dart';
// import 'package:styld_stylist/core/constants/text_styles.dart';
// import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
// import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/payment_section/payment_successful_view.dart';

// class NoShowPolicyScreen extends StatelessWidget {
//   NoShowPolicyScreen({Key? key}) : super(key: key);
//   final ScrollController _scrollController = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: StyldColors.black,
//         elevation: 0.0,
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         title: Text(
//           'No Show Policy',
//           style: GoogleFonts.roboto(textStyle: r_16),
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//               padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//               decoration: BoxDecoration(
//                   color: StyldColors.blue,
//                   borderRadius: BorderRadius.circular(12.0)),
//               child: Scrollbar(
//                   controller: _scrollController,
//                   radius: const Radius.circular(7.0),
//                   isAlwaysShown: true,
//                   showTrackOnHover: true,
//                   thickness: 8.0,
//                   child: ListView(
//                     controller: _scrollController,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 10.w, vertical: 10.h),
//                         decoration: BoxDecoration(
//                             color: StyldColors.black,
//                             borderRadius: BorderRadius.circular(12.0)),
//                         child: Center(
//                           child: Text(
//                             'Your appointments are very important to us, it is reserved especially for you, we understand that sometimes schedule adjustments are necessary; therefore, we respectfully request at least 24 hours notice for cancellations.',
//                             style: GoogleFonts.roboto(textStyle: r_13),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       Text(
//                         'STRICT AND ENFORCED 24 HOUR CANCELLATION POLICY!',
//                         style: GoogleFonts.roboto(textStyle: b_11),
//                       ),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 10.w, vertical: 10.h),
//                         decoration: BoxDecoration(
//                             color: StyldColors.black,
//                             borderRadius: BorderRadius.circular(12.0)),
//                         child: Center(
//                           child: Text(
//                             'Please understand that when you forget or cancel your appointment without giving enough notice, we miss the opportunity to fill that appointment time, and clients on our waiting list miss the opportunity to receive services. Our appointments are confirmed 48 hours in advance because we know how easy it is to forget an appointment.  Since the services are reserved for you personally, a Cancellation fee will apply.',
//                             style: GoogleFonts.roboto(textStyle: r_13),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       Text(
//                         'Less than 24 hour notice will result in a charge equal to 50% of the reserved service amount.',
//                         style: GoogleFonts.roboto(textStyle: r_12),
//                       ),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       Text(
//                         '“NO SHOWS” will be charged 100% of the\nreserved service amount.',
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.roboto(textStyle: b_11),
//                       ),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 10.w, vertical: 10.h),
//                         decoration: BoxDecoration(
//                             color: StyldColors.black,
//                             borderRadius: BorderRadius.circular(12.0)),
//                         child: Center(
//                           child: Text(
//                             'Appointments made within the 24 hour period and need to cancel, the client then must cancel within 4 hours of appointment time or will result in a charge equal to 50% of the reserved service amount.',
//                             style: GoogleFonts.roboto(textStyle: r_13),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 10.w, vertical: 10.h),
//                         decoration: BoxDecoration(
//                             color: StyldColors.black,
//                             borderRadius: BorderRadius.circular(12.0)),
//                         child: Center(
//                           child: Text(
//                             'Any multiple services or combos must be held with a credit card. Multiple services or combos not cancelled 24hours in advance will be charged 100% of the reserved service amount. A credit card    "HOLD" transaction maybe made on your credit card to reserve the appointment time.',
//                             style: GoogleFonts.roboto(textStyle: r_13),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       Text(
//                         'Cancellation Policy',
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.roboto(textStyle: b_11),
//                       ),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 10.w, vertical: 10.h),
//                         decoration: BoxDecoration(
//                             color: StyldColors.black,
//                             borderRadius: BorderRadius.circular(12.0)),
//                         child: Center(
//                           child: Text(
//                             'The cancellation policy allows us the time to inform our standby guests of any availability, as well as keeping our stylist scheduled filled, thus better serving everyone. Thank you!',
//                             style: GoogleFonts.roboto(textStyle: r_13),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//             child: Row(children: [
//               SvgPicture.asset(StyldImages.selectionIcon,
//                   color: StyldColors.lightGold),
//               SizedBox(
//                 width: 10.w,
//               ),
//               Text(
//                 'I have read all the No Show Terms & Conditions',
//                 style: GoogleFonts.roboto(textStyle: r_10),
//               ),
//             ]),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20.w),
//             child: WidthButton(
//                 action: () => Get.to(() => const PaymentSuccessfulView()),
//                 buttonColor: StyldColors.lightGold,
//                 buttonColor2: StyldColors.darkGold,
//                 titleText: 'Confirm',
//                 width: 356.0),
//           ),
//         ],
//       ),
//     );
//   }
// }
