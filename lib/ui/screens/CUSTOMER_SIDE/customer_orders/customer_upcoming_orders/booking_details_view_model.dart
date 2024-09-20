import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/booking.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/database_service.dart';
import 'package:styld_stylist/core/services/location_service.dart';
import 'package:styld_stylist/core/services/notification_service.dart';
import '../../../../../locator.dart';

class BookingDetailsViewModel extends BaseViewModel {
  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyCWQnWFjWKLL4Oxl5AfTZgiblcSUri2HaM";
  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction
  LatLng startLocation = LatLng(27.6683619, 85.3101895);
  LatLng endLocation = LatLng(27.6688312, 85.3077329);
  LocationService locationService = LocationService();
  String endLocation1 = '';
  String endLocation2 = '';
  late CameraPosition cameraPosition;
  final authService = locator<AuthService>();
  final _dbService = DatabaseService();
  NotificationsService notificationsService = NotificationsService();

  BookingDetailsViewModel(Booking booking) {
    init(booking);
  }

  init(Booking booking) async {
    // setState(ViewState.busy);
    this.cameraPosition = CameraPosition(
        target: LatLng(
            authService.position!.latitude, authService.position!.longitude),
        zoom: 16.0);
    endLocation1 = booking.customerUser!.location!.split(' ')[0];
    endLocation2 = booking.customerUser!.location!.split(' ')[1];
    markers.add(Marker(
      icon: BitmapDescriptor.fromBytes(await locationService.getBytesFromAsset(
        '$staticAsset/my_marker.png',
        width: 49,
        height: 63,
      )),
      position: LatLng(
          authService.position!.latitude, authService.position!.longitude),
      markerId: MarkerId('${booking.bookingId}'),
      infoWindow: InfoWindow(title: '${booking.customerUser!.name}'),
    ));
    print('location1&2 => $endLocation1 , $endLocation2');

    markers.add(Marker(
      icon: BitmapDescriptor.fromBytes(await locationService.getBytesFromAsset(
        '$staticAsset/other_marker.png',
        width: 49,
        height: 63,
      )),
      position: LatLng(
          double.parse(this.endLocation1), double.parse(this.endLocation2)),
      markerId: MarkerId('${booking.bookingId}'),
      infoWindow: InfoWindow(title: '${booking.stylistUser!.fullName}'),
    ));
    print('@getDirections');
    await getDirections();
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: googleAPiKey,
      request: PolylineRequest(
          origin: PointLatLng(
              authService.position!.latitude, authService.position!.longitude),
          destination: PointLatLng(
              double.parse(this.endLocation1), double.parse(this.endLocation2)),
          mode: TravelMode.driving),
    );

    if (result.points.isNotEmpty) {
      print('Point not empty');
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print('pointsEmpty => ${result.errorMessage}');
    }
    print('@getPolyLines');
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: StyldColors.red,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
    setState(ViewState.idle);
  }

  // markCompleted(Booking booking, List<Booking> bookings) async {
  //   setState(ViewState.busy);
  //   booking.status = scheduled;
  //   Get.back();
  //   await _dbService.updateBooking(booking);
  //   await addNotification(booking, "scheduled");
  //   Future.delayed(Duration(seconds: 2), () {
  //     notificationsService.showBookingNotificaton(
  //         booking.customerUser!.name!, 'Scheduled');
  //   });
  //   setState(ViewState.idle);
  // }

  // addNotification(Booking booking, String title) async {
  //   Notification notification = Notification();
  //   notification.customerId = booking.customerId;
  //   notification.stylistId = booking.stylistId;
  //   notification.createdAt = DateTime.now();
  //   notification.text =
  //       "Your appointment is $title with ${booking.customerUser!.name}";
  //   notification.title = '${booking.services[0]}';
  //   print('Notificaton data => ${notification.toJson()}');
  //   await _dbService.addNotification(notification);
  // }
}
