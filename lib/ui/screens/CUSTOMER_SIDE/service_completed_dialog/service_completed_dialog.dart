import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/model/customer_side_models/beauty_saloon_model.dart';
import 'package:styld_stylist/ui/custom_widgets/customer_side_widgets/completed_service_tile.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/stylistDetailed/stylist_review/customer_write_review_screen.dart';

class ServiceCompletedDialog extends StatelessWidget {
  const ServiceCompletedDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      // title: const Text('AlertDialog Title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Get.back(),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  child: SvgPicture.asset(
                    StyldImages.crossIcon,
                    color: StyldColors.black,
                  ),
                ),
              ),
            ),
            Text(
              'Your Appointment With Stylist has been completed',
              textAlign: TextAlign.center,
              style: r_18_b,
            ),
            CompletedServiceTile(
              beautySaloonModel: beautySaloonsList[1],
              ratingAction: () => Get.off(() => CustomerWriteReviewScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
