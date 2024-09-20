// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:styld_stylist/core/constants/colors.dart';
// import 'package:styld_stylist/core/constants/images.dart';
// import 'package:styld_stylist/core/constants/text_styles.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
// import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
// import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/payment_section/confirm_booking/booking_confirmed_map_view.dart';

// class PaymentSuccessfulView extends StatelessWidget {
//   const PaymentSuccessfulView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: StyldColors.black,
//         elevation: 0.0,
//         leading: IconButton(
//           onPressed: () => Get.back(),
//           icon: SvgPicture.asset(StyldImages.backIcon),
//         ),
//         title: Text(
//           'Booking Payment',
//           style: GoogleFonts.roboto(textStyle: r_16),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: SafeArea(
//           child: CustomScrollableView(
//             widget: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 55.h,
//                 ),
//                 Center(
//                   child: SvgPicture.asset(
//                     StyldImages.paymentConfirmationIllustration,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 35.h,
//                 ),
//                 Center(
//                   child: Text(
//                     'Payment Successful',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.roboto(textStyle: r_18),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 35.h,
//                 ),
//                 Center(
//                   child: Text(
//                     '\$ 50\nMake up & Hair dressing Serice',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.roboto(textStyle: m_21),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 50.h,
//                 ),

//                 WidthButton(
//                     action: () =>
//                         Get.to(() =>  BookingConfirmedMapScreen(widget.booking)),
//                     buttonColor: StyldColors.lightGold,
//                     buttonColor2: StyldColors.darkGold,
//                     titleText: 'Done',
//                     width: 356.w),

//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Text(
//                   'All Transactions and payments are secured with high SSL protocol encryption.',
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.roboto(
//                     textStyle: r_12,
//                   ),
//                 ),

//                 // const Spacer(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
