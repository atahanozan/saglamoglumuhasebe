class AuthModel {
  final String? email, name, lastName, uid;
  final bool? admin, passwordNew;

  AuthModel({
    this.email,
    this.name,
    this.lastName,
    this.uid,
    this.admin,
    this.passwordNew,
  });

  AuthModel fromJson(Map<String, dynamic> json) {
    return AuthModel(
      email: json["email"],
      name: json["name"],
      lastName: json["lastName"],
      uid: json["uid"],
      admin: json["admin"],
      passwordNew: json["passwordNew"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'lastName': lastName,
      'uid': uid,
      'admin': admin,
      'passwordNew': passwordNew,
    };
  }
}
