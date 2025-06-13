class AuthorizedModel {
  final String? firstdate,
      seconddate,
      customertckn,
      customername,
      authorizedtckn,
      authorizedname,
      doctype;

  AuthorizedModel({
    this.firstdate,
    this.seconddate,
    this.customertckn,
    this.customername,
    this.authorizedtckn,
    this.authorizedname,
    this.doctype,
  });

  AuthorizedModel fromJson(Map<String, dynamic> json) {
    return AuthorizedModel(
      firstdate: json['firstdate'],
      seconddate: json['seconddate'],
      customertckn: json['customertckn'],
      customername: json['customername'],
      authorizedtckn: json['authorizedtckn'],
      authorizedname: json['authorizedname'],
      doctype: json['doctype'],
    );
  }

  Map<String, dynamic> toJson({bool? isUpdate = false}) {
    return {
      'firstdate': firstdate,
      'seconddate': seconddate,
      'customertckn': customertckn,
      'customername': customername,
      'authorizedtckn': authorizedtckn,
      'authorizedname': authorizedname,
      'doctype': doctype,
    };
  }
}
