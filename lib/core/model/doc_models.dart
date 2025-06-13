class DeliveryDocModel {
  final String? name,
      tcknvkn,
      price,
      company,
      date,
      agentName,
      agentLastname,
      currency,
      lastEditedDate;
  final int? id;
  final bool? statu, proccesstatu;

  DeliveryDocModel({
    this.name,
    this.tcknvkn,
    this.price,
    this.company,
    this.date,
    this.agentName,
    this.agentLastname,
    this.currency,
    this.id,
    this.statu,
    this.proccesstatu,
    this.lastEditedDate,
  });

  factory DeliveryDocModel.fromDocument(Map<String, dynamic> data) {
    return DeliveryDocModel(
      name: data["name"] ?? '',
      tcknvkn: data["tcknvkn"] ?? '',
      price: data["price"] ?? '',
      company: data["company"] ?? '',
      date: data["date"] ?? '',
      agentName: data["agentName"] ?? '',
      agentLastname: data["agentLastname"] ?? '',
      currency: data["currency"] ?? '',
      id: data["id"] ?? 0,
      statu: data["statu"] ?? false,
      proccesstatu: data["proccesstatu"] ?? false,
      lastEditedDate: data["lastEditedDate"] ?? '',
    );
  }

  DeliveryDocModel fromJson(Map<String, dynamic> json) {
    return DeliveryDocModel(
      name: json["name"],
      tcknvkn: json["tcknvkn"],
      price: json["price"],
      company: json["company"],
      date: json["date"],
      agentName: json["agentName"],
      agentLastname: json["agentLastname"],
      currency: json["currency"],
      id: json["id"],
      statu: json["statu"],
      proccesstatu: json["proccesstatu"],
      lastEditedDate: json["lastEditedDate"],
    );
  }

  Map<String, dynamic> toJson({bool? isUpdate = false}) {
    return {
      'name': name,
      'tcknvkn': tcknvkn,
      'price': price,
      'company': company,
      'date': date,
      'agentName': agentName,
      'agentLastname': agentLastname,
      'currency': currency,
      'id': id,
      'statu': statu,
      'proccesstatu': proccesstatu,
      'lastEditedDate': lastEditedDate,
    };
  }
}
