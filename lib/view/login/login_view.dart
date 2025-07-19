import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/core/widgets/error_box.dart';
import 'package:saglamoglu_muhasebe/view/login/login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginViewModel model = LoginViewModel.init;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Center(
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
              child: Form(
                key: model.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/saglamoglu_logo.svg",
                      colorFilter: ColorFilter.mode(
                        CustomThemeColors.customYellow.c800 ?? Colors.amber,
                        BlendMode.srcIn,
                      ),
                    ),
                    const Spacer(),
                    TextFormField(
                      controller: model.emailController,
                      onEditingComplete: () {
                        model.login(context);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: Icon(Icons.email),
                        labelText: "E-mail",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "mail@saglamoglualtin.com",
                      ),
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      controller: model.passwordController,
                      obscureText: model.obsecureText.value,
                      onEditingComplete: () {
                        model.login(context);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          prefixIcon: Icon(Icons.key),
                          labelText: "Şifre",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "**********",
                          suffixIcon: IconButton(
                            onPressed: () {
                              model.changeObsecure();
                            },
                            icon: Icon(Icons.remove_red_eye),
                          )),
                    ),
                    SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {
                        model.login(context);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                          MediaQuery.of(context).size.width,
                          50,
                        ),
                      ),
                      child: Text("Giriş"),
                    ),
                    const Spacer(),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Şifremi Unuttum"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => ErrorBox(
              boxVisibility: model.errBoxVisibility.value,
              content: model.errContent.value,
              closeBox: model.closeErrBox,
            ),
          ),
        ],
      ),
    );
  }
}
