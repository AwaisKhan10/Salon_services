import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(StyldImages.mapBg),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: CustomScrollableView(
            widget: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: SvgPicture.asset(
                      StyldImages.backIcon,
                      color: StyldColors.black,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  height: 91.h,
                  margin: EdgeInsets.only(bottom: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Stack(children: [
                    Container(
                      height: 50.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7.0),
                          topRight: Radius.circular(7.0),
                        ),
                        color: StyldColors.blue,
                      ),
                      child: Center(
                        child: Row(children: [
                          SvgPicture.asset(StyldImages.myLocationIcon),
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Location',
                                style: GoogleFonts.roboto(textStyle: r_14),
                              ),
                              Text(
                                'Beauty Saloon Shop',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(textStyle: b_16),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 44.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                      height: 44.h,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(7.0),
                          bottomRight: Radius.circular(7.0),
                        ),
                        color: StyldColors.lightGold,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(StyldImages.clientLocationIcon),
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Client Location',
                                style: GoogleFonts.roboto(textStyle: r_14_b),
                              ),
                              Text(
                                'Carroll Street Subway, Smith St 2nd...',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(textStyle: b_16_b),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
