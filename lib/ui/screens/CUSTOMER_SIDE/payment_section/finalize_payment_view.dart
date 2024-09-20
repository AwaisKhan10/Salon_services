// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:styld_stylist/core/constants/colors.dart';
// import 'package:styld_stylist/core/constants/images.dart';
// import 'package:styld_stylist/core/constants/text_styles.dart';
// import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
// import 'package:styld_stylist/ui/custom_widgets/customer_side_widgets/big_checkout_row.dart';
// import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
// import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/noShowPolicy/no_show_policy.dart';
// import 'select_payment_options_view.dart';

// class FinalizePaymentView extends StatelessWidget {
//   const FinalizePaymentView({Key? key}) : super(key: key);

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
//           'Select Date & Time',
//           style: GoogleFonts.roboto(textStyle: r_16),
//         ),
//       ),
//       body: Container(
//         margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
//         child: CustomScrollableView(
//           widget: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: SvgPicture.asset(
//                   StyldImages.timeline2Icon,
//                 ),
//               ),
//               SizedBox(
//                 height: 30.h,
//               ),
//               Container(
//                   margin: EdgeInsets.symmetric(vertical: 5.h),
//                   child:
//                       const Divider(thickness: 1.0, color: StyldColors.white)),
//               _debitCardSection(),

//               Container(
//                   margin: EdgeInsets.symmetric(vertical: 5.h),
//                   child:
//                       const Divider(thickness: 1.0, color: StyldColors.white)),
//               SizedBox(
//                 height: 5.h,
//               ),

//               _checkOutDetailsSection(),
//               SizedBox(
//                 height: 35.h,
//               ),

//               WidthButton(
//                   action: () => Get.to(() => NoShowPolicyScreen()),
//                   buttonColor: StyldColors.lightGold,
//                   buttonColor2: StyldColors.darkGold,
//                   titleText: 'Finalize Appointment',
//                   width: 356.w),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Text(
//                 'All Transactions and payments are secured with high SSL protocol encryption.',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.roboto(
//                   textStyle: r_12,
//                 ),
//               ),

//               // const Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _debitCardSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Payment Method',
//               style: GoogleFonts.roboto(textStyle: b_12_g),
//             ),
//             SizedBox(
//               height: 5.h,
//             ),
//             Row(
//               children: [
//                 SvgPicture.asset(StyldImages.smDebitCardIcon),
//                 SizedBox(
//                   width: 10.w,
//                 ),
//                 Text(
//                   'Add New Credit Card',
//                   style: GoogleFonts.roboto(textStyle: b_14_g),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         InkWell(
//             onTap: () => Get.to(() => const SelectPaymentMethodView()),
//             child: SvgPicture.asset(StyldImages.nextIcon)),
//       ],
//     );
//   }

//   _checkOutDetailsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Services',
//           style: GoogleFonts.roboto(textStyle: b_12_g),
//         ),
//         BigCheckoutRow(text1: 'Hair Styling', text2: '15', fontSize: 18.sp),
//         const BigCheckoutRow(text1: 'Haircuts', text2: '10'),
//         const BigCheckoutRow(text1: 'Blow Dry', text2: '5'),
//         const BigCheckoutRow(text1: 'Hair Straighten', text2: '10'),
//         Container(
//             margin: EdgeInsets.symmetric(vertical: 5.h),
//             child: const Divider(thickness: 1.0, color: StyldColors.white)),
//         BigCheckoutRow(text1: 'Total', text2: '40', fontSize: 20.sp),
//       ],
//     );
//   }
// }
