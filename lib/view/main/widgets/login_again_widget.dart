import 'package:flutter/material.dart';

class LoginAgainWidget extends StatelessWidget {
  const LoginAgainWidget({super.key, required this.onButtonPressed});

  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width / 3,
      padding: const EdgeInsets.all(32),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            "Oturumunuz otomatik olarak kapatılmıştır. Tekrar giriş yapınız.",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Spacer(),
          ElevatedButton(
            onPressed: onButtonPressed,
            child: Text("Tekrar Giriş Yap"),
          ),
        ],
      ),
    );
  }
}
