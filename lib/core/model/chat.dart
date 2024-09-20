import 'package:flutter/foundation.dart';
import 'package:styld_stylist/core/enums/message_type.dart';
import 'package:styld_stylist/core/model/customer_side_models/customer_user.dart';
import 'package:styld_stylist/core/model/stylish_user_profile.dart';

class Chat {
  String? id;
  String? stylistId;
  String? customerId;
  CustomerUser? customerUser;
  StylistUser? stylistUser;
  String? createdAt;
  String? message;
  String? formattedTime;
  MessageType? type;
  String? customerFcm;
  String? stylistFcm;
  bool? isCustomer;
  bool? isStylist;

  Chat(
      {this.id,
      this.stylistId,
      this.customerId,
      this.createdAt,
      this.customerUser,
      this.stylistUser,
      this.message,
      this.formattedTime,
      this.type = MessageType.text,
      this.customerFcm,
      this.stylistFcm,
      this.isCustomer,
      this.isStylist});

  Chat.fromJson(json) {
    this.stylistId = json['stylistId'];
    this.customerId = json['customerId'];
    this.createdAt = json['createdAt'];
    customerUser = json['customerUser'] != null
        ? CustomerUser.fromJson(json['customerUser'], this.customerId)
        : null;
    stylistUser = json['stylistUser'] != null
        ? StylistUser.fromJson(json['stylistUser'], this.stylistId)
        : null;
    this.message = json['message'];
    this.formattedTime = json['formattedTime'];
    this.type = _getMessageType(json['type']);
    this.customerFcm = json['customerFcm'];
    this.stylistFcm = json['stylistFcm'];
    this.isCustomer = json['isCustomer'] ?? true;
    this.isStylist = json['isStylist'];
  }

  toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['stylistId'] = this.stylistId;
    data['customerId'] = this.customerId;
    data['createdAt'] = this.createdAt;
    if (customerUser != null) {
      data['customerUser'] = this.customerUser!.toJson();
    }
    if (stylistUser != null) {
      data['stylistUser'] = this.stylistUser!.toJson();
    }
    data['type'] = describeEnum(this.type ?? MessageType.text);
    data['message'] = this.message;
    data['formattedTime'] = this.formattedTime;
    data['customerFcm'] = this.customerFcm;
    data['stylistFcm'] = this.stylistFcm;
    data['isCustomer'] = this.isCustomer;
    data['isStylist'] = this.isStylist;
    return data;
  }

  _getMessageType(type) {
    if (type == 'text')
      return MessageType.text;
    else if (type == 'voice')
      return MessageType.voice;
    else if (type == 'image')
      return MessageType.image;
    else {
      return MessageType.location;
    }
  }
}
