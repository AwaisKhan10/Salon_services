import 'dart:io';

import 'package:flutter/material.dart';
import 'package:styld_stylist/core/enums/view_state.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/core/model/tag_model.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import 'package:styld_stylist/core/services/database_service.dart';
import 'package:styld_stylist/core/services/file_picker_service.dart';
import 'package:styld_stylist/core/services/storage_service.dart';
import '../../../../../locator.dart';
import 'package:get/get.dart';

class AccountSettingViewModel extends BaseViewModel {
  StylistUser editUser = StylistUser();
  final authService = locator<AuthService>();
  final _dbService = DatabaseService();
  final TextEditingController controller = TextEditingController();
  StorageService storageService = StorageService();
  File? profileImage;
  File? backgroundImage;
  FilePickerService filePickerService = FilePickerService();

  AccountSettingViewModel() {
    editUser = authService.stylistUser!;
    controller.text = editUser.aboutService!;
    init();
  }

  init() {
    if (authService.stylistUser!.tags != null) {
      for (int i = 0; i < services.length; i++) {
        for (int j = 0; j < authService.stylistUser!.tags!.length; j++) {
          if (authService.stylistUser!.tags![j].label == services[i].name) {
            services[i].active = true;
          }
        }
      }
    }
  }

  updateProfile() async {
    setState(ViewState.busy);

    /// add updated tags
    editUser.tags = [];
    for (int i = 0; i < services.length; i++) {
      if (services[i].active) {
        editUser.tags!.add(Tag(label: services[i].name));
      }
    }

    /// get profile image url
    if (profileImage != null) {
      editUser.imgUrl =
          await storageService.uploadImage(profileImage!, 'profile-update');
      print('@updateProfileImageUrl => ${editUser.imgUrl}');
    }

    /// get background image url
    if (backgroundImage != null) {
      editUser.backgroundImgUrl = await storageService.uploadImage(
          backgroundImage!, 'profile-background-update');
      print('@profileBackgroundUpdate => ${editUser.backgroundImgUrl}');
    }

    /// update user profile
    authService.stylistUser = editUser;
    await _dbService.updateStylistUserProfile(authService.stylistUser!);
    Get.back(result: authService.stylistUser);
    setState(ViewState.idle);
  }

  getProfileImg() async {
    setState(ViewState.busy);
    profileImage = await filePickerService.pickImageWithoutCompression();
    setState(ViewState.idle);
  }

  getBackgroundImage() async {
    setState(ViewState.busy);
    backgroundImage = await filePickerService.pickImageWithoutCompression();
    setState(ViewState.idle);
  }

  selectNewTag(int index) {
    services[index].active = !services[index].active;
    notifyListeners();
  }

  final List<TagModel> services = [
    TagModel(
      active: false,
      name: 'bridal make-up',
    ),
    TagModel(
      active: false,
      name: 'make-up',
    ),
    TagModel(
      active: false,
      name: 'lashes',
    ),
    TagModel(
      active: false,
      name: 'polisher',
    ),
    TagModel(
      active: false,
      name: 'tattoo cover-up',
    ),
    TagModel(
      active: false,
      name: 'brow artist',
    ),
    TagModel(
      active: false,
      name: 'express make-up',
    ),
    TagModel(
      active: false,
      name: 'hair dressing',
    ),
  ];
}
