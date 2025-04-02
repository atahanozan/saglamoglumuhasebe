import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglamoglu_muhasebe/helper/ui/custom_colors.dart';

class WaitingDocs extends StatelessWidget {
  const WaitingDocs({super.key, required this.docFun});

  final VoidCallback docFun;

  @override
  Widget build(BuildContext context) {
    final TextStyle headerStyle = GoogleFonts.raleway(fontSize: 10);
    final TextStyle contentStyle = GoogleFonts.raleway(
      fontWeight: FontWeight.bold,
      fontSize: 60,
    );
    return InkWell(
      onTap: docFun,
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: CustomColors.customWhite,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "İşlem Yapılmamış Teslim Belgesi",
                  style: headerStyle,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "10",
                    style: contentStyle,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Bugün Gelen Teslim Belgesi",
                  style: headerStyle,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "2",
                    style: contentStyle,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
