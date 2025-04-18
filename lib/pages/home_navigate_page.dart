import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saglamoglu_muhasebe/helper/ui/custom_colors.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/side_bar_buttons.dart';
import 'package:saglamoglu_muhasebe/pages/customers/customers_list.dart';
import 'package:saglamoglu_muhasebe/pages/customers/delivery_docs_list.dart';
import 'package:saglamoglu_muhasebe/pages/dashboard_page.dart';
import 'package:saglamoglu_muhasebe/pages/insructions/insructions_page.dart';
import 'package:saglamoglu_muhasebe/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeNavigatePage extends StatefulWidget {
  const HomeNavigatePage({super.key});

  @override
  State<HomeNavigatePage> createState() => _HomeNavigatePageState();
}

class _HomeNavigatePageState extends State<HomeNavigatePage> {
  List<Widget> pages = [
    DashboardPage(),
    const CustomersList(),
    const DeliveryDocsList(),
    const InsructionsPage(),
  ];
  String uid = "";
  String name = "";

  Future<void> getUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      uid = prefs.getString("useruid") ?? "";
    });
  }

  bool admin = false;

  Future<void> getUserAdmin() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((value) {
      setState(() {
        admin = value["admin"];
      });
    });
  }

  int pageIndex = 0;

  @override
  void initState() {
    getUid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customGrey,
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: CustomColors.customBlack,
            ),
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/images/saglamoglu_logo.svg",
                    colorFilter: const ColorFilter.mode(
                      CustomColors.customYellow,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(height: 50),
                  SideBarButtons(
                      btnColor: pageIndex == 0
                          ? CustomColors.customGrey
                          : Colors.transparent,
                      childColor: pageIndex == 0
                          ? CustomColors.customBlack
                          : CustomColors.customWhite,
                      btnName: "Ana Sayfa",
                      btnIcon: Icons.home,
                      btnFunc: () {
                        setState(() {
                          pageIndex = 0;
                        });
                      }),
                  SideBarButtons(
                      btnColor: pageIndex == 1
                          ? CustomColors.customGrey
                          : Colors.transparent,
                      childColor: pageIndex == 1
                          ? CustomColors.customBlack
                          : CustomColors.customWhite,
                      btnName: "Müşteriler",
                      btnIcon: Icons.list_alt,
                      btnFunc: () {
                        getUserAdmin().then((value) {
                          if (admin) {
                            setState(() {
                              pageIndex = 1;
                            });
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Bu alan için yetkiniz bulunmamaktadır !"),
                                  backgroundColor: Colors.redAccent.shade200,
                                ),
                              );
                            }
                          }
                        });
                      }),
                  SideBarButtons(
                      btnColor: pageIndex == 2
                          ? CustomColors.customGrey
                          : Colors.transparent,
                      childColor: pageIndex == 2
                          ? CustomColors.customBlack
                          : CustomColors.customWhite,
                      btnName: "Teslim Dosyaları",
                      btnIcon: Icons.group_add,
                      btnFunc: () {
                        setState(() {
                          pageIndex = 2;
                        });
                      }),
                  SideBarButtons(
                      btnColor: pageIndex == 3
                          ? CustomColors.customGrey
                          : Colors.transparent,
                      childColor: pageIndex == 3
                          ? CustomColors.customBlack
                          : CustomColors.customWhite,
                      btnName: "Talimatlar",
                      btnIcon: Icons.request_page_rounded,
                      btnFunc: () {
                        setState(() {
                          pageIndex = 3;
                        });
                      }),
                  const Spacer(),
                  const Divider(
                    thickness: 0.1,
                  ),
                  SideBarButtons(
                      btnColor: Colors.transparent,
                      childColor: CustomColors.customYellow,
                      btnName: "Profil",
                      btnIcon: Icons.account_circle_outlined,
                      btnFunc: () {}),
                  SideBarButtons(
                      btnColor: Colors.transparent,
                      childColor: CustomColors.customYellow,
                      btnName: "Çıkış",
                      btnIcon: Icons.exit_to_app,
                      btnFunc: () async {
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LoginPage(),
                            ),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
          Expanded(
            child: pages[pageIndex],
          ),
        ],
      ),
    );
  }
}
