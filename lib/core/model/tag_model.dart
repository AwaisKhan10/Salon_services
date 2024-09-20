class TagModel {
  bool active;
  final String name;
  TagModel({required this.active, required this.name});
}

class Services {
  bool active;
  String name;
  String? imagePath;
  Services({required this.active, required this.name, this.imagePath});
}
