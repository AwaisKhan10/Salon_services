import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';

import 'package:intl/intl.dart';
import 'package:styld_stylist/core/constants/images.dart';

import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/app-user.dart';
import 'package:styld_stylist/core/model/days_selection_model.dart';
import 'package:styld_stylist/core/model/response/custom_auth_result.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/core/model/stylist_notification.dart';
import 'package:styld_stylist/core/model/tag_model.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/database_service.dart';
import 'package:styld_stylist/core/services/file_picker_service.dart';
import 'package:styld_stylist/core/services/location_service.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/accountScreen/stylist_profile.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../locator.dart';

class StylistAuthViewModel extends BaseViewModel {
  final _auth = FirebaseAuth.instance;
  String customTimeSlotHr = '';
  PricingDetails pricingDetails = PricingDetails();
  String customTimeSlotMin = '';
  String customTimeSlotMeridian = 'AM';
  DateRangePickerController? controller;
  bool _isLogin = false;
  User? _firebaseUser;
  bool _authStatus = false;
  final TextEditingController pinPutController = TextEditingController();
  final FocusNode pinPutFocusNode = FocusNode();
  String? errorMessage;
  AuthService _authService = locator<AuthService>();
  final _dbService = locator<DatabaseService>();
  FilePickerService filePickerService = FilePickerService();
  StylistUser stylistUser = StylistUser(certificate: Certificate());
  LocationService locationService = LocationService();

  bool isRemeberMe = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisibility = true;

  togglePasswordVisibility() {
    // setState(ViewState.busy);
    // passwordVisibility = !passwordVisibility;
    // setState(ViewState.idle);
  }

  StylistAuthViewModel() {
    print('@CustomerAuthViewModel');
    stylistUser.noOfDays = NoOfDays();
    // _checkIfLogin();

    // /// Listen for changes in authStatus
    // _auth.onAuthStateChanged.listen(
    //   (firebaseUser) async {
    //     _firebaseUser = firebaseUser;
    //     _isLogin = (_firebaseUser != null) ? true : false;
    //     print('User Login status: $_isLogin');
    //     if (_isLogin) {
    //       print('CurrentUid: ${_firebaseUser.uid}');
    //       user = await _dbService.getUserData(_firebaseUser.uid);
    //       print('${user?.toJson()}');
    //     } else {
    //       user = User();
    //     }
    //     notifyListeners();
    //   },
    // );
  }

  // _checkIfLogin() async {
  //   print('@checkIfLogin');
  //   final user = await _auth.currentUser();
  //   if (user != null) {
  //     _isLogin = true;
  //     print('@authModel/checkIfLogin, loginStatus: $_isLogin');
  //     notifyListeners();
  //   }
  // }

  ///
  /// *** Getters ***
  ///
  /// Login status variables are made private, so that
  /// they are not changed unintentionally from any other
  /// Except this AuthProvider class with proper protocol
  ///
  User? get firebaseUser => _firebaseUser;

  bool get isLogin => _isLogin;

  bool get status => _authStatus;

