import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/model/pricing_model.dart';

class PricingDetailsTile extends StatelessWidget {
  // final PricingModel pricing;
  // const PricingDetailsTile({Key? key, required this.pricing}) : super(key: key);
  final onDescriptionSaved;
  final validator;
  final type;
  final onPriceSaved;
  PricingDetailsTile(
      {this.onDescriptionSaved, this.validator, this.onPriceSaved, this.type});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.0),
        color: StyldColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "$type",
              style: GoogleFonts.roboto(textStyle: r_18_b),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Package Price',
                style: GoogleFonts.lato(textStyle: b_13_b),
              ),
              SizedBox(
                width: 10.w,
              ),
              Container(
                height: 28.h,
                width: 38.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  color: StyldColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  // child: Text(
                  //   '\$ ${pricing.price}',
                  //   style: GoogleFonts.lato(textStyle: r_14_b),
                  // ),
                  child: TextFormField(
                    onSaved: onPriceSaved,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 8, left: 0),
                        border: InputBorder.none,
                        hintText: "\$0"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Package Details',
            style: GoogleFonts.lato(textStyle: b_13_b),
          ),
          Container(
              // height: 70.h,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: StyldColors.grey.withOpacity(0.33),
                ),
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: TextFormField(
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 13.sp,
                      color: StyldColors.black,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  validator: validator,
                  onSaved: onDescriptionSaved,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Description"))
              // Text(
              //   pricing.details,
              //   maxLines: 5,
              //   style: GoogleFonts.lato(
              //     textStyle: TextStyle(
              //       overflow: TextOverflow.ellipsis,
              //       fontSize: 13.sp,
              //       color: StyldColors.black,
              //       fontWeight: FontWeight.w500,
              //       fontStyle: FontStyle.italic,
              //     ),
              //   ),
              // ),
              ),
        ],
      ),
    );
  }
}
