import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';

class WriteReviewScreen extends StatelessWidget {
  WriteReviewScreen({Key? key}) : super(key: key);

  final List<ValueNotifier> toggle = [
    ValueNotifier(false),
    ValueNotifier(false),
    ValueNotifier(false),
    ValueNotifier(false),
    ValueNotifier(false),
  ];
  final TextEditingController _reviewController = TextEditingController();

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
        title: Text(
          'Rate your experience about the client',
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
              children: [
                const Spacer(),
                SvgPicture.asset(
                  StyldImages.reviewBgIllustration,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'Hey There!',
                  style: GoogleFonts.roboto(textStyle: r_22),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'How was your experience at \nthe client service',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(textStyle: r_18),
                ),
                _fiveStarView(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: StyldColors.blue,
                    ),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: TextFormField(
                      controller: _reviewController,
                      style: GoogleFonts.roboto(textStyle: r_17),
                      cursorColor: StyldColors.white,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: "Share Your Experience...",
                        hintStyle: GoogleFonts.roboto(
                            textStyle:
                                r_17.copyWith(color: StyldColors.lightGrey)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                WidthButton(
                    buttonColor: StyldColors.lightGold,
                    buttonColor2: StyldColors.darkGold,
                    titleText: 'SUBMIT',
                    width: 356.w),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _fiveStarView() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 5; i++)
              ValueListenableBuilder(
                valueListenable: toggle[i],
                builder: (context, hasError, child) {
                  return IconButton(
                      icon: toggle[i].value
                          ? const Icon(
                              Icons.star,
                              color: StyldColors.lightGold,
                              size: 50,
                            )
                          : const Icon(
                              Icons.star_border_outlined,
                              color: StyldColors.lightGold,
                              size: 50,
                            ),
                      onPressed: () {
                        if (toggle[i].value) {
                          toggle[i].value = false;
                        } else {
                          toggle[i].value = true;
                        }
                      });
                },
              ),
          ],
        ),
      ),
    );
  }
}
