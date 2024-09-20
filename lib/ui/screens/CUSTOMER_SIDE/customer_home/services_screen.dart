import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/ui/custom_widgets/customer_side_widgets/beauty_saloon_tile.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_home/all_stylist/all_stylist_screen.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_home/home_customer_viewmodel.dart';

class ServicesScreen extends StatelessWidget {
  final CustomerHomeViewModel model;
  ServicesScreen(this.model);

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
          'All Services',
          style: GoogleFonts.roboto(textStyle: r_22),
        ),
        centerTitle: true,
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Get.to(
                      () => AllStylistsScreen(model.services[index].name)),
                  child: BeautySaloonTile(model.services[index]),
                );
              },
              itemCount: model.services.length,
            ),
          ),
        ],
      ),
    );
  }
}
