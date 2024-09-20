import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/ui/custom_widgets/stylist_side_widgets/tag_button.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/payment_section/select_service_view.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/stylistDetailed/customer_chat/customer_conversation_screen.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/stylistDetailed/stylist_details/stylist_detail_view_model.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/stylistDetailed/stylist_gallery_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../about_view.dart';
import '../customer_chat/customer_conversation_screen.dart';
import '../services_view.dart';

class StylistDetailedScreen extends StatefulWidget {
  final StylistUser? stylistUser;
  StylistDetailedScreen({this.stylistUser});

  @override
  State<StylistDetailedScreen> createState() => _AccountSettingsViewState();
}

class _AccountSettingsViewState extends State<StylistDetailedScreen> {
  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width);
    return ChangeNotifierProvider(
      create: (context) => StylistDetailViewModel(widget.stylistUser!),
      child: Consumer<StylistDetailViewModel>(builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: Scaffold(
            body: SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: [
                    ///
                    /// profile background and foreground images
                    ///
                    profileImagesArea(model),
                    Column(
                      children: [
                        Text(
                          '${widget.stylistUser!.address ?? ''}',
                          textAlign: TextAlign.center,
                          style: r_16_g,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(StyldImages.thumbsUpIcon),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              widget.stylistUser!.rating == null
                                  ? '0.00'
                                  : '${widget.stylistUser!.rating!.toStringAsFixed(2)} Rating - ${widget.stylistUser!.salonType}',
                              textAlign: TextAlign.center,
                              style: b_11,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),

                        ///
                        /// service tags
                        ///
                        _tagView(),
                        SizedBox(height: 20.h),

                        ///
                        /// appointment button
                        WidthButton(
                            action: () {
                              model.authService.bookingStylist =
                                  widget.stylistUser!;
                              model.authService.bookingPrice =
                                  model.pricingDetails!;
                              model.authService.bookingServices =
                                  model.stylistServices;
                              Get.to(() => SelectServiceView());
                            },
                            buttonColor: StyldColors.lightGold,
                            buttonColor2: StyldColors.darkGold,
                            titleText: 'Book Appointment Now',
                            width: MediaQuery.of(context).size.width * 0.90),
                        SizedBox(height: 10.h),

                        ///
                        /// pricing area
                        Text(
                          'Pricing',
                          textAlign: TextAlign.center,
                          style: b_17,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),

                        ///
                        /// Pricing details
                        ///
                        pricingDetails(model),

                        ///
                        /// About the stylist and his services
                        ///
                        DefaultTabController(
                          length: 3,
                          child: SizedBox(
                            height: 500,
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  height: 50.h,
                                  child: const TabBar(
                                    indicatorColor: StyldColors.gold,
                                    tabs: [
                                      Tab(
                                        text: "About",
                                      ),
                                      Tab(
                                        text: "Services",
                                      ),
                                      Tab(
                                        text: "Gallery",
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: TabBarView(
                                      children: [
                                        AboutView(
                                            stylistUser: widget.stylistUser),
                                        ServicesView(
                                            stylistUser: widget.stylistUser),
                                        StylistGalleryView(model.gallery),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                    // Spacer(),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  pricingDetails(StylistDetailViewModel model) {
    return DefaultTabController(
      length: 3,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        height: 490.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.0),
          color: StyldColors.blue,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              height: 50.h,
              child: const TabBar(
                indicatorColor: StyldColors.gold,
                tabs: [
                  Tab(
                    text: "Basic",
                  ),
                  Tab(
                    text: "Standard",
                  ),
                  Tab(
                    text: "Premium",
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                // height: MediaQuery.of(context).size.height * 0.35,
                padding: EdgeInsets.only(top: 10.h),
                child: TabBarView(
                  children: [
                    _priceOption(
                        price: '${model.pricingDetails!.basicPrice}',
                        details: '${model.pricingDetails!.basicDetails}',
                        model: model,
                        action: () {
                          model.authService.bookingStylist =
                              widget.stylistUser!;
                          model.authService.bookingPrice =
                              model.pricingDetails!;
                          model.authService.bookingServices =
                              model.stylistServices;
                          Get.to(() => SelectServiceView(
                              price: model.pricingDetails!.basicPrice));
                        }),
                    _priceOption(
                        price: '${model.pricingDetails!.standardPrice}',
                        details: '${model.pricingDetails!.standardDetails}',
                        model: model,
                        action: () {
                          model.authService.bookingStylist =
                              widget.stylistUser!;
                          model.authService.bookingPrice =
                              model.pricingDetails!;
                          model.authService.bookingServices =
                              model.stylistServices;
                          Get.to(() => SelectServiceView(
                              price: model.pricingDetails!.standardPrice));
                        }),
                    _priceOption(
                        price: '${model.pricingDetails!.premiumPrice}',
                        details: '${model.pricingDetails!.premiumDetails}',
                        model: model,
                        action: () {
                          model.authService.bookingStylist =
                              widget.stylistUser!;
                          model.authService.bookingPrice =
                              model.pricingDetails!;
                          model.authService.bookingServices =
                              model.stylistServices;
                          Get.to(() => SelectServiceView(
                              price: model.pricingDetails!.premiumPrice));
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  profileImagesArea(StylistDetailViewModel model) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              PreferredSize(
                preferredSize: Size.fromHeight(100.h),
                child: AppBar(
                  leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: SvgPicture.asset(StyldImages.backIcon),
                  ),

                  ///
                  /// background image
                  flexibleSpace: Container(
                    height: 200.h,
                    decoration: widget.stylistUser!.backgroundImgUrl == null
                        ? const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(StyldImages.headerImage),
                            ),
                          )
                        : BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    widget.stylistUser!.backgroundImgUrl!)),
                          ),
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
              // Positioned(
              //   left: MediaQuery.of(context).size.width * 0.75,
              //   top:
              //       MediaQuery.of(context).size.height * 0.2448,
              //   child:
              //       SvgPicture.asset(StyldImages.dottedIcons),
              // ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.19,
                child: CircleAvatar(
                  radius: 60.h,
                  backgroundColor: StyldColors.black,
                  foregroundColor: StyldColors.black,
                  backgroundImage: NetworkImage(widget.stylistUser!.imgUrl!),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.140,
                top: MediaQuery.of(context).size.height * 0.29,
                child: Column(
                  children: [
                    InkWell(
                        onTap: () => Get.to(() =>
                            CustomerConversationScreen(widget.stylistUser!)),
                        child: SvgPicture.asset(StyldImages.chatIcon)),
                    Text(
                      'Message',
                      style: r_12,
                    ),
                  ],
                ),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * 0.135,
                top: MediaQuery.of(context).size.height * 0.29,
                child: Column(
                  children: [
                    InkWell(
                        onTap: () {
                          model.authService.bookingStylist =
                              widget.stylistUser!;
                          model.authService.bookingPrice =
                              model.pricingDetails!;
                          model.authService.bookingServices =
                              model.stylistServices;
                          Get.to(() => SelectServiceView());
                        },
                        child: SvgPicture.asset(StyldImages.moreIcon)),
                    Text(
                      'New Booking',
                      style: r_12,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.37,
            child: Text(
              '${widget.stylistUser!.fullName}',
              // widget.stylistUser!.aboutService != null
              //     ? '${widget.stylistUser!.aboutService!.length > 20 ? widget.stylistUser!.aboutService!.substring(0, 19) : widget.stylistUser!.aboutService}'
              //     : '',
              textAlign: TextAlign.center,
              style: b_18,
            ),
          ),
        ],
      ),
    );
  }

  _priceOption(
      {required String price,
      String? details,
      action,
      required StylistDetailViewModel model}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 15, right: 15, bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView(
            shrinkWrap: true,
            primary: false,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: StyldColors.black,
                foregroundColor: StyldColors.black,
                child: Text(
                  '$price\nDollars',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                    fontSize: 26.sp,
                    color: StyldColors.lightGold,
                    fontWeight: FontWeight.w700,
                  )),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Container(
                    height: 15.h,
                    width: 15.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: StyldColors.lightGold),
                  ),
                  SizedBox(width: 10.h),
                  Flexible(
                    child: Text('$details',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            overflow: TextOverflow.clip,
                            color: StyldColors.white,
                            fontSize: 15.sp)),
                  )
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
          WidthButton(
              action: action,
              buttonColor: StyldColors.white,
              titleText: 'Choose',
              textColor: StyldColors.black,
              width: 137),
        ],
      ),
    );
  }

  _tagView() {
    return Container(
      // height: 100.h,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
          border: Border.all(color: StyldColors.lightGrey),
          borderRadius: BorderRadius.circular(5)),
      child: widget.stylistUser!.tags != null
          ? Wrap(
              direction: Axis.horizontal,
              children: List.generate(
                widget.stylistUser!.tags!.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TagButton(
                      tagValue: '${widget.stylistUser!.tags![index].label}',
                      selected: true,
                      callback: () => null),
                ),
              ),
            )
          : Container(),
    );
  }
}
