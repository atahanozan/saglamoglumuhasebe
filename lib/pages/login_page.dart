import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saglamoglu_muhasebe/helper/ui/custom_colors.dart';
import 'package:saglamoglu_muhasebe/pages/home_navigate_page.dart';
import 'package:saglamoglu_muhasebe/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obsecureText = true;
  String name = "";

  bool admin = false;

  Future<void> getUserAdmin(String uid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((value) {
      setState(() {
        admin = value["admin"];
        name = value["name"];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HomeNavigatePage(
              admin: admin,
              name: name,
            ),
          ),
        );
      });
    });
  }

  Future<void> setUser(String? uid) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString("useruid", uid.toString());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/saglamoglu_logo.svg",
                colorFilter: const ColorFilter.mode(
                  CustomColors.customYellow,
                  BlendMode.srcIn,
                ),
              ),
              const Spacer(),
              TextField(
                controller: _emailController,
                onEditingComplete: () async {
                  final message = await AuthService()
                      .login(_emailController.text, _passwordController.text);
                  final user = await AuthService()
                      .user(_emailController.text, _passwordController.text);
                  if (context.mounted) {
                    if (message == "Success") {
                      getUserAdmin(user.user!.uid.toString());

                      setUser(user.user?.uid);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          message.toString(),
                        ),
                      ),
                    );
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.email),
                  labelText: "E-mail",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "muhasebe@saglamoglualtin.com",
                ),
              ),
              SizedBox(height: 25),
              TextField(
                controller: _passwordController,
                obscureText: obsecureText,
                onEditingComplete: () async {
                  final message = await AuthService()
                      .login(_emailController.text, _passwordController.text);
                  final user = await AuthService()
                      .user(_emailController.text, _passwordController.text);
                  if (context.mounted) {
                    if (message == "Success") {
                      getUserAdmin(user.user!.uid.toString());

                      setUser(user.user?.uid);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          message.toString(),
                        ),
                      ),
                    );
                  }
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
                        setState(() {
                          obsecureText = !obsecureText;
                        });
                      },
                      icon: Icon(Icons.remove_red_eye),
                    )),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  final message = await AuthService()
                      .login(_emailController.text, _passwordController.text);
                  final user = await AuthService()
                      .user(_emailController.text, _passwordController.text);
                  if (context.mounted) {
                    if (message == "Success") {
                      getUserAdmin(user.user!.uid.toString());

                      setUser(user.user?.uid);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          message.toString(),
                        ),
                      ),
                    );
                  }
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
    );
  }
}
