import 'dart:math';

import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/booking.dart';
import 'package:styld_stylist/core/model/customer_side_models/credit_card.dart';
import 'package:styld_stylist/core/model/notification.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/database_service.dart';
import 'package:styld_stylist/core/services/notification_service.dart';
import '../../../../locator.dart';
import 'confirm_booking/booking_confirmed_map_view.dart';
import 'package:get/get.dart';

class PaymentViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  Booking booking = Booking(services: []);
  bool isLoading = false;
  int currentMonth = 1;
  int totalDays = 0;
  int startDate = 1;
  int endDate = 1;
  final _dbService = locator<DatabaseService>();
  CreditCard creditCard = CreditCard();
  NotificationsService notificationsService = NotificationsService();

  PaymentViewModel() {
    currentMonth = DateTime.now().month - 1;
    init();
  }

  init() {
    startDate =
        int.parse(authService.bookingStylist.noOfDays!.start!.split("/")[0]);
    endDate =
        int.parse(authService.bookingStylist.noOfDays!.end!.split("/")[0]);
    totalDays = endDate - startDate;
    booking.timeSlot = authService.bookingStylist.availableTimings![0].time;
    booking.month = months[currentMonth];
    booking.date = startDate.toString();
    booking.services.add(authService.bookingServices[0].title);
    notifyListeners();
  }

  bookNewService(Booking booking) async {
    isLoading = true;
    setState(ViewState.busy);
    booking.createdAt = DateTime.now();
    Random random = new Random();
    int num1 = random.nextInt(10);
    int num2 = random.nextInt(10);
    int num3 = random.nextInt(10);

    booking.bookingId = '000$num1$num2$num3';
    await _dbService.bookAppointment(booking);
    await addNotification(booking);
    Future.delayed(Duration(seconds: 2), () {
      notificationsService.showBookingNotificaton(
          booking.stylistUser!.fullName!, 'Pending');
    });
    Get.to(() => BookingConfirmedMapScreen(booking));
    isLoading = false;
    setState(ViewState.idle);
  }

  addNotification(Booking booking) async {
    Notification notification = Notification();
    notification.customerId = booking.customerId;
    notification.stylistId = booking.stylistId;
    notification.createdAt = DateTime.now();
    notification.text =
        "Your appointment is in pending with ${booking.stylistUser!.fullName}";
    notification.title = '${booking.services[0]}';
    print('Notificaton data => ${notification.toJson()}');
    await _dbService.addNotification(notification);
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount) * 100);
    return a.toString();
  }

  selectTimeSlot(int index) {
    booking.timeSlot = authService.bookingStylist.availableTimings![index].time;
    notifyListeners();
  }

  updateMonth(bool isRight) {
    if (isRight) {
      currentMonth = currentMonth == 11 ? currentMonth : currentMonth + 1;
    } else {
      currentMonth = currentMonth == 0 ? currentMonth : currentMonth - 1;
    }
    booking.month = months[currentMonth];
    notifyListeners();
  }

  updateDate(String newDate) {
    booking.date = newDate;
    notifyListeners();
  }

  updateService(int index) {
    if (booking.services.contains(authService.bookingServices[index].title)) {
      booking.services.remove(authService.bookingServices[index].title);
    } else {
      booking.services.add(authService.bookingServices[index].title);
    }
    notifyListeners();
  }

  List<String> months = [
    'January',
    'Februray',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
}
