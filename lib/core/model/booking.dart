import 'package:styld_stylist/core/model/customer_side_models/customer_user.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';
import 'package:styld_stylist/core/services/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Booking {
  String? id;
  String? customerId;
  String? stylistId;
  CustomerUser? customerUser;
  StylistUser? stylistUser;
  DateTime? createdAt;
  String? month;
  String? date;
  String? timeSlot;
  String? price;
  String? status;
  String? bookingId;
  String? customerAddress;
  late List<String> services;

  Booking({
    this.id,
    this.customerId,
    this.stylistId,
    this.customerUser,
    this.stylistUser,
    this.createdAt,
    this.month,
    this.date,
    this.timeSlot,
    this.price,
    this.status = 'pending',
    this.bookingId = '000321',
    this.customerAddress,
    required this.services,
  });

  Booking.fromJson(json, id) {
    this.id = id;
    this.customerId = json['customerId'];
    this.stylistId = json['stylistId'];
    customerUser = json['customerUser'] != null
        ? CustomerUser.fromJson(json['customerUser'], this.customerId)
        : null;
    stylistUser = json['stylistUser'] != null
        ? StylistUser.fromJson(json['stylistUser'], this.stylistId)
        : null;
    this.createdAt = json['created_at'].toDate();
    this.month = json['month'];
    this.date = json['date'];
    this.timeSlot = json['timeSlot'];
    this.bookingId = json['bookingId'] ?? '000321';
    if (json['service'] != null) {
      this.services = [];
      json['service'].forEach((e) {
        this.services.add(e);
      });
    }
    this.price = json['price'];
    this.status = json['status'];
    getCustomerAddress(this.customerUser!);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['stylistId'] = this.stylistId;
    if (customerUser != null) {
      data['customerUser'] = this.customerUser!.toJson();
    }
    if (stylistUser != null) {
      data['stylistUser'] = this.stylistUser!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['month'] = this.month;
    data['date'] = this.date;
    data['timeSlot'] = this.timeSlot;
    data['service'] = this.services;
    data['price'] = this.price;
    data['status'] = this.status;
    data['bookingId'] = this.bookingId;
    return data;
  }

  getCustomerAddress(CustomerUser customerUser) async {
    LocationService locationService = LocationService();
    double position1 = double.parse(this.customerUser!.location!.split(' ')[0]);
    double position2 = double.parse(this.customerUser!.location!.split(' ')[1]);
    LatLng latLng = LatLng(position1, position2);
    this.customerAddress = await locationService.getAddressFromLatLng2(latLng);
    if (this.customerAddress == null) {
      this.customerAddress = ' ';
    }
    print('Address => ${this.customerAddress}');
  }
}
