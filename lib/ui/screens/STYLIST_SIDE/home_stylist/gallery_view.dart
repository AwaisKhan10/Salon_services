import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/repos/stylist_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      WidthButton(
          action: () {}, //=> Get.to(const UploadImage()),
          width: 340.w,
          buttonColor: StyldColors.lightGold,
          titleText: 'Upload Images'),
      SizedBox(
        height: 15.h,
      ),
      Expanded(
        child: MasonryGridView.count(
          crossAxisCount: 4,
          itemCount: stylistImages.length,
          itemBuilder: (BuildContext context, int index) =>
              // CustomStaggeredTile(
              //     imagePath: stylistImages[index].path,
              //     text: stylistImages[index].title),
              Container(
            margin: const EdgeInsets.all(3),
            padding: EdgeInsets.only(left: 5.w, bottom: 5.w),
            // height: 120.0.h,
            // width: 120.0.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(stylistImages[index].path),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.rectangle,
            ),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  stylistImages[index].title,
                  style: GoogleFonts.roboto(textStyle: robotoSmallBold),
                )),
          ),
          // staggeredTileBuilder: (int index) =>
          //     StaggeredTile.count(2, index.isEven ? 3 : 2),
          // mainAxisSpacing: 4.0,
          // crossAxisSpacing: 4.0,
        ),
      ),
    ]);
  }
}
