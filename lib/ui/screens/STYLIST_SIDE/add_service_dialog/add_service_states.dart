import 'package:flutter/cupertino.dart';

class AddServiceStates with ChangeNotifier {
  bool _selectAll = false;
  bool get selectAll => _selectAll;
  // ignore: prefer_final_fields
  List<bool> _selectionStates = [false, false, false, false, false];
  List<bool> get selectionStates => _selectionStates;
  toggleSelectAll() {
    _selectAll = !_selectAll;
    for (int i = 0; i < _selectionStates.length; i++) {
      _selectionStates[i] = !_selectionStates[i];
    }
    notifyListeners();
  }

  toggleService({required int index}) {
    _selectionStates[index] = !_selectionStates[index];
    notifyListeners();
  }
}
