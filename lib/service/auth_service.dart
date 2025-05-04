import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/pages/home_navigate_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> userLogin(
    String email,
    String password,
    BuildContext context,
  ) async {
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final String? name = await getUserName(userCredential.user?.uid);
      final bool admin = await getUserAdmin(userCredential.user?.uid);
      final String uid = userCredential.user!.uid.toString();

      prefs.setString("uid", uid);

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HomeNavigatePage(
              admin: admin,
              name: name.toString(),
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Giriş başarılı.",
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              err.message.toString(),
            ),
          ),
        );
      }
    }
  }

  Future<String?> getUserName(String? docId) async {
    var name = await _firestore.collection("users").doc(docId).get();

    return name["name"];
  }

  Future<bool> getUserAdmin(String? docId) async {
    var admin = await _firestore.collection("users").doc(docId).get();

    return admin["admin"];
  }
}
