import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/model/auth_model.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AuthModel?> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
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
          statu: user["statu"],
        );

        return result;
      }
    } on FirebaseAuthException catch (err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(err.code)));
      }

      return AuthModel();
    }
  }

  Future<void> createUser(
    String name,
    String lastName,
    String email,
    bool admin,
  ) async {
    try {
      var user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: "123456");

      if (user.user != null) {
        var newUser = AuthModel(
          uid: user.user?.uid,
          email: email,
          name: name,
          lastName: lastName,
          date: DateTime.now().toString(),
          admin: admin,
          passwordNew: true,
          statu: true,
        );
        _firestore
            .collection("users")
            .doc(user.user?.uid)
            .set(newUser.toJson());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<bool> changePassword(String newPassword, User newUser) async {
    await newUser.updatePassword(newPassword).then((newValue) {
      return true;
    }).catchError((err) {
      if (kDebugMode) {
        print(err);
      }

      return false;
    });

    return true;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<void> disableUser(String? uid) async {
    _firestore.collection('users').doc(uid).update({
      "statu": false,
    });
  }

  Future<void> updateUserInfo(
    String? userUid,
    Map<String, dynamic> newData,
    BuildContext context,
  ) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userUid)
        .update(newData);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kullanıcı bilgisi güncellendi.")));
    }
  }
}
