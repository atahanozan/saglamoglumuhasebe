class CustomerModel {
  String? docId;
  int? id;
  String? name;
  String? tcknvkn;
  String? date;
  String? agentName;
  String? agentLastname;
  String? telNo;
  dynamic frontId;

  CustomerModel({
    this.id,
    this.name,
    this.tcknvkn,
    this.date,
    this.agentName,
    this.agentLastname,
    this.telNo,
    this.docId,
    this.frontId,
  });

  CustomerModel fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      docId: json['docId'],
      id: json['id'],
      name: json['name'],
      tcknvkn: json['tcknvkn'],
      date: json['date'],
      agentName: json['agentName'],
      agentLastname: json['agentLastname'],
      telNo: json["telNo"],
      frontId: json["frontId"],
    );
  }

  Map<String, dynamic> toJson({bool? isUpdate = false}) {
    return {
      'docId': docId,
      'id': id,
      'name': name,
      'tcknvkn': tcknvkn,
      'date': date,
      'agentName': agentName,
      'agentLastname': agentLastname,
      'telNo': telNo,
      'frontId': frontId,
    };
  }
}
