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
import 'package:styld_stylist/core/model/booking.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_orders/customer_upcoming_orders/booking_details_view_model.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/stylistDetailed/customer_chat/customer_conversation_screen.dart';

class UpcomingOrdersBreakdown extends StatefulWidget {
  final Booking booking;
  final isCompleted;
  UpcomingOrdersBreakdown(this.booking, {this.isCompleted = false});

  @override
  State<UpcomingOrdersBreakdown> createState() =>
      _UpcomingOrdersBreakdownState();
}

class _UpcomingOrdersBreakdownState extends State<UpcomingOrdersBreakdown> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookingDetailsViewModel(widget.booking),
      child:
          Consumer<BookingDetailsViewModel>(builder: (context, model, child) {
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
                    /// Profile images
                    ///
                    changeImagesArea(model, widget.booking),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 60.w, vertical: 10.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            StyldColors.white,
                            StyldColors.white,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            StyldImages.processBookingIcon,
                            height: 15.82.h,
                            color: StyldColors.black,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            widget.isCompleted ? "Completed" : 'Upcoming',
                            style: GoogleFonts.roboto(textStyle: m_bl_18),
                          ),
                        ],
                      ),
                    ),

                    _topDetails(widget.booking),
                    _orderDetails(widget.booking, model),
                    _durationDetails(widget.booking),
                    _servicesDetails(widget.booking),
                    // _mapView(),

                    Container(
                      height: 0.3.sh,
                      child: GoogleMap(
                        //Map widget from google_maps_flutter package
                        zoomGesturesEnabled:
                            true, //enable Zoom in, out on mapnb
                        initialCameraPosition: model.cameraPosition,
                        markers: model.markers, //markers to show on map
                        polylines: Set<Polyline>.of(
                            model.polylines.values), //polylines
                        mapType: MapType.normal, //map type
                        onMapCreated: (controller) {
                          //method called when map is created
                          setState(() {
                            model.mapController = controller;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  changeImagesArea(BookingDetailsViewModel model, Booking booking) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Stack(
        children: [
          Stack(
            children: [
              PreferredSize(
                preferredSize: Size.fromHeight(224.h),
                child: AppBar(
                  leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: SvgPicture.asset(StyldImages.backIcon),
                  ),
                  // title: Text('App Bar!'),
                  flexibleSpace: booking.stylistUser!.backgroundImgUrl == null
                      ? Image(
                          image: AssetImage(StyldImages.headerImage),
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          booking.stylistUser!.backgroundImgUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 0.27.sh,
                        ),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Positioned(
                left: 0.35.sw,
                top: 135,
                child: CircleAvatar(
                  radius: 60.r,
                  backgroundColor: StyldColors.black,
                  foregroundColor: StyldColors.black,
                  backgroundImage: NetworkImage(booking.stylistUser!.imgUrl!),
                  // const AssetImage(StyldImages.femaleImage),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _topDetails(Booking booking) {
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
                '${booking.stylistUser!.fullName}',
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
                    '${booking.stylistUser!.address ?? ''}',
                    style: GoogleFonts.roboto(textStyle: o3),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              InkWell(
                  onTap: () => Get.to(() =>
                      CustomerConversationScreen(widget.booking.stylistUser!)),
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

  _orderDetails(Booking booking, BookingDetailsViewModel model) {
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
                '${booking.month} ${booking.date}',
                style: GoogleFonts.roboto(textStyle: headerText),
              ),
            ],
          ),
          Text(
            'Order # ${booking.bookingId}',
            style: GoogleFonts.roboto(textStyle: headerText),
          ),
        ],
      ),
    );
  }

  _durationDetails(Booking booking) {
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
            '${booking.timeSlot}',
            style: GoogleFonts.roboto(textStyle: headerText),
          ),
        ],
      ),
    );
  }

  _servicesDetails(Booking booking) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Container(
            height: 30.h,
            child: ListView.builder(
                itemCount: booking.services.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      '${booking.services[index]}',
                      style: GoogleFonts.roboto(textStyle: b_16),
                    ),
                  );
                }),
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
}
