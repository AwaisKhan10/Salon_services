import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/booking.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/database_service.dart';

import '../../../../locator.dart';

class OrderViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _dbService = locator<DatabaseService>();
  List<Booking> upComingBookings = [];
  List<Booking> completedBookings = [];
  List<Booking> bookins = [];

  OrderViewModel() {
    getBookings();
  }

  getBookings() async {
    setState(ViewState.busy);
    bookins =
        await _dbService.getCustomerBookings(_authService.customerUser!.id!);
    for (int i = 0; i < bookins.length; i++) {
      if (bookins[i].status == scheduled) {
        this.upComingBookings.add(bookins[i]);
      } else if (bookins[i].status == completed) {
        this.completedBookings.add(bookins[i]);
      }
    }
    print('bookingsLength => ${upComingBookings.length}');
    setState(ViewState.idle);
  }
}
