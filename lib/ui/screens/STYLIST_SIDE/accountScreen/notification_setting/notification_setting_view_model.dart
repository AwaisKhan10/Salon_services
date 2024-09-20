import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/stylist_notification.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/database_service.dart';
import '../../../../../locator.dart';

class NotificationSettingViewModel extends BaseViewModel {
  StylistNotification? stylistNotification = StylistNotification();
  final _authService = locator<AuthService>();
  final _dbService = DatabaseService();

  NotificationSettingViewModel() {
    getNotificationSetting();
  }

  updateNotificaitons() async {
    await _dbService.addStylistNotification(
        _authService.stylistUser!.id!, stylistNotification!);
  }

  getNotificationSetting() async {
    setState(ViewState.busy);
    stylistNotification =
        await _dbService.getAllNotifications(_authService.stylistUser!.id);
    setState(ViewState.idle);
  }
}
