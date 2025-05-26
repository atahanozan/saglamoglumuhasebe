class CustomerModel {
  int? id;
  String? name;
  String? tcknvkn;
  String? date;
  String? agentName;
  String? agentLastname;

  CustomerModel({
    this.id,
    this.name,
    this.tcknvkn,
    this.date,
    this.agentName,
    this.agentLastname,
  });

  CustomerModel fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      name: json['name'],
      tcknvkn: json['tcknvkn'],
      date: json['date'],
      agentName: json['agentName'] ?? "",
      agentLastname: json['agentLastname'] ?? "",
    );
  }

  Map<String, dynamic> toJson({bool? isUpdate = false}) {
    return {
      'id': id,
      'name': name,
      'tcknvkn': tcknvkn,
      'date': date,
      'agentName': agentName,
      'agentLastname': agentLastname,
    };
  }
}
