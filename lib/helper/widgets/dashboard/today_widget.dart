import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglamoglu_muhasebe/helper/ui/custom_colors.dart';

class TodayWidget extends StatelessWidget {
  const TodayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();

    return Container(
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColors.customWhite,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${today.day}.${today.month}.${today.year}',
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
          const Icon(
            Icons.calendar_month,
            size: 50,
          )
        ],
      ),
    );
  }
}
