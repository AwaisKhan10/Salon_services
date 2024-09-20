class CustomerUser {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? password;
  String? fcmToken;
  String? imageUrl;
  String? location;
  String? about;

  CustomerUser({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.fcmToken,
    this.imageUrl,
    this.location,
    this.about,
  });

  CustomerUser.fromJson(json, id) {
    this.id = id;
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    fcmToken = json['fcmToken'];
    imageUrl = json['imageUrl'];
    location = json['location'];
    this.about = json['about'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['fcmToken'] = fcmToken;
    data['imageUrl'] = imageUrl;
    data['location'] = location;
    data['about'] = about;
    return data;
  }
}
