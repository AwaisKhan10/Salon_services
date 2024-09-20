import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/model/stylist_reviews.dart';
import 'package:styld_stylist/ui/custom_widgets/circle_image_placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/stylistDetailed/stylist_details/stylist_detail_view_model.dart';

class UserReviewTile extends StatelessWidget {
  final StylistReview? stylistReview;
  final StylistDetailViewModel? model;
  UserReviewTile({this.stylistReview, this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      // height: .h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              stylistReview!.customerUser!.imageUrl == null
                  ? CircleImagePlaceholder(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/3.png'))
                  : CircleImagePlaceholder(
                      radius: 20,
                      backgroundImage:
                          NetworkImage(stylistReview!.customerUser!.imageUrl!)),
              SizedBox(width: 5.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5.w),
                    child: Text(
                      '${stylistReview!.customerUser!.name}',
                      style: GoogleFonts.roboto(textStyle: b_16),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    width: 0.73.sw,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          RatingBarIndicator(
                            rating: stylistReview!.rating ?? 0.0,
                            unratedColor: StyldColors.lightGrey,
                            itemBuilder: (context, index) => Image.asset(
                                '$staticAsset/star.png',
                                width: 18.w,
                                height: 18.h),
                            itemCount: 5,
                            itemSize: 18,
                            direction: Axis.horizontal,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            '${stylistReview!.rating}',
                            style: GoogleFonts.roboto(textStyle: b_16),
                          ),
                        ]),
                        Text('${timeago.format(stylistReview!.createdAt!)}',
                            style: GoogleFonts.roboto(textStyle: b_12)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Text('${stylistReview!.reviewText}',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(textStyle: r_16)),
        ],
      ),
    );
  }
}
