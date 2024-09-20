import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/stylistDetailed/stylist_details/stylist_detail_view_model.dart';

class ServicesView extends StatelessWidget {
  final StylistUser? stylistUser;
  ServicesView({this.stylistUser});

  @override
  Widget build(BuildContext context) {
    return Consumer<StylistDetailViewModel>(builder: (context, model, child) {
      return Column(children: [
        Expanded(
          child: ListView.builder(
              itemCount: model.stylistServices.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      color: StyldColors.white,
                      borderRadius: BorderRadius.circular(6.0)),
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: Row(children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: StyldColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          model.stylistServices[index].iconPath,
                          height: 40.h,
                        )),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      model.stylistServices[index].title,
                      style: r_16_gld,
                    )
                  ]),
                );
              }),
        ),
      ]);
    });
  }
}
