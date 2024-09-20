class Notification {
  String? id;
  String? customerId;
  String? stylistId;
  String? text;
  DateTime? createdAt;
  String? title;

  Notification({
    this.id,
    this.customerId,
    this.stylistId,
    this.text,
    this.createdAt,
    this.title,
  });

  Notification.fromJson(json, id) {
    this.id = id;
    customerId = json['customerId'];
    stylistId = json['stylistId'];
    text = json['text'];
    createdAt = json['createdAt'].toDate();
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = customerId;
    data['stylistId'] = stylistId;
    data['text'] = text;
    data['createdAt'] = createdAt;
    data['title'] = title;
    return data;
  }
}
