import 'package:styld_stylist/core/model/customer_side_models/customer_user.dart';

class GalleryCommentsLikes {
  String? id;
  String? imageUrl;
  late List<Likes> likeCount;
  late List<Comments> comments;

  GalleryCommentsLikes(
      {this.id,
      this.imageUrl,
      required this.likeCount,
      required this.comments});

  GalleryCommentsLikes.fromJson(json, id) {
    this.id = id;
    if (json['likeCount'] != null) {
      likeCount = [];
      json['likeCount'].forEach((v) {
        likeCount.add(Likes.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments.add(Comments.fromJson(v, id));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['likeCount'] = this.likeCount.map((v) => v.toJson()).toList();
    data['comments'] = this.comments.map((v) => v.toJson()).toList();
    return data;
  }
}

class Comments {
  String? id;
  CustomerUser? customerUser;
  DateTime? createdAt;
  String? commnetText;
  String? customerId;

  Comments({
    this.id,
    this.customerId,
    this.customerUser,
    this.createdAt,
    this.commnetText,
  });
  Comments.fromJson(json, id) {
    this.id = id;
    customerUser = json['customerUser'] != null
        ? CustomerUser.fromJson(json['customerUser'], id)
        : null;
    customerId = json['customerId'];
    commnetText = json['commentText'];
    createdAt = json['created_at'].toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (customerUser != null) {
      data['customerUser'] = customerUser!.toJson();
    }
    data['customerId'] = customerId;
    data['commentText'] = commnetText;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Likes {
  String? customerId;
  bool? isLiked;

  Likes({this.customerId, this.isLiked});

  Likes.fromJson(json) {
    customerId = json['customerid'];
    isLiked = json['isLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerid'] = customerId;
    data['isLiked'] = isLiked;
    return data;
  }
}
