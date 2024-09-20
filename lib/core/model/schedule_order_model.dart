class ScheduleOrderModel {
  final String name;
  final String address;
  final String date;
  final String time;
  final String duration;
  final String price;
  final String path;
  ScheduleOrderModel(
      {required this.address,
      required this.path,
      required this.date,
      required this.duration,
      required this.name,
      required this.price,
      required this.time});
}
