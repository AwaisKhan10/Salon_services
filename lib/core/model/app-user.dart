import 'dart:io';

class AppUser {
  String? uid;
  String? email;
  String? firstName;
  String? fullName;
  String? lastName;
  String? referalCode;
  String? phoneNumber;
  String? password;
  String? imgUrl;
  String? createdAt;
  String? fcmToken;
  File? imgFile;
  String? smsCode;

  AppUser({
    this.uid,
    this.fullName,
    this.email,
    this.smsCode,
    this.imgFile,
    this.password,
    this.imgUrl,
    this.fcmToken,
    this.phoneNumber,
    this.createdAt,
    this.referalCode,
    this.firstName,
    this.lastName,
  });

  AppUser.fromJson(json, uid) {
    uid = uid;
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    imgUrl = json['imgUrl'];
    fullName = json['fullName'];
    referalCode = json['referalCode'];
    // imgUrl = json['imgUrl'];
    fcmToken = json['fcmToken'];
    createdAt = json['phoneNumber'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.uid;
    data['fcmToken'] = this.fcmToken;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['imgUrl'] = this.imgUrl;
    data['phoneNumber'] = this.phoneNumber;
    // data['imgUrl'] = this.imgUrl;
    data['created_at'] = this.createdAt;

    return data;
  }
}