  ///
  /// authentication methods
  ///
  Future<bool> createAccount() async {
    print('@ViewModel/createAccount');
    setState(ViewState.busy);
    // await _authService.verifyPhone(stylistUser.smsCode!);
    // if (_authService.isPhoneVerified) {
    Position? position = await locationService.getCurrentLocation();
    stylistUser.currentLocation = '${position!.latitude} ${position.longitude}';

    if (file != null) {
      stylistUser.certificate!.fileUrl = await _dbService.uploadFile(file!,
          'stylist_user_certificate', '${stylistUser.certificate!.name}');
      print('certificate url => ${stylistUser.certificate!.fileUrl}');
    }

    final CustomAuthResponse authResult =
        await _authService.signUpStylistWithEmailPassword(
            stylistUser: stylistUser, pricingDetails: pricingDetails);
    if (authResult.status!) {
      /// if true, process success
      _authStatus = true;

      _firebaseUser = authResult.user;
      StylistNotification stylistNotification = StylistNotification();
      await _dbService.addStylistNotification(
          authResult.user!.uid, stylistNotification);
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
    print("LoginWithUserEmailAndPasswrd====> ${stylistUser.toJson()}");
    setState(ViewState.busy);
    final CustomAuthResponse authResult =
        await _authService.loginStylistWithEmailPassword(
            email: stylistUser.email, password: stylistUser.password);
    if (authResult.status ?? false) {
      /// if true, login success
      _authStatus = true;
      _firebaseUser = authResult.user;

      print("LoginWithUserEmailAndPasswrd====> ${stylistUser.toJson()}");
    } else {
      /// if false, login failed
      _authStatus = false;
      errorMessage = authResult.errorMessage;
    }
    emailController.clear();
    passwordController.clear();

    /// Calling notify listener isn't required here
    /// as it's already called in setState method.
    setState(ViewState.idle);
    return _authStatus;
  }


  ///

  logout() {
    _authService.logout();
    notifyListeners();
  }

  addCustomTimeSlots() {
    if (customTimeSlotHr.isNotEmpty && customTimeSlotMin.isNotEmpty) {
      timeSlots.add(TimeSlots(
          slot: '$customTimeSlotHr:$customTimeSlotMin $customTimeSlotMeridian',
          isActive: true));
    }
    notifyListeners();
  }

  // resetPassword(String email){
  //   _authService.resetPassword(email);
  // }
  File? file;
  pickFile() async {
    FilePickerResult? result = await filePickerService.pickFile();
    if (result != null) {
      file = File(result.files.single.path!);
      PlatformFile filedetails = result.files.single;
      stylistUser.certificate!.name = filedetails.name;
    }

    notifyListeners();
  }

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.

    if (args.value is PickerDateRange) {
      _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
          // ignore: lines_longer_than_80_chars
          ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';

      stylistUser.noOfDays!.start =
          "${DateFormat('dd/MM/yyyy').format(args.value.startDate)}";
      stylistUser.noOfDays!.end =
          " ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}";
    } else if (args.value is DateTime) {
      _selectedDate = args.value.toString();

      stylistUser.noOfDays!.start = _selectedDate.toString();
      stylistUser.noOfDays!.end = _selectedDate.toString();
    } else if (args.value is List<DateTime>) {
      _dateCount = args.value.length.toString();
    } else {
      _rangeCount = args.value.length.toString();
    }
  }

  List<String> iconList = [
    StyldImages.hairCuttingIcon,
    StyldImages.waxingIcon,
    StyldImages.nailIcon,
    StyldImages.facialIcon,
    StyldImages.massageIcon,
  ];
  List<Services> addServices = [
    Services(name: 'Hair-cutting', active: true),
    Services(name: 'Waxing & other', active: false),
    Services(name: 'Nail treatments', active: false),
    Services(name: 'Facial & skin', active: false),
    Services(name: 'Message', active: false),
  ];

  final List<TimeSlots> timeSlots = [
    TimeSlots(slot: '9:00 AM', isActive: true),
    TimeSlots(slot: '9:15 AM', isActive: false),
    TimeSlots(slot: '9:30 AM', isActive: false),
    TimeSlots(slot: '9:45 AM', isActive: false),
    TimeSlots(slot: '10:00 AM', isActive: false),
    TimeSlots(slot: '10:15 AM', isActive: false),
    TimeSlots(slot: '10:30 AM', isActive: false),
    TimeSlots(slot: '4:00 PM', isActive: false),
    TimeSlots(slot: '4:15 PM', isActive: false),
    TimeSlots(slot: '4:30 PM', isActive: false),
    TimeSlots(slot: '4:45 PM', isActive: false),
  ];

  final List<DaysSelectionModel> days = [
    DaysSelectionModel(active: true, day: 'Monday'),
    DaysSelectionModel(active: false, day: 'Tuesday'),
    DaysSelectionModel(active: false, day: 'Wednesday'),
    DaysSelectionModel(active: false, day: 'Thursday'),
    DaysSelectionModel(active: false, day: 'Friday'),
    DaysSelectionModel(active: false, day: 'Saturday'),
    DaysSelectionModel(active: false, day: 'Sunday'),
  ];
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController basicDetailsController = TextEditingController();
  final TextEditingController standardDetailsController =
      TextEditingController();
  final TextEditingController premiumDetailsController =
      TextEditingController();

  final List<TagModel> services = [
    TagModel(
      active: true,
      name: 'bridal make-up',
    ),
    TagModel(
      active: false,
      name: 'make-up',
    ),
    TagModel(
      active: false,
      name: 'lashes',
    ),
    TagModel(
      active: false,
      name: 'polisher',
    ),
    TagModel(
      active: false,
      name: 'tattoo cover-up',
    ),
    TagModel(
      active: false,
      name: 'brow artist',
    ),
    TagModel(
      active: false,
      name: 'express make-up',
    ),
    TagModel(
      active: false,
      name: 'hair dressing',
    ),
  ];
}
