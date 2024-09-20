class CreditCard {
  String? id;
  String? customerId;
  String? customerName;
  String? cardNo;
  String? expDate;
  String? cvv;
  DateTime? createdAt;

  CreditCard({
    this.id,
    this.customerId,
    this.customerName,
    this.cardNo,
    this.expDate,
    this.cvv,
    this.createdAt,
  });

  CreditCard.fromJson(json, id) {
    this.id = id;
    this.customerId = json['customerId'];
    this.customerName = json['customerName'];
    this.cardNo = json['cardNo'];
    this.expDate = json['expDate'];
    this.cvv = json['cvv'];
    this.createdAt = json['createdAt'].toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['cardNo'] = this.cardNo;
    data['expDate'] = this.expDate;
    data['cvv'] = this.cvv;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
