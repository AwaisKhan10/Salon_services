import 'dart:io';

class StylistUser {
  String? id;
  String? fullName;
  String? imgUrl;
  String? email;
  String? password;
  String? phoneNumber;
  String? fcmToken;
  String? salonType;
  Certificate? certificate;
  Location? location;
  List<Service>? services;
  List<AvailableTiming>? availableTimings;
  List<AvailableDay>? availableDays;
  NoOfDays? noOfDays;
  String? aboutService;
  List<Tag>? tags;
  PricingDetails? pricingDetails;
  String? address;
  String? currentLocation;
  String? backgroundImgUrl;
  File? imgFile;
  String? createdAt;
  double? rating;
  int? reviewCount;
  bool? isApproved;
  bool? isBlocked;
  String? businessName;

  StylistUser({
    this.fullName,
    this.id,
    this.email,
    this.phoneNumber,
    this.salonType,
    this.password,
    this.fcmToken,
    this.certificate,
    this.location,
    this.services,
    this.imgUrl,
    this.availableTimings,
    this.availableDays,
    this.noOfDays,
    this.aboutService,
    this.tags,
    this.pricingDetails,
    this.address,
    this.currentLocation,
    this.backgroundImgUrl,
    this.imgFile,
    this.createdAt,
    this.rating,
    this.reviewCount,
    this.isApproved = false,
    this.isBlocked = false,
    this.businessName,
  });

  StylistUser.fromJson(json, docid) {
    id = docid;
    fullName = json['fullName'];
    email = json['email'];
    imgUrl = json['imgUrl'];
    phoneNumber = json['phoneNumber'];
    salonType = json['salonType'];
    address = json['address'];
    fcmToken = json['fcmToken'];
    currentLocation = json['currentLocation'];
    backgroundImgUrl = json['backgroundImgUrl'];
    createdAt = json['createdAt'];
    rating = json['rating'] == null ? 0.0 : json['rating'].toDouble() ?? 0.0;
    reviewCount = json['reviewCount'] ?? 0;
    isApproved = json['isApproved'] ?? true;
    isBlocked = json['isBlocked'] ?? false;
    businessName = json['businessName'];
    certificate = json['certificate'] != null
        ? Certificate.fromJson(json['certificate'])
        : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    if (json['services'] != null) {
      services = [];
      json['services'].forEach((v) {
        services!.add(Service.fromJson(v));
      });
    }
    if (json['available_timings'] != null) {
      availableTimings = [];
      json['available_timings'].forEach((v) {
        availableTimings!.add(AvailableTiming.fromJson(v));
      });
    }
    if (json['available_days'] != null) {
      availableDays = [];
      json['available_days'].forEach((v) {
        availableDays!.add(AvailableDay.fromJson(v));
      });
    }
    noOfDays = json['no_of_days'] != null
        ? NoOfDays.fromJson(json['no_of_days'])
        : null;
    aboutService = json['about_service'];
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags!.add(Tag.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fullName'] = fullName;
    data['imgUrl'] = imgUrl;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['salonType'] = salonType;
    data['address'] = address;
    data['currentLocation'] = currentLocation;
    data['backgroundImgUrl'] = backgroundImgUrl;
    data['fcmToken'] = fcmToken;
    data['createdAt'] = createdAt;
    data['rating'] = rating;
    data['reviewCount'] = reviewCount;
    data['isApproved'] = isApproved;
    data['isBlocked'] = isBlocked;
    data['businessName'] = businessName;
    if (certificate != null) {
      data['certificate'] = certificate!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (this.availableTimings != null) {
      data['available_timings'] =
          this.availableTimings!.map((v) => v.toJson()).toList();
    }
    if (this.availableDays != null) {
      data['available_days'] =
          this.availableDays!.map((v) => v.toJson()).toList();
    }
    if (this.noOfDays != null) {
      data['no_of_days'] = this.noOfDays!.toJson();
    }
    data['about_service'] = this.aboutService;
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Certificate {
  String? id;
  String? fileUrl;
  String? name;
  File? xfile;

  Certificate({this.id, this.xfile, this.fileUrl, this.name});

  Certificate.fromJson(json) {
    id = json['id'];
    fileUrl = json['file'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file'] = this.fileUrl;
    data['name'] = this.name;
    return data;
  }
}

class Location {
  String? lat;
  String? lang;

  Location({this.lat, this.lang});

  Location.fromJson(json) {
    lat = json['lat'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    return data;
  }
}

class Service {
  String? id;
  String? label;

  Service({this.id, this.label});

  Service.fromJson(json) {
    id = json['id'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    return data;
  }
}

class AvailableTiming {
  String? id;
  String? time;
  bool? isActive;

  AvailableTiming({this.id, this.time, this.isActive = false});

  AvailableTiming.fromJson(json) {
    id = json['id'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time'] = this.time;
    return data;
  }
}

class AvailableDay {
  String? id;
  String? day;

  AvailableDay({this.id, this.day});

  AvailableDay.fromJson(json) {
    id = json['id'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this.day;
    return data;
  }
}

class NoOfDays {
  String? start;
  String? end;

  NoOfDays({this.start, this.end});

  NoOfDays.fromJson(json) {
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}

class Package {
  String? id;
  String? type;
  String? price;
  String? details;

  Package({this.id, this.type, this.price, this.details});

  Package.fromJson(json) {
    id = json['id'];
    type = json['type'];
    price = json['price'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['price'] = this.price;
    data['details'] = this.details;
    return data;
  }
}

class Tag {
  String? id;
  String? label;

  Tag({this.id, this.label});

  Tag.fromJson(json) {
    id = json['id'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    return data;
  }
}

class PricingDetails {
  String? id;
  String? basicPrice;
  String? standardPrice;
  String? premiumPrice;
  String? basicDetails;
  String? standardDetails;
  String? premiumDetails;

  PricingDetails({
    this.id,
    this.basicPrice,
    this.standardPrice,
    this.premiumPrice,
    this.basicDetails,
    this.standardDetails,
    this.premiumDetails,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['basicPrice'] = basicPrice;
    data['standardPrice'] = standardPrice;
    data['premiumPrice'] = premiumPrice;
    data['basicDetails'] = basicDetails;
    data['standardDetails'] = standardDetails;
    data['premiumDetails'] = premiumDetails;
    return data;
  }

  PricingDetails.fromJson(json, id) {
    id = id;
    basicPrice = json['basicPrice'];
    standardPrice = json['standardPrice'];
    premiumPrice = json['premiumPrice'];
    basicDetails = json['basicDetails'];
    standardDetails = json['standardDetails'];
    premiumDetails = json['premiumDetails'];
  }
}
