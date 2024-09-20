import 'package:get_it/get_it.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'core/services/database_service.dart';
import 'core/services/file_picker_service.dart';
import 'core/services/location_service.dart';
import 'core/services/notification_service.dart';
import 'core/services/local_storage_service.dart';

GetIt locator = GetIt.instance;

setupLocator() async {
  locator.registerSingleton(LocalStorageService());

  locator.registerSingleton(NotificationsService());
  // locator.registerSingleton(NotificationsStatusProvider());

  locator.registerSingleton(DatabaseService());
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerSingleton<LocationService>(LocationService());
  locator.registerLazySingleton(() => FilePickerService());
}
