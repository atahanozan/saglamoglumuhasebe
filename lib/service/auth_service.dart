import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<String?> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (err) {
      return err.message;
    }
  }

  Future<UserCredential> user(String email, String password) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}
