import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/ui/custom_widgets/customer_side_widgets/icon_textfield.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_home/all_stylist/all_stylist_view_model.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/stylistDetailed/stylist_details/stylist_detailed_screen.dart';

class AllStylistsScreen extends StatelessWidget {
  final String service;
  final List<StylistUser>? stylists;

  AllStylistsScreen(this.service, {this.stylists});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AllStylistViewModel(service, stylists: stylists),
      child: Consumer<AllStylistViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: StyldColors.black,
              elevation: 0.0,
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: SvgPicture.asset(StyldImages.backIcon),
              ),
              title: Text(
                stylists == null ? '$service' : "All Sylists",
                style: GoogleFonts.roboto(textStyle: r_22),
              ),
              centerTitle: true,
            ),
            body: Container(
              child: Column(
                children: [
                  stylists == null
                      ? Container()
                      : IconTextField(
                          onChange: (value) {
                            model.searchStylists(value);
                          },
                          action: () => null,
                          //  Get.to(() => BeautySaloonSearchScreen()),
                          controller: model.searchController,
                          title: 'Search stylists by service',
                          iconPath: StyldImages.searchIcon),
                  stylists == null
                      ? Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Get.to(() => StylistDetailedScreen(
                                    stylistUser: model.stylists[index])),
                                child: stylistTile(model.stylists[index]),
                              );
                            },
                            itemCount: model.stylists.length,
                          ),
                        )
                      : model.isSearching
                          ? stylistsList(model.searchedStylists)
                          : stylistsList(stylists!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  stylistsList(List<StylistUser> stylists) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Get.to(
                () => StylistDetailedScreen(stylistUser: stylists[index])),
            child: stylistTile(stylists[index]),
          );
        },
        itemCount: stylists.length,
      ),
    );
  }

  Widget stylistTile(StylistUser stylistUser) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 85,
            height: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(stylistUser.imgUrl!),
              ),
            ),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 5.h),
                  Text(
                    '${stylistUser.fullName}',
                    style: GoogleFonts.roboto(textStyle: b_16),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    '${stylistUser.salonType}',
                    style: GoogleFonts.roboto(textStyle: r_14),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      SvgPicture.asset(StyldImages.locationPointerSmall),
                      SizedBox(
                        width: 5.w,
                      ),
                      Flexible(
                        child: Text(
                          '${stylistUser.address}',
                          style: GoogleFonts.roboto(textStyle: r_11_g),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Rating: ',
                        style: GoogleFonts.roboto(textStyle: m_14),
                      ),
                      RatingBarIndicator(
                        rating: stylistUser.rating!,
                        unratedColor: StyldColors.lightGrey,
                        itemBuilder: (context, index) => Image.asset(
                            '$staticAsset/star.png',
                            width: 18.w,
                            height: 18.h),
                        itemCount: 5,
                        itemSize: 18,
                        direction: Axis.horizontal,
                      ),
                      Text(
                        '  (${stylistUser.rating!.toStringAsFixed(2)})',
                        style: GoogleFonts.roboto(textStyle: m_14),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: const Divider(
                      thickness: 1.0,
                      color: StyldColors.lightGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
