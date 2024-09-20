// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:styld_stylist/core/constants/colors.dart';
// import 'package:styld_stylist/core/constants/images.dart';
// import 'package:styld_stylist/core/constants/text_styles.dart';
// import 'package:styld_stylist/core/model/stylist_order_approval_model.dart';
// import 'package:styld_stylist/ui/custom_widgets/stylist_side_widgets/approval_button.dart';

// class StylistOrderApprovalTile extends StatelessWidget {
//   final StylistOrderApprovalModel orderApproval;
//   final VoidCallback? declineAction;
//   final VoidCallback? acceptAction;

//   const StylistOrderApprovalTile(
//       {Key? key,
//       required this.orderApproval,
//       this.acceptAction,
//       required this.declineAction})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//       // height: 230.h,
//       // width: 356.w,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         color: StyldColors.white,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               // mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   radius: 30.h,
//                   backgroundColor: StyldColors.blue,
//                   foregroundColor: StyldColors.blue,
//                   backgroundImage: AssetImage(orderApproval.imageUrl),
//                 ),
//                 SizedBox(width: 10.w),
//                 Flexible(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,

//                     // mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         orderApproval.name,
//                         style: GoogleFonts.roboto(textStyle: m_bl_18),
//                       ),
//                       SizedBox(
//                         height: 5.h,
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SvgPicture.asset(StyldImages.starIcon),
//                           SizedBox(width: 5.w),
//                           SvgPicture.asset(StyldImages.starIcon),
//                           SizedBox(width: 5.w),
//                           SvgPicture.asset(StyldImages.starIcon),
//                           SizedBox(width: 5.w),
//                           SvgPicture.asset(StyldImages.starIcon),
//                           SizedBox(width: 5.w),
//                           SvgPicture.asset(StyldImages.starIcon),
//                           SizedBox(width: 5.w),
//                           Text(
//                             orderApproval.rating,
//                             style: GoogleFonts.roboto(
//                               textStyle: TextStyle(
//                                 fontSize: 13.sp,
//                                 color: StyldColors.black,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Flexible(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,

//                     // mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Center(
//                         child: Text(
//                           'Appointment On',
//                           style: GoogleFonts.roboto(
//                             textStyle: TextStyle(
//                               fontSize: 8.sp,
//                               color: StyldColors.grey,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 5.h,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 5.w),
//                         height: 22.h,
//                         width: 125.w,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(3.0),
//                           color: StyldColors.blue,
//                         ),
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   SvgPicture.asset(StyldImages.smCalendarIcon),
//                                   SizedBox(
//                                     width: 5.w,
//                                   ),
//                                   Text(
//                                     orderApproval.date,
//                                     style: GoogleFonts.roboto(
//                                       textStyle: TextStyle(
//                                         fontSize: 7.sp,
//                                         color: StyldColors.white,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   SvgPicture.asset(StyldImages.smTimeIcon),
//                                   SizedBox(
//                                     width: 5.w,
//                                   ),
//                                   Text(
//                                     orderApproval.time,
//                                     style: GoogleFonts.roboto(
//                                       textStyle: TextStyle(
//                                         fontSize: 7.sp,
//                                         color: StyldColors.white,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ]),
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.end,

//                         // mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           SizedBox(
//                             height: 5.h,
//                           ),
//                           Center(
//                             child: Text(
//                               'Duration',
//                               style: GoogleFonts.roboto(
//                                 textStyle: TextStyle(
//                                   fontSize: 8.sp,
//                                   color: StyldColors.grey,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5.h,
//                           ),
//                           Center(
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 5.w),
//                               height: 22.h,
//                               width: 75.w,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(3.0),
//                                 color: StyldColors.blue,
//                               ),
//                               child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     SvgPicture.asset(
//                                         StyldImages.smCalendarIcon),
//                                     SizedBox(
//                                       width: 5.w,
//                                     ),
//                                     Text(
//                                       orderApproval.duration,
//                                       style: GoogleFonts.roboto(
//                                         textStyle: TextStyle(
//                                           fontSize: 7.sp,
//                                           color: StyldColors.white,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                     ),
//                                   ]),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             Row(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Service',
//                       style: GoogleFonts.roboto(textStyle: r_9_g),
//                     ),
//                     Text(
//                       orderApproval.service,
//                       style: GoogleFonts.roboto(textStyle: m_9_b),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   width: 20.w,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Price',
//                       style: GoogleFonts.roboto(textStyle: r_9_g),
//                     ),
//                     Text(
//                       '\$ ${orderApproval.price}',
//                       style: GoogleFonts.roboto(textStyle: m_9_b),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const Divider(thickness: 1.5, color: StyldColors.lightGrey),
//             Row(
//               children: [
//                 SvgPicture.asset(StyldImages.locationPointerSmall,
//                     color: StyldColors.lightGold),
//                 SizedBox(
//                   width: 5.w,
//                 ),
//                 Text(
//                   orderApproval.address,
//                   style: GoogleFonts.roboto(textStyle: r_10_b),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 5.h,
//             ),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 orderApproval.shortAddress,
//                 textAlign: TextAlign.start,
//                 style: GoogleFonts.roboto(textStyle: r_11_g),
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//               ApprovalButtonColor(
//                   color: StyldColors.grey.withOpacity(0.35),
//                   title: 'Decline',
//                   isBlack: true,
//                   action: declineAction),
//               ApprovalButtonColor(
//                   isBlack: false,
//                   color: StyldColors.lightGold,
//                   title: 'Approve',
//                   action: acceptAction),
//             ]),
//           ],
//         ),
//       ),
//     );
//   }
// }
