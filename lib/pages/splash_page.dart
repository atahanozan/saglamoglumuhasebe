import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saglamoglu_muhasebe/helper/ui/custom_colors.dart';
import 'package:saglamoglu_muhasebe/pages/home_navigate_page.dart';
import 'package:saglamoglu_muhasebe/pages/login_page.dart';
import 'package:saglamoglu_muhasebe/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthService authService = AuthService();
  String uid = "";

  Future<void> getUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      uid = prefs.getString("uid") ?? "";
    });
  }

  late Timer timer;

  void getTimer() {
    timer = Timer(const Duration(seconds: 3), () {
      getUser(uid);
    });
  }

  Future<void> getUser(String userUid) async {
    if (uid == "") {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => LoginPage(),
          ),
        );
      }
    } else {
      String? name = await authService.getUserName(userUid);
      bool admin = await authService.getUserAdmin(userUid);
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeNavigatePage(
              admin: admin,
              name: name.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    getUid().whenComplete(() {
      getTimer();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          "assets/images/saglamoglu_logo.svg",
          colorFilter: const ColorFilter.mode(
            CustomColors.customYellow,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
