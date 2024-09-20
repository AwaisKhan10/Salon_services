import 'package:flutter/cupertino.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';
import 'package:styld_stylist/core/services/auth_service.dart';
import '../../../../../locator.dart';

class AllStylistViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  TextEditingController searchController = TextEditingController();
  List<StylistUser> stylists = [];
  List<StylistUser> searchedStylists = [];
  bool isSearching = false;

  AllStylistViewModel(String service, {stylists}) {
    if (stylists == null) {
      getStylistWithThisService(service);
    } else {
      this.stylists = stylists;
    }
  }

  searchStylists(String keyword) {
    print("Search keywork $keyword");
    keyword.isEmpty ? isSearching = false : isSearching = true;
    searchedStylists = stylists
        .where((e) => (e.fullName!.toLowerCase().contains(keyword.toLowerCase()) ||
            e.salonType!.contains(keyword.toLowerCase())))
        .toList();
    notifyListeners();
  }

  getStylistWithThisService(String service) {
    for (int i = 0; i < authService.stylistUsers.length; i++) {
      authService.stylistUsers[i].services!.forEach((element) {
        if (element.label == service) {
          stylists.add(authService.stylistUsers[i]);
        }
      });
    }
    print('StylistsWith Service :: $service are => ${stylists.length}');
  }
}
