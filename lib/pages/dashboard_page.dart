import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/dashboard/delivery_docs_statu.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/dashboard/favorite_buttons.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/dashboard/today_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    super.key,
    this.name = "",
    this.customerCount = 0,
    this.admin = false,
  });

  final String name;
  final int customerCount;
  final bool admin;

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;
    const double gridSize = 20;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(20),
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
                Text(
                  "Sürüm: 2",
                  style: pageStyle.bodySmall,
                ),
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
                              "Sık Kullanılanlar",
                              style: pageStyle.titleMedium,
                            ),
                            const Divider(),
                            Text(
                                "En çok kullanılan sekmeler burada listelenecektir.")
                          ],
                        ),
                        admin: admin,
                      ),
                      SizedBox(height: gridSize),
                      FavoriteButtons(
                        childs: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Toplam Müşteri Adedi",
                              style: pageStyle.titleMedium,
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
    );
  }
}
