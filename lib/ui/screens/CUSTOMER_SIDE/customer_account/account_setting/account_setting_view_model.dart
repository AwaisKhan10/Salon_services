import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/customer_side_models/customer_user.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/database_service.dart';
import 'package:styld_stylist/core/services/file_picker_service.dart';
import 'package:styld_stylist/core/services/storage_service.dart';
import '../../../../../locator.dart';
import 'package:get/get.dart';

class CustomerAccountSettingViewModel extends BaseViewModel {
  CustomerUser editUser = CustomerUser();
  final authService = locator<AuthService>();
  final _dbService = DatabaseService();
  StorageService storageService = StorageService();
  File? profileImage;
  FilePickerService filePickerService = FilePickerService();
  TextEditingController controller = TextEditingController();

  CustomerAccountSettingViewModel() {
    editUser = authService.customerUser!;
    controller.text = editUser.about ?? '';
  }

  updateProfile() async {
    setState(ViewState.busy);

    /// get profile image url
    if (profileImage != null) {
      editUser.imageUrl = await storageService.uploadImage(
          profileImage!, 'customer_profile-update');
      print('@updateProfileImageUrl => ${editUser.imageUrl}');
    }
    print('phoneNumber => ${editUser.phoneNumber}');

    /// update user profile
    authService.customerUser = editUser;
    await _dbService.updateCustomerUser(authService.customerUser!);
    Get.back(result: authService.customerUser);
    setState(ViewState.idle);
  }

  getProfileImg() async {
    setState(ViewState.busy);
    profileImage = await filePickerService.pickImageWithoutCompression();
    setState(ViewState.idle);
  }
}
