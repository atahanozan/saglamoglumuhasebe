import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/dashboard/favorite_buttons.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/dashboard/today_widget.dart';
import 'package:saglamoglu_muhasebe/pages/customers/add_customer.dart';
import 'package:saglamoglu_muhasebe/pages/insructions/add_insruction.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, this.name = ""});

  final String name;

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
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AddInsruction(),
                            ),
                          );
                        },
                        title: const Text("Talimat Ekle"),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AddCustomer(),
                            ),
                          );
                        },
                        title: const Text("Müşteri Ekle"),
                      ),
                      const Divider(),
                    ],
                  ),
                )),
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                    child: FavoriteButtons(
                  childs: Column(
                    children: [
                      Text(
                        "Günlük işlem adetleri ve oranları",
                        style: pageStyle.titleMedium,
                      ),
                    ],
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
