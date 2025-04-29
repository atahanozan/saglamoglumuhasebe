import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:saglamoglu_muhasebe/helper/ui/custom_colors.dart';
import 'package:saglamoglu_muhasebe/helper/utils/texts.dart';

class TodayWidget extends StatelessWidget {
  const TodayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    final String dayName = DateFormat('EEEE').format(DateTime.now());

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColors.customWhite,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${Texts.date(today.day.toString())}.${Texts.date(today.month.toString())}.${today.year}',
            style: GoogleFonts.ribeye(
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
          SizedBox(height: 20),
          Text(
            Texts.days(dayName),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
