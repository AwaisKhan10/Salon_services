import 'dart:io';

class USER {
  String? uid;
  String? email;
  String? fullName;
  String? phoneNumber;
  String? password;
  String? imgUrl;
  String? createdAt;
  String? fcmToken;
  File? imgFile;

  USER(
      {this.uid,
      this.email,
      this.imgFile,
      this.password,
      this.fullName,
      this.imgUrl,
      this.fcmToken,
      this.phoneNumber,
      this.createdAt});

  USER.fromJson(Map<String, dynamic> json) {
    uid = json['id'];
    email = json['email'];
    imgUrl = json['imgUrl'];
    fcmToken = json['fcmToken'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.uid;
    data['fcmToken'] = this.fcmToken;
    data['email'] = this.email;
    data['imgUrl'] = this.imgUrl;
    data['full_name'] = this.fullName;
    data['phone_number'] = this.phoneNumber;
    data['created_at'] = this.createdAt;
    return data;
  }
}
