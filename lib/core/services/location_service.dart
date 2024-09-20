import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Position? currentLocation;
  String address = '';
  double? latitude;
  double? longtitude;
  final Logger log = Logger();

  getCurrentLocation() async {
    print('@getCurrentPosition');
    LocationPermission? permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Position(
            latitude: 37.785834,
            longitude: -122.406417,
            timestamp: DateTime.now(),
            accuracy: 2.0,
            altitude: 2.0,
            heading: 2.0,
            speed: 2.0,
            speedAccuracy: 2.0,
            altitudeAccuracy: 2.0,
            headingAccuracy: 2.0);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Position(
          latitude: 37.785834,
          longitude: -122.406417,
          timestamp: DateTime.now(),
          accuracy: 2.0,
          altitude: 2.0,
          heading: 2.0,
          speed: 2.0,
          speedAccuracy: 2.0,
          altitudeAccuracy: 2.0,
          headingAccuracy: 2.0);
    }
    currentLocation = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.best);
    if (currentLocation == null) {
      await checkPermissionStatus();
      await checkGpsService();
    }
    address = await getAddressFromLatLng(
        LatLng(currentLocation!.latitude, currentLocation!.longitude));
    print("Address is ====>> $address");
    log.d(
        'Latitude: ${currentLocation!.latitude}, Longitude: ${currentLocation!.longitude}');
    return currentLocation;
  }

  Future<String> getCurrentAddress() async {
    currentLocation = await Geolocator.getCurrentPosition();
    if (currentLocation == null) {
      await checkPermissionStatus();
      await checkGpsService();
    }
    address = await getAddressFromLatLng(
        LatLng(currentLocation!.latitude, currentLocation!.longitude));
    print("Address is ====>> $address");
    log.d(
        'Latitude: ${currentLocation!.latitude}, Longitude: ${currentLocation!.longitude}');
    return address;
  }

  checkPermissionStatus() async {
    print('Check permission status');
    LocationPermission permission = await checkPermissionStatus();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Permission.location.request();
    }
  }

  checkGpsService() async {
    if (await Geolocator.isLocationServiceEnabled()) {
      Get.defaultDialog(
          title: 'GPS is Disabled',
          middleText: 'Please turn on your GPS Location',
          textConfirm: 'TURN ON',
          onConfirm: () async {
            await Geolocator.openLocationSettings();
            Get.back();
          },
          textCancel: 'Skip',
          onCancel: () {});
    }
  }

  static Future<String> getAddressFromLatLng(LatLng? location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          location!.latitude, location.longitude);

      Placemark place = placemarks[0];
      print("the location is  ${place.thoroughfare}" +
          " ${place.subLocality}," +
          " ${place.locality}," +
          " ${place.country}");
      return "${place.thoroughfare} ${place.subLocality}, ${place.locality}, ${place.country}";
    } catch (e) {
      print("the exception is $e");
      return '';
    }
  }

  Future<String> getAddressFromLatLng2(LatLng? location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          location!.latitude, location.longitude);

      Placemark place = placemarks[0];
      print("the location is  ${place.thoroughfare} " +
          " ${place.subLocality}" +
          " ${place.locality}" +
          " ${place.country}");
      return "${place.thoroughfare} ${place.subLocality} ${place.locality} ${place.country}";
    } catch (e) {
      print("the exception is $e");
      return '';
    }
  }

  //
  /// Get custom markers for map
  Future<Uint8List> getBytesFromAsset(String path,
      {required int width, required int height}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
