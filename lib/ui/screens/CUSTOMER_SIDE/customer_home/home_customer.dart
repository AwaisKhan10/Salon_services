import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/model/customer_side_models/app_banners.dart';
import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
import 'package:styld_stylist/ui/custom_widgets/customer_side_widgets/icon_textfield.dart';
import 'package:styld_stylist/ui/custom_widgets/customer_side_widgets/popular_stylists_tile.dart';
import 'package:styld_stylist/ui/custom_widgets/customer_side_widgets/services_tile.dart';
import 'package:styld_stylist/ui/custom_widgets/sliding_indicatiors.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/beautySaloonSearch/beauty_saloon_search_screen.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_account/customer_all_notifications_screen.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_home/home_customer_viewmodel.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/stylistDetailed/stylist_details/stylist_detailed_screen.dart';
import 'package:styld_stylist/ui/screens/stylist_side/accountScreen/all_notifications_view.dart';
import 'all_stylist/all_stylist_screen.dart';
import 'services_screen.dart';

class HomeCustomerScreen extends StatelessWidget {
  HomeCustomerScreen({Key? key}) : super(key: key);
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomerHomeViewModel(),
      child: Consumer<CustomerHomeViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: const Color(0xFF0C0C0C),
            appBar: AppBar(
              title: Text(
                'Home',
                style: GoogleFonts.roboto(textStyle: r_16),
              ),
              centerTitle: true,
              actions: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  child: IconButton(
                      onPressed: () =>
                          Get.to(() => CustomerAllNotificationsScreen()),
                      icon: SvgPicture.asset(StyldImages.notificationIcon)),
                ),
              ],
              elevation: 2.0,
              backgroundColor: StyldColors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
            ),
            body: SafeArea(
              child: CustomScrollableView(
                coverWholeWidth: true,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///
                    /// banner slider images
                    ///
                    _banner(context, model),

                    ///
                    /// services
                    ///
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 30.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Services',
                                  style: GoogleFonts.roboto(textStyle: b_20),
                                ),
                              ),
                              InkWell(
                                onTap: () =>
                                    Get.to(() => ServicesScreen(model)),
                                child: Text(
                                  'View All',
                                  style: GoogleFonts.roboto(textStyle: b_16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 65.h,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return ServicesTile(
                                    action: () => Get.to(() =>
                                        AllStylistsScreen(
                                            model.services[index].name)),
                                    imagePath:
                                        '${model.services[index].imagePath}',
                                    title: '${model.services[index].name}');
                              },
                              itemCount: model.services.length,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 10.w, right: 10.w, top: 0.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Popular Stylists',
                                  style: GoogleFonts.roboto(textStyle: b_20),
                                ),
                              ),
                              InkWell(
                                onTap: () => Get.to(() => AllStylistsScreen(
                                    'Waxing & other',
                                    stylists: model.authService.stylistUsers)),
                                // showDialog(
                                //     barrierDismissible: false,
                                //     context: context,
                                //     builder: (context) =>
                                //         const ServiceCompletedDialog()),
                                child: Text(
                                  'View All',
                                  style: GoogleFonts.roboto(textStyle: b_16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 140.h,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return PopularStylistTile(
                                    action: () => Get.to(() =>
                                        StylistDetailedScreen(
                                            stylistUser: model.authService
                                                .stylistUsers[index])),
                                    imagePath: model.authService
                                        .stylistUsers[index].imgUrl!,
                                    title: model.authService.stylistUsers[index]
                                        .fullName!);
                              },
                              itemCount: model.authService.stylistUsers.length,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _banner(context, CustomerHomeViewModel model) {
    return Stack(
      children: [
        ImageSlider(images: model.authService.banners, model: model),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: IconTextField(
                        readOnly: true,
                        action: () => Get.to(() => BeautySaloonSearchScreen()),
                        controller: _searchController,
                        title: 'Search for salons & Services',
                        iconPath: StyldImages.searchIcon,
                      ),
                    ),
                    // InkWell(
                    //     onTap: () => null, //Get.to(() => FilterSearchScreen()),
                    //     child: SvgPicture.asset(StyldImages.filterIcon)),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(StyldImages.locationPointerSmall),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Text(
                        '${model.currentLocation}',
                        style: GoogleFonts.roboto(textStyle: regular),
                      ),
                    ),
                    // Text(
                    //   'Nearby',
                    //   style: GoogleFonts.roboto(textStyle: r_16),
                    // ),
                  ],
                ),
                // SizedBox(
                //   height: 35.h,
                // ),
                // Text(
                //   'Makeup & Parlor',
                //   style: GoogleFonts.roboto(textStyle: b_16),
                // ),
                // SizedBox(
                //   height: 20.h,
                // ),
                // Text(
                //   'Avail 40% Discount for Makeup and Parlour Service',
                //   textAlign: TextAlign.center,
                //   style: GoogleFonts.roboto(textStyle: b_25),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class ImageSlider extends StatefulWidget {
  final List<AppBanners> images;
  final CustomerHomeViewModel model;
  ImageSlider({required this.images, required this.model});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 270.h,
          child: PageView.builder(
              controller: widget.model.pageController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.images.length,
              onPageChanged: (int index) {
                setState(() {
                  widget.model.currentImage = index;
                });
              },
              itemBuilder: (context, index) {
                return FadeInImage.assetNetwork(
                  placeholder: '$staticAsset/placeholder.png',
                  image: '${widget.images[index].imageUrl}',
                  fit: BoxFit.cover,
                );
                // Image.network('${widget.images![index]}',
                //     fit: BoxFit.contain));
              }),
        ),

        ///
        /// Indication Dots
        ///
        Positioned(
          top: 250.h,
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 20.h,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: widget.images.length,
                        itemBuilder: (context, index) {
                          return SlidingIndicationDots(
                            index: index,
                            currentImage: widget.model.currentImage,
                          );
                        })),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
