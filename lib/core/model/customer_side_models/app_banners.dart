class AppBanners {
  String? imageUrl;
  AppBanners({this.imageUrl});

  AppBanners.fromJson(json) {
    imageUrl = json['imageUrl'];
  }
}
