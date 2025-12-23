import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/widgets/custom_formfield_widget.dart';
import 'package:saglamoglu_muhasebe/view/changepassword/model/change_passwor_view_model.dart';
import 'package:saglamoglu_muhasebe/view/changepassword/widgets/new_password_statu_texts.dart';
import 'package:saglamoglu_muhasebe/view/main/main_view.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangePassworViewModel model = ChangePassworViewModel.instance;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
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
                "Şifre Değişikliği",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 20),
              Text(
                  "Şifreniz en az 8 karakterden oluşmalı; harf, rakam ve özel karakter (!#+=?-_.,*%) içermelidir."),
              SizedBox(height: 20),
              Obx(() {
                return CustomFormfieldWidget(
                  isPassword: true,
                  formName: "Yeni Şifre",
                  isObsecure: model.isObsecure.value,
                  obsecureFunction: () {
                    model.changeObsecure();
                  },
                  inputFormatter: [
                    TextInputFormatter.withFunction((oldText, newText) {
                      if (newText.text.contains(RegExp(r'^(?=.*?[a-zA-Z])'))) {
                        model.changeContainLetter(true);
                      }
                      if (newText.text.contains(RegExp(r'^(?=.*?[0-9])'))) {
                        model.changeContainNumber(true);
                      }
                      if (newText.text
                          .contains(RegExp(r'^(?=.*?[!@#\$&*~])'))) {
                        model.changeContainSpecialCharacter(true);
                      }

                      if (newText.text.characters.length > 7) {
                        model.changeIsLongerEnough(true);
                      }
                      if (!newText.text.contains(RegExp(r'^(?=.*?[a-zA-Z])'))) {
                        model.changeContainLetter(false);
                      }
                      if (!newText.text.contains(RegExp(r'^(?=.*?[0-9])'))) {
                        model.changeContainNumber(false);
                      }
                      if (!newText.text
                          .contains(RegExp(r'^(?=.*?[!@#\$&*~])'))) {
                        model.changeContainSpecialCharacter(false);
                      }

                      if (newText.text.characters.length <= 7) {
                        model.changeIsLongerEnough(false);
                      }
                      return newText;
                    })
                  ],
                  controller: model.newPasswordController,
                  hint: "Yeni Şifre",
                );
              }),
              Obx(() {
                return CustomFormfieldWidget(
                  isPassword: true,
                  isObsecure: model.isObsecure.value,
                  formName: "Yeni Şifre Tekrar",
                  inputFormatter: [
                    TextInputFormatter.withFunction((oldText, newText) {
                      if (newText.text == model.newPasswordController.text) {
                        model.changeIsPasswordsEqual(true);
                      }
                      if (newText.text != model.newPasswordController.text) {
                        model.changeIsPasswordsEqual(false);
                      }
                      return newText;
                    })
                  ],
                  obsecureFunction: () {
                    model.changeObsecure();
                  },
                  controller: model.newPasswordAgainController,
                  hint: "Yeni Şifre Tekrar",
                );
              }),
              SizedBox(height: 20),
              Obx(() {
                return NewPasswordStatuTexts(
                    isContains: model.isLongerEnough.value,
                    content: "8 karakterden uzun");
              }),
              Obx(() {
                return NewPasswordStatuTexts(
                    isContains: model.isContainsLetter.value,
                    content: "Harf içeriyor.");
              }),
              Obx(() {
                return NewPasswordStatuTexts(
                    isContains: model.isContainsNumber.value,
                    content: "Rakam içeriyor.");
              }),
              Obx(() {
                return NewPasswordStatuTexts(
                    isContains: model.isContainsSpecialCharacter.value,
                    content: r'Özel karakter içeriyor (!@#\$&*~).');
              }),
              Obx(() {
                return NewPasswordStatuTexts(
                    isContains: model.isPasswordsEqual.value,
                    content: "Şifreler eşleşiyor.");
              }),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (model.isContainsLetter.value &&
                      model.isContainsNumber.value &&
                      model.isContainsSpecialCharacter.value &&
                      model.isLongerEnough.value &&
                      model.isPasswordsEqual.value) {
                    model.changePassword(
                        model.newPasswordController.text, context);
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => MainView()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Şifre kurallarını kontrol ederek tekrar deneyiniz...")));
                  }
                },
                child: Text("Şifre Değiştir"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
