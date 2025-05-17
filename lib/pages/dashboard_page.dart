import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglamoglu_muhasebe/helper/ui/custom_listbutton.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/dashboard/delivery_docs_statu.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/dashboard/favorite_buttons.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/dashboard/today_widget.dart';
import 'package:saglamoglu_muhasebe/pages/customers/add_customer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    super.key,
    this.name = "",
    this.customerCount = 0,
    this.admin = false,
    required this.customerList,
    required this.doneDocs,
    required this.waitingDocs,
    required this.lastName,
  });

  final String name;
  final String lastName;
  final int customerCount;
  final bool admin;
  final VoidCallback waitingDocs;
  final VoidCallback doneDocs;
  final VoidCallback customerList;

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;
    const double gridSize = 20;
    final List<String> tckns = [];
    final Size pageSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: pageSize.height,
        width: pageSize.width,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hoş geldin $name",
                    style: GoogleFonts.raleway(fontSize: 25),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: TodayWidget(),
                  ),
                  const SizedBox(width: gridSize),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FavoriteButtons(
                          childs: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Toplam Müşteri Adedi",
                              ),
                              Divider(),
                              Text(
                                "$customerCount",
                                style: pageStyle.headlineMedium,
                              )
                            ],
                          ),
                          admin: true,
                        ),
                        SizedBox(height: gridSize),
                        FavoriteButtons(
                          childs: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Sık Kullanılanlar",
                              ),
                              const Divider(),
                              SizedBox(
                                child: !admin
                                    ? CustomListbutton(
                                        btnName: "Bekleyen Teslimler",
                                        btnFunc: waitingDocs,
                                      )
                                    : Column(
                                        children: [
                                          CustomListbutton(
                                            btnName: "Müşteri Oluştur",
                                            btnFunc: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => AddCustomer(
                                                    tckns: tckns,
                                                    agentName: name,
                                                    agentLastname: lastName,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          CustomListbutton(
                                            btnName: "Müşteriler",
                                            btnFunc: customerList,
                                          ),
                                          CustomListbutton(
                                            btnName: "Bekleyen Teslimler",
                                            btnFunc: waitingDocs,
                                          ),
                                          CustomListbutton(
                                            btnName: "Gelen Teslimler",
                                            btnFunc: doneDocs,
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                          admin: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: gridSize),
                  Expanded(
                      child: FavoriteButtons(
                    childs: DeliveryDocsStatu(),
                    admin: true,
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
