import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/booking.dart';
import 'package:styld_stylist/ui/custom_widgets/custom_scrollable_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:styld_stylist/ui/custom_widgets/width_button.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/payment_section/confirm_booking/booking_confrim_view_model.dart';
import 'package:styld_stylist/ui/screens/customer_side/root/customer_root_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class BookingConfirmedMapScreen extends StatelessWidget {
  final Booking booking;
  BookingConfirmedMapScreen(this.booking);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookingConfirmViewModel(booking),
      child: Consumer<BookingConfirmViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Scaffold(
              body: SafeArea(
                child: CustomScrollableView(
                  widget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 0.3.sh,
                            child: GoogleMap(
                              zoomGesturesEnabled:
                                  true, //enable Zoom in, out on mapnb
                              initialCameraPosition: model.cameraPosition,
                              markers: model.markers, //markers to show on map
                              polylines: Set<Polyline>.of(
                                  model.polylines.values), //polylines
                              mapType: MapType.normal, //map type
                              onMapCreated: (controller) {
                                //method called when map is created
                                model.mapController = controller;
                                model.setState(ViewState.idle);
                              },
                            ),
                          ),
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
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Center(
                        child: SvgPicture.asset(
                          StyldImages.bookingConfirmationIllustration,
                        ),
                      ),
                      SizedBox(height: 35.h),
                      Center(
                        child: Text(
                          'Appointment booking in pending!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(textStyle: m_18),
                        ),
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      Center(
                        child: Text(
                          'Your booking with Stylist will be scheduled on selected time and date when they accept the booking.'
                          ' Be patient you will receive notification soon',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(textStyle: r_18_g),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),

                      WidthButton(
                          action: () => Get.offAll(() => CustomerRootScreen()),
                          buttonColor: StyldColors.lightGold,
                          buttonColor2: StyldColors.darkGold,
                          titleText: 'Back To Home',
                          width: 356.w),

                      SizedBox(
                        height: 5.h,
                      ),

                      // const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
