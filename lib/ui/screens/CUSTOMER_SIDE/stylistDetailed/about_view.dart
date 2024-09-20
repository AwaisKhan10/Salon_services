import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/ui/custom_widgets/user_review_tile.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/stylistDetailed/stylist_details/stylist_detail_view_model.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/stylistDetailed/stylist_review/customer_write_review_screen.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/accountScreen/map_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AboutView extends StatelessWidget {
  final StylistUser? stylistUser;
  // final isReviewAdded;
  // final totalRating;
  // final List<StylistReview>? stylistReviews;

  AboutView({
    this.stylistUser,
  });
  // this.stylistReviews,
  // this.isReviewAdded = false,
  // this.totalRating = 0.0});

  @override
  Widget build(BuildContext context) {
    return Consumer<StylistDetailViewModel>(builder: (context, model, child) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        child: ListView(
          children: [
            const Divider(
              thickness: 1.5,
              color: StyldColors.lightGrey,
            ),
            _descriptionSection(stylistUser!.aboutService ?? ''),
            const Divider(
              thickness: 1.5,
              color: StyldColors.lightGrey,
            ),
            _locationDetails(stylistUser!.address ?? ''),
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
                '${model.totalRating.toStringAsFixed(2)}',
                style: GoogleFonts.roboto(textStyle: b_51),
              ),
            ),

            /// rating bar
            ///
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBarIndicator(
                  rating: model.totalRating,
                  unratedColor: StyldColors.lightGrey,
                  itemBuilder: (context, index) => Image.asset(
                      '$staticAsset/star.png',
                      width: 30.w,
                      height: 30.h),
                  itemCount: 5,
                  itemSize: 30,
                  direction: Axis.horizontal,
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Center(
              child: Text(
                'based on ${model.stylistReviews.length} Reviews',
                style: GoogleFonts.roboto(textStyle: b_17),
              ),
            ),
            SizedBox(height: 5.h),
            const Divider(
              thickness: 1.5,
              color: StyldColors.lightGrey,
            ),
            SizedBox(height: 10.h),
            ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.stylistReviews.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: UserReviewTile(
                        stylistReview: model.stylistReviews[index],
                        model: model),
                  );
                }),

            SizedBox(height: 30.h),
            WidthButton(
                action: () async {
                  if (model.isReviewAdded) {
                    Get.snackbar(
                        'Aready added', 'You have already added review',
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: StyldColors.white);
                  } else {
                    model.stylistReviews = await Get.to(() =>
                            CustomerWriteReviewScreen(
                                stylistUser: stylistUser,
                                stylistReviews: model.stylistReviews)) ??
                        model.stylistReviews;
                    if (model.authService.stylistReviewsLength !=
                        model.stylistReviews.length) {
                      model.getStylistReviews(stylistUser!);
                    }
                    model.setState(ViewState.idle);
                  }
                },
                textColor: StyldColors.black,
                buttonColor: StyldColors.white,
                titleText: 'Write a Review',
                width: 383.w),
            SizedBox(height: 15.h),
          ],
        ),
      );
    });
  }

  _descriptionSection(String description) {
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
          '$description',
          style: GoogleFonts.roboto(textStyle: sw1),
        ),
      ],
    );
  }

  _locationDetails(String address) {
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
                '$address',
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
