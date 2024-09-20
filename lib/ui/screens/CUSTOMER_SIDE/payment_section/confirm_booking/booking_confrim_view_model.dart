import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/booking.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/location_service.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../../locator.dart';

class BookingConfirmViewModel extends BaseViewModel {
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

  Position? position;

  BookingConfirmViewModel(Booking booking) {
    init(booking);
  }

  init(Booking booking) async {
    setState(ViewState.busy);
    this.position = authService.position;
    this.cameraPosition = CameraPosition(
        target: LatLng(position!.latitude, position!.longitude), zoom: 16.0);
    endLocation1 = booking.customerUser!.location!.split(' ')[0];
    endLocation2 = booking.customerUser!.location!.split(' ')[1];
    markers.add(Marker(
      icon: BitmapDescriptor.fromBytes(await locationService.getBytesFromAsset(
        '$staticAsset/my_marker.png',
        width: 49,
        height: 63,
      )),
      position: LatLng(this.position!.latitude, this.position!.longitude),
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
    await getDirections();
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: googleAPiKey,
      request: PolylineRequest(
          origin:
              PointLatLng(this.position!.latitude, this.position!.longitude),
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
}
