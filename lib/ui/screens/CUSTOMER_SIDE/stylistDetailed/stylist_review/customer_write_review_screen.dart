import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/core/model/stylist_reviews.dart';
import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
import 'package:styld_stylist/ui/custom_widgets/customer_side_widgets/tip_button.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'customer_add_review_provider.dart';

class CustomerWriteReviewScreen extends StatelessWidget {
  final StylistUser? stylistUser;
  final List<StylistReview>? stylistReviews;
  CustomerWriteReviewScreen({this.stylistUser, this.stylistReviews});

  final TextEditingController _reviewController = TextEditingController();
  final List<ValueNotifier> _values = [
    ValueNotifier(false),
    ValueNotifier(false),
    ValueNotifier(false),
  ];
  final List<String> _tips = ['10', '30', '50'];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomerAddReviewProvider(),
      child: Consumer<CustomerAddReviewProvider>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: StyldColors.black,
                elevation: 0.0,
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: SvgPicture.asset(StyldImages.backIcon),
                ),
                title: Text(
                  'Review about the stylist service',
                  style: GoogleFonts.roboto(textStyle: r_16),
                ),
                centerTitle: true,
              ),
              body: Container(
                margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SafeArea(
                  child: CustomScrollableView(
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 35.h,
                        ),
                        Center(
                          child: SvgPicture.asset(
                            StyldImages.customerReviewIllustration,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBar(
                                itemSize: 45,
                                itemPadding: EdgeInsets.only(right: 9.0),
                                ratingWidget: RatingWidget(
                                  empty: Image.asset('$staticAsset/empty.png',
                                      width: 47.5.w, height: 47.1.h),
                                  half: Image.asset(
                                      '$staticAsset/full_star.png',
                                      width: 47.5.w,
                                      height: 47.1.h),
                                  full: Image.asset(
                                      '$staticAsset/full_star.png',
                                      width: 47.5.w,
                                      height: 47.1.h),
                                ),
                                itemCount: 5,
                                glowColor: StyldColors.darkGold,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                onRatingUpdate: (value) {
                                  model.stylistReview.rating = value;
                                }),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Center(
                          child: Text(
                            'How was your experience at the\nmake up beauty salon?',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(textStyle: r_18),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          'Write your Review',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              color: StyldColors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              // width: MediaQuery.of(context).size.width * 0.85,
                              margin: EdgeInsets.symmetric(vertical: 5.h),
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: StyldColors.blue,
                              ),
                              child: AutoSizeTextField(
                                onChanged: (value) {
                                  model.stylistReview.reviewText = value;
                                },
                                keyboardType: TextInputType.multiline,
                                controller: _reviewController,
                                minLines:
                                    1, //Normal textInputField will be displayed
                                maxLines: 6,
                                style: GoogleFonts.roboto(textStyle: r_17),
                                cursorColor: StyldColors.white,
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  hintText: "Write your Review here....",
                                  hintStyle: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.italic)
                                          .copyWith(
                                              color: StyldColors.lightGrey)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Center(
                          child: Text(
                            'Add a tip for the Olevia Ann!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(textStyle: m_18),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: TipButton(
                                  value: _values[0],
                                  iconPath: StyldImages.tip1Icon,
                                  price: _tips[0]),
                            ),
                            Flexible(
                              child: TipButton(
                                  value: _values[1],
                                  iconPath: StyldImages.tip2Icon,
                                  price: _tips[1]),
                            ),
                            Flexible(
                              child: TipButton(
                                  value: _values[2],
                                  iconPath: StyldImages.tip3Icon,
                                  price: _tips[2]),
                            ),
                          ],
                        ),
                        WidthButton(
                            action: () {
                              model.addStylistReview(
                                  stylistUser!, stylistReviews);
                            },
                            buttonColor: StyldColors.lightGold,
                            buttonColor2: StyldColors.darkGold,
                            titleText: 'Submit review',
                            width: 356.w),
                        // const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
