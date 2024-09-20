class Post {
  String? id;
  String? stylistId;
  String? postImageUrl;
  // List<String>? postImages = [];
  String? description;

  Post({
    this.id,
    this.stylistId,
    this.postImageUrl,
    this.description,
  });

  Post.fromJson(json, id) {
    this.id = id;
    stylistId = json['stylistId'];
    postImageUrl = json['postImageUrl'] ?? postImageUrl; 
    // if (json['postImages'] != null) {
    //   postImages = [];
    //   json['postImages'].forEach((element) {
    //     postImages!.add(element);
    //   });
    // }
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stylistId'] = stylistId;
    data['postImageUrl'] = postImageUrl;
    data['description'] = description;
    return data;
  }
}
