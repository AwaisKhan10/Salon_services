import 'package:styld_stylist/core/model/customer_side_models/customer_user.dart';

class StylistReview {
  String? id;
  String? customerId;
  String? stylistId;
  CustomerUser? customerUser;
  String? reviewText;
  double? rating;
  DateTime? createdAt;

  StylistReview({
    this.customerId,
    this.stylistId,
    this.customerUser,
    this.reviewText,
    this.rating,
    this.createdAt,
  });

  StylistReview.fromJson(json, id) {
    this.id = id;
    customerId = json['customerId'];
    stylistId = json['stylistId'];
    createdAt = json['createdAt'].toDate();
    customerUser = json['customerUser'] != null
        ? CustomerUser.fromJson(json['customerUser'], id)
        : null;
    reviewText = json['reviewText'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = customerId;
    data['stylistId'] = stylistId;
    data['createdAt'] = createdAt;
    if (customerUser != null) {
      data['customerUser'] = customerUser!.toJson();
    }
    data['reviewText'] = reviewText;
    data['rating'] = rating;
    return data;
  }
}
