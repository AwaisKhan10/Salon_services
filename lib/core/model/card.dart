class CardDetails{
  String? id;
  String? cardNo;
  String? expiryMonth;
  String? expiryYear;
  String? cvv;

  CardDetails({
    this.id,
    this.cardNo,
    this.expiryMonth,
    this.expiryYear,
    this.cvv
  });

   CardDetails.fromJson(json, id) {
    this.id = id;
    this.cardNo = json['cardNo'];
    this.expiryMonth = json['expiryMonth'];
    this.expiryYear = json['expiryYear'];
    this.cvv = json['cvv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cardNo'] = this.cardNo;
    data['expiryMonth'] = this.expiryMonth;
    data['expiryYear'] = this.expiryYear;
    data['cvv'] = this.cvv;
    return data;
  }
}