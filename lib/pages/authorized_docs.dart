import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglamoglu_muhasebe/helper/ui/uppercase_text_formatter.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/authorized_page/authorized_info_band.dart';

class AuthorizedDocs extends StatefulWidget {
  const AuthorizedDocs({super.key});

  @override
  State<AuthorizedDocs> createState() => _AuthorizedDocsState();
}

class _AuthorizedDocsState extends State<AuthorizedDocs> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final TextEditingController nameSearchController = TextEditingController();
  String customerName = "";

  @override
  void dispose() {
    nameSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Yetkili Listesi",
              style: GoogleFonts.raleway(fontSize: 25),
            ),
            const Divider(),
            SizedBox(height: 30),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextField(
                    controller: nameSearchController,
                    inputFormatters: [
                      UppercaseTextFormatter(),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onEditingComplete: () {
                      setState(() {
                        customerName = nameSearchController.text;
                      });
                    },
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        nameSearchController.clear();
                        customerName = "";
                      });
                    },
                    child: Text("Temizle"))
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    "Dosya Türü",
                    style: pageStyle.titleMedium,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Müşteri TCKN/VKN",
                    style: pageStyle.titleMedium,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Müşteri Adı",
                    style: pageStyle.titleMedium,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Yetkili TCKN",
                    style: pageStyle.titleMedium,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Yetkili Adı",
                    style: pageStyle.titleMedium,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Bitiş Tarihi",
                    style: pageStyle.titleMedium,
                  ),
                ),
                Expanded(
                  child: Text(
                    "İşlemler",
                    style: pageStyle.titleMedium,
                  ),
                ),
              ],
            ),
            Divider(),
            Flexible(
              child: StreamBuilder(
                stream: _firebaseFirestore
                    .collection("authorizedcustomers")
                    .where("customername", isGreaterThanOrEqualTo: customerName)
                    .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? const CircularProgressIndicator()
                      : ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot docs = snapshot.data!.docs[index];
                            return AuthorizedInfoBand(
                              docType: docs["doctype"],
                              customerTckn: docs["customertckn"],
                              customerName: docs["customername"],
                              authorizedTckn: docs["authorizedtckn"],
                              authorizedName: docs["authorizedname"],
                              expireDate: docs["seconddate"],
                              docColor: docs["doctype"] == "Talimat"
                                  ? Colors.blue.shade200
                                  : Colors.green.shade200,
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
