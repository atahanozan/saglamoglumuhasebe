import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saglamoglu_muhasebe/helper/ui/custom_colors.dart';
import 'package:saglamoglu_muhasebe/pages/home_navigate_page.dart';
import 'package:saglamoglu_muhasebe/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String uid = "";

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
      });
    });
  }

  Future<void> getUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      uid = prefs.getString("useruid") ?? "";
    });
  }

  @override
  void initState() {
    getUid().whenComplete(() {
      getUserAdmin(uid);
    });

    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (uid == "") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => LoginPage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeNavigatePage(
              admin: admin,
              name: name,
            ),
          ),
        );
      }
    });

    super.initState();
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
