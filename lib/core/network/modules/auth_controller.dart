import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saglamoglu_muhasebe/core/model/auth_model.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AuthModel?> login(
    String email,
    String password,
  ) async {
    var response = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      return AuthModel();
    } else {
      var user =
          await _firestore.collection("users").doc(response.user?.uid).get();

      var result = AuthModel(
        email: email,
        name: user["name"],
        lastName: user["lastname"],
        uid: response.user?.uid,
        admin: user["admin"],
        passwordNew: user["passwordNew"],
      );

      return result;
    }
  }

  Future<bool> changePassword(String newPassword, User newUser) async {
    await newUser.updatePassword(newPassword).then((newValue) {
      return true;
    }).catchError((err) {
      print(err);

      return false;
    });

    return true;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
