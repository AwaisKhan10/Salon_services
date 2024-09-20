import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/customer_signup/custom_signup_view_model.dart';
import 'package:styld_stylist/ui/screens/CUSTOMER_SIDE/payment_section/payment_view_model.dart';
import 'package:styld_stylist/ui/screens/STYLIST_SIDE/authentication/stylist-auth-view-model.dart';
import 'package:styld_stylist/ui/screens/splash_screen.dart';
import 'core/providers/time_slots_available.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:styld_stylist/core/constants/colors.dart';
import 'package:styld_stylist/core/others/theme.dart';
import 'core/services/notification_service.dart';
import 'locator.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> main() async {
  // final Logger log = Logger();
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await NotificationsService().init(); // <----
    Stripe.publishableKey = stripePublishableKey;
    Stripe.merchantIdentifier = "CustomerID";
    // await Stripe.instance.applySettings();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await setupLocator();
    runApp(
      MyApp(), // Wrap your app
    );
  } catch (e, s) {
    print("$e");
    print("$s");
  }
}

// If you're going to use other Firebase services in the background, such as Firestore,
// make sure you call `initializeApp` before using other Firebase services.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StylistAuthViewModel()),
        ChangeNotifierProvider(create: (context) => AvailableTimeSlotsStatus()),
        ChangeNotifierProvider(create: (context) => CustomSignupViewModel()),
        ChangeNotifierProvider(create: (context) => PaymentViewModel())
      ],
      child: ScreenUtilInit(
          designSize: const Size(414, 736),
          child: GetMaterialApp(
            title: "Styld App",
            theme: OurTheme.ourTheme().copyWith(
                scrollbarTheme: const ScrollbarThemeData().copyWith(
              thumbColor: WidgetStateProperty.all(StyldColors.lightGold),
              trackColor: WidgetStateProperty.all(StyldColors.lightGrey),
            )),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          )),
    );
  }
}
