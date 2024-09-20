import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/repos/reviews_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/ui/custom_widgets/user_review_tile.dart';

class UserRatingsView extends StatelessWidget {
  const UserRatingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          RatingBarIndicator(
            rating: 4.0,
            unratedColor: StyldColors.lightGrey,
            itemBuilder: (context, index) =>
                Image.asset('$staticAsset/star.png', width: 22.w, height: 22.h),
            itemCount: 5,
            itemSize: 24,
            direction: Axis.horizontal,
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
          // for (var item in reviewsList) UserReviewTile(userReview: item)
        ]);
  }
}
