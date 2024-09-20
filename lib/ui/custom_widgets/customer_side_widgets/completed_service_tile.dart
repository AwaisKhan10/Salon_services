import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/model/customer_side_models/beauty_saloon_model.dart';
import 'package:styld_stylist/ui/custom_widgets/left_nexticon.dart';

class CompletedServiceTile extends StatelessWidget {
  final BeautySaloonModel beautySaloonModel;
  final VoidCallback? ratingAction;

  const CompletedServiceTile(
      {Key? key, required this.beautySaloonModel, this.ratingAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: 227,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: StyldColors.lightGrey.withOpacity(0.1),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 81,
                    height: 87,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(StyldImages.bannerImageHome),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 5.h),
                          Text(
                            beautySaloonModel.name,
                            style: GoogleFonts.roboto(textStyle: b_16_b),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            beautySaloonModel.type,
                            style: GoogleFonts.roboto(textStyle: r_12_b),
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              SvgPicture.asset(
                                StyldImages.locationPointerSmall,
                                color: StyldColors.black,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Flexible(
                                child: Text(
                                  beautySaloonModel.address,
                                  style: GoogleFonts.roboto(textStyle: r_11_g),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(StyldImages.smStarIcon),
                              SvgPicture.asset(StyldImages.smStarIcon),
                              SvgPicture.asset(StyldImages.smStarIcon),
                              SvgPicture.asset(StyldImages.smStarIcon),
                              SvgPicture.asset(StyldImages.smStarIcon),
                              Text(
                                beautySaloonModel.ratings,
                                style: GoogleFonts.roboto(textStyle: b_13_gld),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                child: const Divider(
                  thickness: 1.0,
                  color: StyldColors.lightGrey,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Lorem ipsum dolor sit amet, consecte tur adipiscing elit. Duis magna justo,sce le risque et euismod sit amet, eleifend quis magna...',
                style: GoogleFonts.roboto(textStyle: r_16_b),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        LeftNextIconButton(
            action: ratingAction ?? () {},
            icon: StyldImages.writeReviewIcon,
            title: 'Rate Service Now'),
        TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Remind me Later',
              style: GoogleFonts.roboto(textStyle: r_16_b),
            ))
      ],
    );
  }
}
