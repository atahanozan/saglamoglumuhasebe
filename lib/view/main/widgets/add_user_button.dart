import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/view/adduser/add_user_view.dart';

class AddUserButton extends StatelessWidget {
  const AddUserButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => AddUserView())),
      child: Text("Kullanıcılar"),
    );
  }
}
