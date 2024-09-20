import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';

import '../../../../../locator.dart';

class CustomerAccountViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
}
