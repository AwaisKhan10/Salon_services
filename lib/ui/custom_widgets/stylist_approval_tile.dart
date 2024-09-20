import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/model/stylist_approval_model.dart';
import 'package:styld_stylist/ui/custom_widgets/price_tag.dart';

class StylistApprvalTile extends StatelessWidget {
  final StylistApprovalModel stylistApproval;
  final VoidCallback? approveAction;
  final VoidCallback? rejectAction;
  const StylistApprvalTile(
      {Key? key,
      required this.stylistApproval,
      this.approveAction,
      this.rejectAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      height: 210.h,
      width: 356.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.0),
        color: StyldColors.blue,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 45.h,
                  backgroundColor: StyldColors.blue,
                  foregroundColor: StyldColors.blue,
                  backgroundImage: AssetImage(stylistApproval.imageUrl),
                ),
                SizedBox(width: 10.w),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stylistApproval.title,
                        style: GoogleFonts.roboto(textStyle: headerText),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(StyldImages.locationPointerSmall),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            stylistApproval.address,
                            style: GoogleFonts.roboto(textStyle: o3),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Pricing',
                        style: GoogleFonts.roboto(textStyle: h2),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            PriceTag(
                                packageName: 'Basic',
                                packagePrice:
                                    '${stylistApproval.basicPackagePrice}\$'),
                            PriceTag(
                                packageName: 'Standard',
                                packagePrice:
                                    '${stylistApproval.standardPackagePrice}\$'),
                            PriceTag(
                                packageName: 'Premium',
                                packagePrice:
                                    '${stylistApproval.premiumPackagePrice}\$'),
                          ]),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Certificate',
                        style: GoogleFonts.roboto(textStyle: h2),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        width: 64.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          color: StyldColors.lightGold,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(StyldImages.certificateIcon),
                              Text(
                                'View File',
                                style: GoogleFonts.roboto(textStyle: sw),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 1.0,
              color: StyldColors.grey,
            ),
            IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: approveAction ?? () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(StyldImages.tickIcon),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            'Approve',
                            style: GoogleFonts.roboto(textStyle: h1),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(
                      color: StyldColors.grey,
                      thickness: 1.0,
                    ),
                    InkWell(
                      onTap: rejectAction ?? () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(StyldImages.crossIcon),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            'Reject',
                            style: GoogleFonts.roboto(textStyle: h1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
