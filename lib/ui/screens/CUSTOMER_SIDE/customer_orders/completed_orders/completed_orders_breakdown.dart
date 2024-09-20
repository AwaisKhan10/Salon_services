import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/core/repos/stylist_approval_data.dart';
import 'package:styld_stylist/core/repos/stylist_order_approval_list.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/stylistDetailed/customer_chat/customer_conversation_screen.dart';

class CompletedOrdersBreakdown extends StatefulWidget {
  const CompletedOrdersBreakdown({Key? key}) : super(key: key);

  @override
  State<CompletedOrdersBreakdown> createState() =>
      _UpcomingOrdersBreakdownState();
}

class _UpcomingOrdersBreakdownState extends State<CompletedOrdersBreakdown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              SizedBox(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PreferredSize(
                      preferredSize: Size.fromHeight(100.h),
                      child: AppBar(
                        leading: IconButton(
                          onPressed: () => Get.back(),
                          icon: SvgPicture.asset(StyldImages.backIcon),
                        ),
                        // title: Text('App Bar!'),
                        flexibleSpace: Container(
                          height: 200.h,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(StyldImages.headerImage4),
                            ),
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Positioned(
                      // left: MediaQuery.of(context).size.width * 0.75,
                      top: MediaQuery.of(context).size.height * 0.2448,
                      child: SvgPicture.asset(StyldImages.dottedIcons),
                    ),
                  ],
                ),
              ),
              // Spacer(),
              Container(
                // width: 150,
                margin: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                // height: 36,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      StyldColors.lightGold,
                      StyldColors.darkGold,
                    ],
                  ),
                  // color: buttonColor,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      StyldImages.bookingNotificationIcon,
                      height: 15.82.h,
                      color: StyldColors.white,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Completed',
                      style: GoogleFonts.roboto(textStyle: m_18),
                    ),
                  ],
                ),
              ),

              _detailsBreakdown(),

              _mapView(),
            ],
          ),
        ),
      ),
    );
  }

  _detailsBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _topDetails(),
        _orderDetails(),
        _durationDetails(),
        _servicesDetails(),
      ],
    );
  }

  _topDetails() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stylistApprovalData[0].title,
                style: GoogleFonts.roboto(textStyle: headerText),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  SvgPicture.asset(StyldImages.locationPointerSmall),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    stylistApprovalData[0].address,
                    style: GoogleFonts.roboto(textStyle: o3),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              InkWell(
                  onTap: () => Get.to(() =>  CustomerConversationScreen(StylistUser())),
                  child: SvgPicture.asset(StyldImages.chatIcon)),
              SizedBox(
                height: 2.h,
              ),
              Text('Message', style: GoogleFonts.roboto(textStyle: r_10)),
            ],
          ),
        ],
      ),
    );
  }

  _orderDetails() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SvgPicture.asset(StyldImages.newCalenderIcon),
              const SizedBox(
                width: 5,
              ),
              Text(
                stylistOrderApprovalList[0].date,
                style: GoogleFonts.roboto(textStyle: headerText),
              ),
            ],
          ),
          Text(
            'Order # 000231',
            style: GoogleFonts.roboto(textStyle: headerText),
          ),
        ],
      ),
    );
  }

  _durationDetails() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      child: Row(
        children: [
          SvgPicture.asset(
            StyldImages.smTimeIcon,
            height: 20.h,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            stylistOrderApprovalList[0].time,
            style: GoogleFonts.roboto(textStyle: headerText),
          ),
        ],
      ),
    );
  }

  _servicesDetails() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                StyldImages.servicesIcon,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Services',
                style: GoogleFonts.roboto(textStyle: headerText),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hair Styling',
                style: GoogleFonts.roboto(textStyle: b_16),
              ),
              Text(
                'Haircuts',
                style: GoogleFonts.roboto(textStyle: b_16),
              ),
              Text(
                'Blow Dry',
                style: GoogleFonts.roboto(textStyle: b_16),
              ),
              Text(
                'Hair Straighten',
                style: GoogleFonts.roboto(textStyle: b_16),
              ),
            ],
          ),
          SizedBox(height: 25.h),
          Row(
            children: [
              SvgPicture.asset(
                StyldImages.locationPointerSmall,
                height: 15,
                color: StyldColors.white,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                'Real Time Stylist Route',
                style: GoogleFonts.roboto(textStyle: headerText),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _mapView() {
    return Container(
      height: 194.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            StyldImages.routingBg,
          ),
          // fit: BoxFit.fitWidth
        ),
      ),
    );
  }
}
