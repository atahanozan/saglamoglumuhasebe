import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Talepler",
                style: GoogleFonts.raleway(fontSize: 25),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
