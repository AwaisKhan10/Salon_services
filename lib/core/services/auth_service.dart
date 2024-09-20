import 'package:firebase_auth/firebase_auth.dart';
import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/core/enums/user_type.dart';
import 'package:styld_stylist/core/model/customer_side_models/app_banners.dart';
import 'package:styld_stylist/core/model/customer_side_models/customer_user.dart';
import 'package:styld_stylist/core/model/post.dart';
import 'package:styld_stylist/core/model/response/custom_auth_result.dart';
import 'package:styld_stylist/core/model/service_model.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/core/services/database_service.dart';
import 'package:styld_stylist/core/services/location_service.dart';
import 'package:styld_stylist/core/services/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:get/get.dart';
import 'package:styld_stylist/ui/custom_widgets/dialogs/request-failed-dialogue.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/request_approval/approval_screen.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/request_approval/user_blocak_screen.dart';
import '../../locator.dart';
import 'auth_exception_handler.dart';
import 'package:geolocator/geolocator.dart';

import 'local_storage_service.dart';

class AuthService {
  late bool isCustomerLogin;
  late bool isStylistLogin;
  final _localStorageService = locator<LocalStorageService>();
  final DatabaseService _dbService = locator<DatabaseService>();
  StylistUser? stylistUser = StylistUser();
  // AppUser? customerProfile = AppUser();
  CustomerUser? customerUser = CustomerUser();
  List<AppBanners> banners = [];
  // AppUser? stylistUser = AppUser();
  String? fcmToken;
  int stylistReviewsLength = 0;
  List<Post> stylistPosts = [];
  List<StylistUser> stylistUsers = [];
  // List<String> stylistUserGallery = [];
  String fbaPhoneVerificationId = '';
  bool isPhoneVerified = false;
  StylistUser bookingStylist = StylistUser();
  PricingDetails bookingPrice = PricingDetails();
  List<ServiceModel> bookingServices = [];
  Position? position;
  LocationService locationService = LocationService();
  final _auth = FirebaseAuth.instance;
  CustomAuthResponse customAuthResponseStylist = CustomAuthResponse();
  CustomAuthResponse customAuthResponseCustomer = CustomAuthResponse();

  ///
  /// [doSetup] Function does the following things:
  ///   1) Checks if the user is logged then:
  ///       a) Get the user profile data
  ///       b) Updates the user FCM Token
  ///
  doSetup() async {
    isCustomerLogin = _localStorageService.accessTokenCustomer != null;
    isStylistLogin = _localStorageService.accessTokenStylist != null;
    if (isCustomerLogin) {
      print('Customer user logged in');
      await _getUserProfile(UserType.customer);
      // await _updateFcmToken();
    } else if (isStylistLogin) {
      print('Stylist user logged in');
      await _getUserProfile(UserType.stylist);
      // await _updateFcmToken();
    } else {
      print('User is not logged-in');
    }
  }

  _getUserProfile(UserType userType) async {
    if (userType == UserType.customer) {
      var cuser = await _dbService
          .getCustomerUserData(_localStorageService.accessTokenCustomer);
      if (cuser != null) {
        customerUser = cuser;
        await getAllStylistUsers();
        await appBanners();
        this.position = await locationService.getCurrentLocation();
      } else {
        Get.dialog(RequestFailedDialog(errorMessage: "Unexpected Error"));
      }
    } else {
      var sUser = await _dbService
          .getStylistUser(_localStorageService.accessTokenStylist);
      if (sUser != null) {
        stylistUser = sUser;
        this.position = await locationService.getCurrentLocation();
        // await getAllPosts();
      } else {
        Get.dialog(RequestFailedDialog(errorMessage: "Unexpected Error"));
      }
    }
  }

  ///
  /// gettting all stylist users

  getAllStylistUsers() async {
    stylistUsers = await _dbService.getAllStylistUsers();
    print('StylistUsersLength :: db => ${stylistUsers.length}');
  }

  ///
  /// get app banners
  appBanners() async {
    banners = await _dbService.getBannerSliders();
    print('App banners lenght => ${banners.length}');
  }

  // getAllPosts() async {
  //   final uuid = _localStorageService.accessTokenStylist;
  //   stylistPosts = await _dbService.getAllStylistGalleryPics(uuid);
  //   stylistUserGallery = [];
  //   for (int i = 0; i < stylistPosts.length; i++) {
  //     // stylistPosts[i].postImages!.forEach((element) {
  //       stylistUserGallery.add(stylistPosts[i].postImageUrl ?? postImageUrl);
  //     // });
  //   }
  //   print('Gallery images => ${stylistUserGallery.length}');
  // }

