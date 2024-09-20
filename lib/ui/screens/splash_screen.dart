import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styld_stylist/core/constants/images.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/local_storage_service.dart';
import 'package:styld_stylist/core/services/location_service.dart';
import 'package:styld_stylist/core/services/notification_service.dart';
import 'package:styld_stylist/ui/custom_widgets/dialogs/network-error-dialogue.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/request_approval/approval_screen.dart';
import '../../locator.dart';
import 'SELECTION_SIDE/selection_screen.dart';
import 'STYLIST_SIDE/request_approval/user_blocak_screen.dart';
import 'STYLIST_SIDE/root/stylist_root_screen.dart';
import 'customer_side/root/customer_root_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // _navigateToSelectionScreen() async {
  //   await Future.delayed(const Duration(seconds: 3));
  //   Get.offAll(SelectionScreen());
  // }
  final _authService = locator<AuthService>();
  // final _dbService = locator<DatabaseService>();
  final _localStorateService = locator<LocalStorageService>();
  final _locationService = locator<LocationService>();
  final _notificationService = locator<NotificationsService>();
  @override
  void initState() {
    _initialSetup();
    super.initState();
    // _navigateToSelectionScreen();
  }

  _initialSetup() async {
    await _localStorateService.init();

    // await _locationService.getCurrentLocation();

    ///
    /// If not connected to internet, show an alert dialog
    /// to activate the network connection.
    ///
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      print("NO INTERNET AVAIALABLE");
      Get.dialog(NetworkErrorDialog());
      return;
    }

    ////
    ///initializing notification services
    ///
    await _notificationService.initConfigure();

    // if (_localStorateService.onBoardingPageCount == 0) {
    //   // final List<Image> preCachedImages =
    //   // await _preCacheOnboardingImages(onboardingList);
    //   await Get.to(() => OnBoardingScreen());
    //   return;
    // }
    await _authService.doSetup();

    ////
    ///checking which user is login and then navigating the end user to that screen
    ///
    print('CUSTOMER Login State: ${_authService.isCustomerLogin}');
    print('STYLIST Login State: ${_authService.isStylistLogin}');
    if (_authService.isCustomerLogin) {
      Get.offAll(() => CustomerRootScreen());
    } else if (_authService.isStylistLogin) {
      if (_authService.stylistUser!.isApproved!) {
        Get.offAll(() => StylistRootScreen());
      } else if (_authService.stylistUser!.isBlocked == true) {
        Get.offAll(() => BlockedScreen());
      } else {
        Get.offAll(() => ApprovalPendingScreen());
      }
    } else {
      Future.delayed(Duration(seconds: 2), () {
        Get.off(() => SelectionScreen());
        // exit(0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: Image.asset(StyldImages.mainLogo)),
      ),
    );
  }
}
