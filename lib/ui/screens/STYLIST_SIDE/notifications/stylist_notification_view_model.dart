import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/notification.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/database_service.dart';

import '../../../../../locator.dart';

class StylistNotificationViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  final _authService = locator<AuthService>();
  List<Notification> notificaiton = [];

  StylistNotificationViewModel() {
    getAllNotification();
  }

  getAllNotification() async {
    setState(ViewState.busy);
    notificaiton =
        await _dbService.getStylistNotifications(_authService.stylistUser!.id!);
    print('notificions => ${notificaiton.length}');
    setState(ViewState.idle);
  }
}
