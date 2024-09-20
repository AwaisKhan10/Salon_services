class StylistOrderApprovalModel {
  final String address;
  final String imageUrl;
  final String rating;
  final String name;
  final String service;
  final String price;
  final String date;
  final String time;
  final String duration;
  final String shortAddress;
  StylistOrderApprovalModel(
      {required this.address,
      required this.date,
      required this.duration,
      required this.imageUrl,
      required this.name,
      required this.price,
      required this.rating,
      required this.service,
      required this.shortAddress,
      required this.time});
}