  ///
  /// Updating FCM Token here...
  ///
  _updateFcmToken() async {
    // final fcmToken = await locator<NotificationsService>().getFcmToken();
    // final deviceId = await DeviceInfoService().getDeviceId();
    // final response = await _dbService.updateFcmToken(deviceId, fcmToken!);
    // if (response.success) {
    //   userProfile!.fcmToken = fcmToken;
    // }
  }

  AuthService() {
    print('@FirebaseAuthService');
  }

////
  ///This function will signup user with email and password
  ///
  // @override
  Future<CustomAuthResponse> signUpStylistWithEmailPassword(
      {StylistUser? stylistUser, PricingDetails? pricingDetails}) async {
    print('@services/signUpStylistWithEmailPassword');
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: stylistUser!.email!, password: stylistUser.password!);
      if (authResult.user == null) {
        customAuthResponseStylist.status = false;
        customAuthResponseStylist.errorMessage = 'An undefined Error happened.';
      } else {
        ////uploading image to storage first
        this.stylistUser = stylistUser;
        stylistUser.imgUrl = await _dbService.uploadFile(
            stylistUser.imgFile!, 'stylist_user', '${stylistUser.fullName}');
        this.stylistUser!.imgUrl = stylistUser.imgUrl;
        print('uploadedImageUrl => ${stylistUser.imgUrl}');

        stylistUser.id = authResult.user!.uid;
        customAuthResponseStylist.status = true;
        customAuthResponseStylist.user = authResult.user;
        customAuthResponseStylist.stylistUser = stylistUser;
        _localStorageService.setAccessTokenStylist = authResult.user!.uid;

        stylistUser.fcmToken =
            await locator<NotificationsService>().getFcmToken();
        await _dbService.registerStylistUser(stylistUser, pricingDetails!);
        this.position = await locationService.getCurrentLocation();
      }
    } catch (e) {
      print('Exception @signUpStylistWithEmailPassword: $e');
      customAuthResponseStylist.status = false;
      customAuthResponseStylist.errorMessage =
          AuthExceptionHandler.generateExceptionMessage(e);
    }
    return customAuthResponseStylist;
  }

////
  ///
  ///CUSTOMER Authentication function
  ///
  ///
  Future<CustomAuthResponse> signUpCustomerWithEmailPassword(
      {CustomerUser? customeruser, smsCode}) async {
    try {
      // first verify

      final authResult = await _auth.createUserWithEmailAndPassword(
          email: customeruser!.email!, password: customeruser.password!);
      if (authResult.user == null) {
        customAuthResponseCustomer.status = false;
        customAuthResponseCustomer.errorMessage =
            'An undefined Error happened.';
      } else {
        ////uploading image to storage first
        customeruser.id = authResult.user!.uid;
        customeruser.fcmToken =
            await locator<NotificationsService>().getFcmToken();
        customAuthResponseCustomer.status = true;
        customAuthResponseCustomer.user = authResult.user;
        customAuthResponseCustomer.customer = customeruser;
        customerUser = customeruser;
        _localStorageService.setAccessTokenCustomer = authResult.user!.uid;

        await _dbService.registerCustomerUser(customerUser!);
        this.position = await locationService.getCurrentLocation();
      }
    } catch (e) {
      print('Exception @signUpCustomerWithEmailPassword: $e');
      customAuthResponseCustomer.status = false;
      customAuthResponseCustomer.errorMessage =
          AuthExceptionHandler.generateExceptionMessage(e);
    }
    return customAuthResponseCustomer;
  }

