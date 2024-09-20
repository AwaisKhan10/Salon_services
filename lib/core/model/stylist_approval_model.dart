class StylistApprovalModel {
  final String title;
  final String address;
  final String basicPackagePrice;
  final String standardPackagePrice;
  final String premiumPackagePrice;
  final String imageUrl;
  StylistApprovalModel(
      {required this.title,
      required this.address,
      required this.basicPackagePrice,
      required this.imageUrl,
      required this.premiumPackagePrice,
      required this.standardPackagePrice});
}
