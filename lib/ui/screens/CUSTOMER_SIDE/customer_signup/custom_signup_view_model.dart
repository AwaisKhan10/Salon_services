import 'dart:io';
import 'dart:math';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/customer_side_models/customer_user.dart';
import 'package:styld_stylist/core/model/response/custom_auth_result.dart';
import 'package:styld_stylist/core/model/stylist_notification.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/database_service.dart';
import 'package:styld_stylist/core/services/location_service.dart';
import 'package:styld_stylist/core/services/notification_service.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/otpScreen/enter_otp_screen.dart';
import 'package:get/get.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/root/customer_root_screen.dart';
import '../../../../locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class CustomSignupViewModel extends BaseViewModel {
  bool _authStatus = false;
  String phone = '';
  String? errorMessage;
  bool _isLogin = false;
  User? _firebaseUser;
  CustomerUser customerUser = CustomerUser();
  String otp = '';
  final _dbService = locator<DatabaseService>();
  final _authService = locator<AuthService>();
  File? image;
  NotificationsService notificationsService = NotificationsService();
  User? get firebaseUser => _firebaseUser;
  bool get isLogin => _isLogin;
  bool get status => _authStatus;
  LocationService locationService = LocationService();

  ///
  /// authentication methods
  ///
  Future<bool> createAccount() async {
    print('@ViewModel/createAccount');
    setState(ViewState.busy);
    print('customerData => ${customerUser.toJson()}');
    // print('Image => ${image!.path}');

    Position? position = await locationService.getCurrentLocation();
    customerUser.location = '${position!.latitude} ${position.longitude}';

    if (image != null) {
      customerUser.imageUrl = await _dbService.uploadFile(
          image!, 'customer-user', '${customerUser.name}');
      print('customer image url => ${customerUser.imageUrl}');
    }
    final CustomAuthResponse authResult = await _authService
        .signUpCustomerWithEmailPassword(customeruser: customerUser);
    if (authResult.status!) {
      /// if true, process success
      _authStatus = true;
      _firebaseUser = authResult.user;
      await _authService.appBanners();
      await _authService.getAllStylistUsers();
      StylistNotification stylistNotification = StylistNotification();
      await _dbService.addStylistNotification(
          authResult.user!.uid, stylistNotification);
      Get.offAll(() => CustomerRootScreen());
      // StylistNotification stylistNotification = StylistNotification();
      // await _dbService.addStylistNotification(
      //     authResult.user!.uid, stylistNotification);
    } else {
      /// if false, process failed
      _authStatus = false;
      errorMessage = authResult.errorMessage;
    }

    setState(ViewState.idle);
    return _authStatus;
  }

  ///
  /// Login with Email and Password Functions
  ///
  Future<bool> loginWithEmailPassword() async {
    setState(ViewState.busy);
    final CustomAuthResponse authResult =
        await _authService.loginCustomerWithEmailPassword(
            email: customerUser.email, password: customerUser.password);
    if (authResult.status ?? false) {
      /// if true, login success
      _authStatus = true;
      _firebaseUser = authResult.user;
      await _authService.appBanners();
      await _authService.getAllStylistUsers();
    } else {
      /// if false, login failed
      _authStatus = false;
      errorMessage = authResult.errorMessage;
      // Get.offAll(() => CustomerRootScreen());
    }

    /// Calling notify listener isn't required here
    /// as it's already called in setState method.
    setState(ViewState.idle);
    return _authStatus;
  }

  logout() {
    _authService.logout();
    notifyListeners();
  }

  getOTP() {
    setState(ViewState.busy);
    Future.delayed(Duration(seconds: 2), () {
      Random random = new Random();
      int num1 = random.nextInt(10);
      int num2 = random.nextInt(10);
      int num3 = random.nextInt(10);
      int num4 = random.nextInt(10);
      otp = '$num1$num2$num3$num4';
      print('Random numbers => $num1, $num2, $num3, $num4');

      notificationsService.showLocalNotificaiton(otp);
      Get.to(() => const EnterOTPScreen());
      setState(ViewState.idle);
    });
  }
}