/////
  ///
  ///This function will login Customer user with email and password
  ///
  // @override
  Future<CustomAuthResponse> loginCustomerWithEmailPassword(
      {email, password}) async {
    try {
      // var authResult;
      print('@AuthService/loginCustomerWithEmailPassword');
      final authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      /// If user login fails without any exception and error code
      if (authResult.user == null) {
        customAuthResponseCustomer.status = false;
        customAuthResponseCustomer.errorMessage =
            'An undefined Error happened.';
        return customAuthResponseCustomer;
      }

      ///
      /// If firebase auth is successful:
      ///
      /// Check if there is a user account associated with
      /// this uid in the database.
      /// If yes, then proceed to the auth success otherwise
      /// logout the user and generate an error for the user.
      ///
      if (authResult.user != null) {
        final customerUser =
            await _dbService.getCustomerUserData(authResult.user!.uid);
        if (customerUser == null) {
          customAuthResponseCustomer.status = false;
          await logout();
          customAuthResponseCustomer.errorMessage =
              "You don't have account. Please create one and then proceed to login.";
          return customAuthResponseCustomer;
        }
        customAuthResponseCustomer.status = true;
        customAuthResponseCustomer.user = authResult.user;
        customAuthResponseCustomer.customer = customerUser;
        this.customerUser = customerUser;

        _localStorageService.setAccessTokenCustomer = authResult.user!.uid;
        this.position = await locationService.getCurrentLocation();

        // customAuthResult.notFirebaseUser = user;
      }
    } catch (e) {
      customAuthResponseCustomer.status = false;
      customAuthResponseCustomer.errorMessage =
          //  e.toString();
          AuthExceptionHandler.generateExceptionMessage(e);
    }
    return customAuthResponseCustomer;
  }

  ///
  ///This function will login user with email and password
  ///
  // @override
  Future<CustomAuthResponse> loginStylistWithEmailPassword(
      {email, password}) async {
    try {
      // var authResult;
      print('@AuthService/loginStylistWithEmailPassword');
      final authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      /// If user login fails without any exception and error code
      if (authResult.user == null) {
        customAuthResponseStylist.status = false;
        customAuthResponseStylist.errorMessage = 'An undefined Error happened.';
        return customAuthResponseStylist;
      }

      ///
      /// If firebase auth is successful:
      ///
      /// Check if there is a user account associated with
      /// this uid in the database.
      /// If yes, then proceed to the auth success otherwise
      /// logout the user and generate an error for the user.
      ///
      if (authResult.user != null) {
        final suserProfile =
            await _dbService.getStylistUser(authResult.user!.uid);

        if (suserProfile == null) {
          customAuthResponseStylist.status = false;
          await logout();
          customAuthResponseStylist.errorMessage =
              "You don't have account. Please create one and then proceed to login.";
          return customAuthResponseStylist;
        } else {
          if (suserProfile.isBlocked == true) {
            Get.offAll(() => BlockedScreen());
          } else if (suserProfile.isApproved == false) {
            Get.offAll(() => ApprovalPendingScreen());
          } else {
            stylistUser = suserProfile;
            customAuthResponseStylist.status = true;
            customAuthResponseStylist.user = authResult.user;
            _localStorageService.setAccessTokenStylist = authResult.user!.uid;
            // await getAllPosts();
            this.position = await locationService.getCurrentLocation();
          }
        }
      }
    } catch (e) {
      customAuthResponseStylist.status = false;
      customAuthResponseStylist.errorMessage =
          // e.toString();
          AuthExceptionHandler.generateExceptionMessage(e);
      print("@loginStylistWithEmailPassword/Exception =====> $e");
    }
    return customAuthResponseStylist;
  }

  ///
  ///
  ///
  ///This function will send otp to the user input phone Number
  ///
  ///
  ///

  Future<void> sendCodeToPhone({required phoneNumber}) async {
    print("@sendOTPtoPhoneNumber========>$phoneNumber");
    fbaPhoneVerificationId = '';
    final fba.PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {};
    final fba.PhoneCodeSent smsCodeSent = (String verId, int? forceCodeResent) {
      fbaPhoneVerificationId = verId;
    };
    final fba.PhoneVerificationCompleted _verifiedSuccess =
        (fba.AuthCredential auth) async {
      // Get.to(() => PhoneVerification());
    };
    final fba.PhoneVerificationFailed _verifyFailed =
        (fba.FirebaseAuthException e) {
      print(
          "Firebase Exception -============>OTP verification ====>${e.message}");

      Get.to(RequestFailedDialog(errorMessage: e.message));
    };
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 30),
      verificationCompleted: _verifiedSuccess,
      verificationFailed: _verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

////
  ///This function will verify the phone
  ///
  Future<void> verifyPhone(String smsCode) async {
    print("@verifyPhoneNumber====>$smsCode");
    try {
      final fba.AuthCredential credential = fba.PhoneAuthProvider.credential(
          verificationId: fbaPhoneVerificationId, smsCode: smsCode);
      await fba.FirebaseAuth.instance.signInWithCredential(credential);
      isPhoneVerified = true;
    } catch (e) {
      isPhoneVerified = false;
      // throw Exception(e.toString());
      Get.dialog(RequestFailedDialog(
          // errorMessage: "VERIFICATION FAILED PLEASE TRY AGAIN"));
          errorMessage: e.toString()));
    }
  }

  // @override
  Future<void> logout({String? id}) async {
    // _dbService.updateFcmToken(null, id);
    isCustomerLogin = false;
    isStylistLogin = false;
    customerUser = null;
    stylistUser = null;
    // stylistUserGallery = [];
    await _auth.signOut();
    // await _dbService.clearFcmToken(await DeviceInfoService().getDeviceId());
    _localStorageService.setAccessTokenCustomer = null; //"null";
    _localStorageService.setAccessTokenStylist = null; //"null";
    // await _googleSignIn.signOut();
  }
}
