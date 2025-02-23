import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglamoglu_muhasebe/helper/ui/custom_colors.dart';
import 'package:saglamoglu_muhasebe/helper/custom_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerInfoTable extends StatefulWidget {
  const CustomerInfoTable({
    super.key,
    required this.title,
    required this.tckn,
    required this.adress,
    required this.placeofbirth,
    required this.job,
    required this.iban,
    required this.frontidimg,
    required this.backidimg,
    required this.phoneNumber,
    required this.microId,
    required this.docId,
  });

  final String title;
  final String tckn;
  final String adress;
  final String placeofbirth;
  final String job;
  final String iban;
  final String frontidimg;
  final String backidimg;
  final String phoneNumber;
  final String microId;
  final String? docId;

  @override
  State<CustomerInfoTable> createState() => _CustomerInfoTableState();
}

class _CustomerInfoTableState extends State<CustomerInfoTable> {
  final CustomWidgets customWidgets = CustomWidgets();
  bool idVisibility = false;
  Icon btnIcon = const Icon(Icons.arrow_drop_down);

  Future<void> sendWhatsappMess(String contact) async {
    String webUrl =
        'https://api.whatsapp.com/send/?phone=$contact&text=Merhaba';

    await launchUrl(Uri.parse(webUrl));
  }

  Future<void> copInfos(String copyText, BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: copyText));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Bilgiler Kopyalandı",
            style: GoogleFonts.raleway(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: CustomColors.customWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: GoogleFonts.raleway(fontSize: 18),
            ),
            const SizedBox(height: 25),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: IntrinsicColumnWidth(),
                2: IntrinsicColumnWidth(),
              },
              children: [
                TableRow(
                  children: [
                    Text(
                      "Tckn",
                      style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        copInfos(widget.tckn, context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CustomColors.customGrey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          widget.tckn,
                          style: GoogleFonts.raleway(),
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 15,
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      "Ad Soyad",
                      style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        copInfos(widget.title, context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CustomColors.customGrey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          widget.title,
                          style: GoogleFonts.raleway(),
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 15,
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      "Iban",
                      style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        copInfos(widget.iban, context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CustomColors.customGrey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          widget.iban,
                          style: GoogleFonts.raleway(),
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 15,
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      "Tel",
                      style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        sendWhatsappMess(widget.phoneNumber);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CustomColors.customGrey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          widget.phoneNumber,
                          style: GoogleFonts.raleway(),
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 15,
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      "Adres",
                      style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        copInfos(widget.adress, context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CustomColors.customGrey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          widget.adress,
                          style: GoogleFonts.raleway(),
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 15,
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      "Doğum Yeri",
                      style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        copInfos(widget.placeofbirth, context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CustomColors.customGrey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          widget.placeofbirth,
                          style: GoogleFonts.raleway(),
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 15,
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      "Meslek",
                      style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        copInfos(widget.job, context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: CustomColors.customGrey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          widget.job,
                          style: GoogleFonts.raleway(),
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 15,
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                )
              ],
            ),
            const Divider(),
            Text(
              "Kimlik Görseli",
              style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: CustomColors.customGrey,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 70,
                        child: Image.network(widget.frontidimg),
                      ),
                      SizedBox(
                        height: 70,
                        child: Image.network(widget.backidimg),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
