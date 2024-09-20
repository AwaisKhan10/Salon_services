import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/booking.dart';
import 'package:styld_stylist/core/model/notification.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/database_service.dart';
import 'package:styld_stylist/core/services/notification_service.dart';
import '../../../../locator.dart';
import 'package:get/get.dart';

class StylistOrderViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _dbService = locator<DatabaseService>();
  List<Booking> scheduledBookings = [];
  List<Booking> completedBookings = [];
  List<Booking> pendingBookings = [];
  List<Booking> bookins = [];
  NotificationsService notificationsService = NotificationsService();
  StylistOrderViewModel() {
    getBookings();
  }

  getBookings() async {
    setState(ViewState.busy);
    bookins =
        await _dbService.getStylistBookings(_authService.stylistUser!.id!);
    for (int i = 0; i < bookins.length; i++) {
      if (bookins[i].status == scheduled) {
        this.scheduledBookings.add(bookins[i]);
      } else if (bookins[i].status == pending) {
        this.pendingBookings.add(bookins[i]);
      } else if (bookins[i].status == completed) {
        this.completedBookings.add(bookins[i]);
      }
    }
    print('pendingBookingsLength => ${pendingBookings.length}');
    setState(ViewState.idle);
  }

  declineBooking(Booking booking) async {
    setState(ViewState.busy);
    booking.status = declined;
    pendingBookings.remove(booking);
    Get.back();
    await _dbService.updateBooking(booking);
    await addNotification(booking, "declined");
    Future.delayed(Duration(seconds: 2), () {
      notificationsService.showBookingNotificaton(
          booking.customerUser!.name!, 'Declined');
    });
    setState(ViewState.idle);
  }

  approveBooking(Booking booking) async {
    setState(ViewState.busy);
    booking.status = scheduled;
    pendingBookings.remove(booking);
    scheduledBookings.add(booking);
    Get.back();
    await _dbService.updateBooking(booking);
    await addNotification(booking, "scheduled");
    Future.delayed(Duration(seconds: 2), () {
      notificationsService.showBookingNotificaton(
          booking.customerUser!.name!, 'Scheduled');
    });
    setState(ViewState.idle);
  }

  markCompleted(Booking booking) async {
    setState(ViewState.busy);
    booking.status = completed;
    scheduledBookings.remove(booking);
    completedBookings.add(booking);
    Get.back();
    await _dbService.updateBooking(booking);
    await addNotification(booking, "completed");
    Future.delayed(Duration(seconds: 2), () {
      notificationsService.showBookingNotificaton(
          booking.customerUser!.name!, 'Completed');
    });
    setState(ViewState.idle);
  }

  addNotification(Booking booking, String title) async {
    Notification notification = Notification();
    notification.customerId = booking.customerId;
    notification.stylistId = booking.stylistId;
    notification.createdAt = DateTime.now();
    notification.text =
        "Your appointment is $title with ${booking.customerUser!.name}";
    notification.title = '${booking.services[0]}';
    print('Notificaton data => ${notification.toJson()}');
    await _dbService.addNotification(notification);
  }
}
