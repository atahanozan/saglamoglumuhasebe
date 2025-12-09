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
      lastName: json["lastName"],
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
      'lastName': lastName,
      'uid': uid,
      'date': date,
      'admin': admin,
      'passwordNew': passwordNew,
      'statu': statu,
    };
  }
}
