import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoService {
  Future<bool?> userUid(String? uid) async {
    final bool admin = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((value) {
      return value["admin"];
    });

    return admin;
  }
}
