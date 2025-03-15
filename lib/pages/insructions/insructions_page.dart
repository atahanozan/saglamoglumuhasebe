import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglamoglu_muhasebe/pages/insructions/add_insruction.dart';

class InsructionsPage extends StatelessWidget {
  const InsructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Talimatlar",
                style: GoogleFonts.raleway(fontSize: 25),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      "Talimatlar",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddInsruction(),
                        ),
                      );
                    },
                    child: const Text("Talimat Ekle"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
