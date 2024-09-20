// ignore_for_file: prefer_final_fields

import 'dart:developer';

import 'package:flutter/cupertino.dart';

class AvailableTimeSlotsStatus with ChangeNotifier {
  List<bool> get activeStatus => _activeStatus;
  List<bool> _activeStatus = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  toggle(int index) {
    if (_activeStatus[index]) {
      _activeStatus[index] = false;
      log(_activeStatus[index].toString());
    } else if (_activeStatus[index] == false) {
      _activeStatus[index] = true;
      log(_activeStatus[index].toString());
    }
    notifyListeners();
  }
}
