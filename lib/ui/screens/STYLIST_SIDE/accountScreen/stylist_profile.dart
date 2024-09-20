import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
import 'package:styld_stylist/ui/custom_widgets/stylist_side_widgets/left_width_button.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/accountScreen/write_review_screen.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/chatScreen/conversation_screen.dart';

import 'map_screen.dart';

class StylistProfile extends StatelessWidget {
  const StylistProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyldColors.black,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(StyldImages.backIcon),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          child: CustomScrollableView(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 45,
                      backgroundColor: StyldColors.black,
                      foregroundColor: StyldColors.black,
                      backgroundImage: AssetImage(
                        StyldImages.hairDresser3,
                      ),
                    ),
                    title: Text(
                      'Sophia Amelia',
                      style: GoogleFonts.roboto(textStyle: b_25),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Center(
                  child: LeftWidthButton(
                    action: () => Get.to(() => const ConversationScreen()),
                    icon: StyldImages.messageIcon,
                    title: 'Message',
                    color: StyldColors.white,
                    textColor: StyldColors.black,
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  'About',
                  style: GoogleFonts.roboto(textStyle: b_18),
                ),
                const Divider(
                  thickness: 1.5,
                  color: StyldColors.lightGrey,
                ),
                _descriptionSection(),
                const Divider(
                  thickness: 1.5,
                  color: StyldColors.lightGrey,
                ),
                _locationDetails(),
                const Divider(
                  thickness: 1.5,
                  color: StyldColors.lightGrey,
                ),
                SizedBox(height: 5.h),
                Text(
                  'Reviews',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(textStyle: b_20),
                ),
                SizedBox(height: 15.h),
                Center(
                  child: Text(
                    '4.9',
                    style: GoogleFonts.roboto(textStyle: b_51),
                  ),
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        child: SvgPicture.asset(StyldImages.filledStarIcon)),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        child: SvgPicture.asset(StyldImages.filledStarIcon)),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        child: SvgPicture.asset(StyldImages.filledStarIcon)),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        child: SvgPicture.asset(StyldImages.filledStarIcon)),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        child: SvgPicture.asset(StyldImages.unfilledStarIcon)),
                  ],
                ),
                SizedBox(height: 5.h),
                Center(
                  child: Text(
                    'based on 43 Reviews',
                    style: GoogleFonts.roboto(textStyle: b_17),
                  ),
                ),
                SizedBox(height: 5.h),
                const Divider(
                  thickness: 1.5,
                  color: StyldColors.lightGrey,
                ),
                // for (var item in reviewsList) UserReviewTile(userReview: item),
                WidthButton(
                    action: () => Get.to(() => WriteReviewScreen()),
                    textColor: StyldColors.black,
                    buttonColor: StyldColors.white,
                    titleText: 'Write a Review',
                    width: 383.w),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _descriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: GoogleFonts.roboto(textStyle: h4),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis magna justo, scelerisque et euismod sit amet, eifend quis magna. Sed fringilla, est at volutpat sodales, nisl eros t tique sapien, ut gravida urna lorem a odio. Read more...',
          style: GoogleFonts.roboto(textStyle: sw1),
        ),
      ],
    );
  }

  _locationDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location Details',
          style: GoogleFonts.roboto(textStyle: h4),
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
            Expanded(
              child: Text(
                '23 St, Mall Road Near Ware House New York, United States',
                style: GoogleFonts.roboto(textStyle: regular),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            InkWell(
                onTap: () => Get.to(() => const MapScreen()),
                child: SvgPicture.asset(StyldImages.sendAddressIcon)),
          ],
        ),
      ],
    );
  }
}
