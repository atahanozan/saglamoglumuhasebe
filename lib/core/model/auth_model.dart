class AuthModel {
  final String? email, name, lastName, uid, date;
  final bool? admin, passwordNew, statu;

  AuthModel({
    this.email,
    this.name,
    this.lastName,
    this.uid,
    this.date,
    this.admin,
    this.passwordNew,
    this.statu,
  });

  AuthModel fromJson(Map<String, dynamic> json) {
    return AuthModel(
      email: json["email"],
      name: json["name"],
      lastName: json["lastname"],
      uid: json["uid"],
      date: json["date"],
      admin: json["admin"],
      passwordNew: json["passwordNew"],
      statu: json["statu"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'lastname': lastName,
      'uid': uid,
      'date': date,
      'admin': admin,
      'passwordNew': passwordNew,
      'statu': statu,
    };
  }

  String userCompany() {
    if (admin == true) {
      return "Merkez";
    } else {
      return "Şube";
    }
  }
}
