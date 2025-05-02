import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saglamoglu_muhasebe/helper/ui/custom_colors.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/side_bar_buttons.dart';
import 'package:saglamoglu_muhasebe/pages/authorized_docs.dart';
import 'package:saglamoglu_muhasebe/pages/customers/customers_list.dart';
import 'package:saglamoglu_muhasebe/pages/delivery_docs/delivery_docs_list.dart';
import 'package:saglamoglu_muhasebe/pages/dashboard_page.dart';
import 'package:saglamoglu_muhasebe/pages/delivery_docs/done_delivery_docs.dart';
import 'package:saglamoglu_muhasebe/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeNavigatePage extends StatefulWidget {
  const HomeNavigatePage({
    super.key,
    required this.admin,
    required this.name,
  });

  final bool admin;
  final String name;

  @override
  State<HomeNavigatePage> createState() => _HomeNavigatePageState();
}

class _HomeNavigatePageState extends State<HomeNavigatePage> {
  List<Widget> pages = [
    DashboardPage(
      customerList: () {},
      doneDocs: () {},
      waitingDocs: () {},
    ),
    CustomersList(),
    const DeliveryDocsList(),
    const DoneDeliveryDocs(),
    const AuthorizedDocs(),
  ];
  String uid = "";
  String btnName = DateTime.now().toString().split(" ")[0];
  int statuTrueLenght = 0;
  int statuFalseLenght = 0;
  int customerCount = 0;
  int pageIndex = 0;

  Future<void> getUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      uid = prefs.getString("useruid") ?? "";
    });
  }

  Future<void> getDocStatu() async {
    await FirebaseFirestore.instance
        .collection("deliverycustomers")
        .count()
        .get()
        .then((value) {
      setState(() {
        customerCount = value.count!;
      });
    });
    setState(() {
      pages = [
        DashboardPage(
          name: widget.name,
          admin: widget.admin,
          customerCount: customerCount,
          customerList: () {
            changePage(1);
          },
          doneDocs: () {
            changePage(3);
          },
          waitingDocs: () {
            changePage(2);
          },
        ),
        const CustomersList(),
        DeliveryDocsList(admin: widget.admin),
        DoneDeliveryDocs(admin: widget.admin),
        AuthorizedDocs(admin: widget.admin),
      ];
    });
  }

  void changePage(int pageNumber) {
    setState(() {
      pageIndex = pageNumber;
    });
  }

  @override
  void initState() {
    getUid();
    getDocStatu();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;
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
                  Text(
                    "Sürüm: 8",
                    style: pageStyle.bodySmall?.copyWith(
                      color: CustomColors.customYellow,
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
                      btnIcon: Icons.home_rounded,
                      btnFunc: () {
                        getDocStatu();
                        changePage(0);
                      }),
                  SideBarButtons(
                      visibility: widget.admin,
                      btnColor: pageIndex == 1
                          ? CustomColors.customGrey
                          : Colors.transparent,
                      childColor: pageIndex == 1
                          ? CustomColors.customBlack
                          : CustomColors.customWhite,
                      btnName: "Müşteriler",
                      btnIcon: Icons.group_rounded,
                      btnFunc: () {
                        if (widget.admin) {
                          changePage(1);
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
                      }),
                  SideBarButtons(
                      btnColor: pageIndex == 2
                          ? CustomColors.customGrey
                          : Colors.transparent,
                      childColor: pageIndex == 2
                          ? CustomColors.customBlack
                          : CustomColors.customWhite,
                      btnName: "Bekleyen Teslimler",
                      btnIcon: Icons.list_alt_rounded,
                      btnFunc: () {
                        changePage(2);
                      }),
                  SideBarButtons(
                      visibility: widget.admin,
                      btnColor: pageIndex == 3
                          ? CustomColors.customGrey
                          : Colors.transparent,
                      childColor: pageIndex == 3
                          ? CustomColors.customBlack
                          : CustomColors.customWhite,
                      btnName: "Gelen Teslimler",
                      btnIcon: Icons.list_alt_rounded,
                      btnFunc: () {
                        changePage(3);
                      }),
                  SideBarButtons(
                      btnColor: pageIndex == 4
                          ? CustomColors.customGrey
                          : Colors.transparent,
                      childColor: pageIndex == 4
                          ? CustomColors.customBlack
                          : CustomColors.customWhite,
                      btnName: "Yetki Listesi",
                      btnIcon: Icons.contact_page_rounded,
                      btnFunc: () {
                        changePage(4);
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
