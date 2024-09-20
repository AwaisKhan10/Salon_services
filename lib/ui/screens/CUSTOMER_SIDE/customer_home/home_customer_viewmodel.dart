import 'package:flutter/material.dart';
import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/core/model/tag_model.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/location_service.dart';
import 'package:styld_stylist/locator.dart';

class CustomerHomeViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  late PageController pageController;
  int currentImage = 0;
  String currentLocation = '';
  LocationService locationService = LocationService();

  CustomerHomeViewModel() {
    pageController = PageController(initialPage: 0);
    getCurrentLocation();
  }

  getCurrentLocation() async {
    currentLocation = await locationService.getCurrentAddress();
    notifyListeners();
    print('CurrentAddress => $currentLocation');
  }

  List<Services> services = [
    Services(
        name: 'Hair-cutting',
        active: true,
        imagePath: '$staticAsset/hair_cut.png'),
    Services(
        name: 'Waxing & other',
        active: false,
        imagePath: '$staticAsset/wax.png'),
    Services(
        name: 'Nail treatments',
        active: false,
        imagePath: '$staticAsset/nail.png'),
    Services(
        name: 'Facial & skin',
        active: false,
        imagePath: '$staticAsset/facial.png'),
    Services(
        name: 'Message', active: false, imagePath: '$staticAsset/message.png'),
  ];
}
