import 'package:styld_stylist/core/constants/strings.dart';
import 'package:styld_stylist/core/model/tag_model.dart';
import 'package:styld_stylist/core/others/base_view_model.dart';

class SearchViewModel extends BaseViewModel {
  bool isSearching = false;
  List<Services> searchServices = [];

  searchStylists(String keyword) {
    print("Search keywork $keyword");
    keyword.isEmpty ? isSearching = false : isSearching = true;
    searchServices = services
        .where((e) => (e.name.toLowerCase().contains(keyword.toLowerCase())))
        .toList();
    notifyListeners();
  }

  List<Services> services = [
    Services(
        name: 'Hair-cutting',
        active: true,
        imagePath: '$staticAsset/hair_cut.png'),
    Services(
        name: 'Waxing & other',
        active: false,
        imagePath: '$staticAsset/wax.png'),
    Services(
        name: 'Nail treatments',
        active: false,
        imagePath: '$staticAsset/nail.png'),
    Services(
        name: 'Facial & skin',
        active: false,
        imagePath: '$staticAsset/facial.png'),
    Services(
        name: 'Message', active: false, imagePath: '$staticAsset/message.png'),
  ];
}
