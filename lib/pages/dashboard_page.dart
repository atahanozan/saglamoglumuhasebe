import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/dashboard/delivery_docs_statu.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/dashboard/favorite_buttons.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/dashboard/today_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    super.key,
    this.name = "",
    this.statuFalse = 0,
    this.statuTrue = 0,
  });

  final String name;
  final int statuTrue;
  final int statuFalse;

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;

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
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                    child: FavoriteButtons(
                  childs: Column(
                    children: [
                      Text(
                        "Sık Kullanılanlar",
                        style: pageStyle.headlineSmall,
                      ),
                      const SizedBox(height: 30),
                      const Divider(),
                    ],
                  ),
                )),
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                    child: FavoriteButtons(
                  childs: DeliveryDocsStatu(
                    statuFalse: statuFalse,
                    statuTrue: statuTrue,
                    total: statuTrue + statuFalse,
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
