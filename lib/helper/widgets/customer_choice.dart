import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglamoglu_muhasebe/helper/ui/custom_colors.dart';

class CustomerChoice extends StatelessWidget {
  const CustomerChoice({
    super.key,
    required this.bnt1Fun,
    required this.bnt2Fun,
    required this.bnt3Fun,
    required this.bnt4Fun,
    required this.btn1Color,
    required this.btn2Color,
    required this.btn3Color,
    required this.btn4Color,
  });

  final Color btn1Color;
  final Color btn2Color;
  final Color btn3Color;
  final Color btn4Color;
  final VoidCallback bnt1Fun;
  final VoidCallback bnt2Fun;
  final VoidCallback bnt3Fun;
  final VoidCallback bnt4Fun;

  @override
  Widget build(BuildContext context) {
    final TextStyle btnText = GoogleFonts.raleway();
    final TextStyle contentStyle = GoogleFonts.raleway();
    final double btnWidht = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: CustomColors.customWhite,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: btnWidht,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Eklemek istediğiniz müşteri tipini aşağıdan seçtikten sonra müşteri ekleme işlemine devam edebilirsiniz.",
              style: contentStyle,
            ),
          ),
          InkWell(
            onTap: bnt1Fun,
            child: Container(
              width: btnWidht,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: btn1Color,
              ),
              child: Text(
                "Bireysel",
                style: btnText,
              ),
            ),
          ),
          InkWell(
            onTap: bnt2Fun,
            child: Container(
              width: btnWidht,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: btn2Color,
              ),
              child: Text(
                "Şahıs Şirketi",
                style: btnText,
              ),
            ),
          ),
          InkWell(
            onTap: bnt3Fun,
            child: Container(
              width: btnWidht,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: btn3Color,
              ),
              child: Text(
                "LTD ve AŞ Şirketi",
                style: btnText,
              ),
            ),
          ),
          InkWell(
            onTap: bnt4Fun,
            child: Container(
              width: btnWidht,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: btn4Color,
              ),
              child: Text(
                "Teslim Müşterisi",
                style: btnText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
