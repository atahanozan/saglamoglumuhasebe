import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/view/login/login_view.dart';
import 'package:saglamoglu_muhasebe/view/login/widgets/doublelogin/model/double_login_view_model.dart';

class DoubleLoginView extends StatelessWidget {
  const DoubleLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final DoubleLoginViewModel model = DoubleLoginViewModel();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: 400,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 0.2,
              color: Colors.black45,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
                "Bu kullanıcı ile farklı bir cihazda oturum açmış bulunmaktasınız. Kullanıcı ile devam edebilmek için öncelikle diğer cihazlardan çıkışınızı yapınız."),
            ElevatedButton(
                onPressed: () {
                  model.logout();
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => LoginView()));
                },
                child: Text("Tüm Cihazlarda Oturumu Kapat"))
          ],
        ),
      ),
    );
  }
}
