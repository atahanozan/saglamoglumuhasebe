import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryDocsList extends StatelessWidget {
  const DeliveryDocsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Teslim Listesi",
              style: GoogleFonts.raleway(fontSize: 25),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
