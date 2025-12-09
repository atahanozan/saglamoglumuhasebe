import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/view/tesdocs/widgets/tes_section_row.dart';

class TesdocTesSection extends StatelessWidget {
  const TesdocTesSection({
    super.key,
    required this.statuNo,
    required this.startUser,
    required this.startDate,
    required this.signUser,
    required this.signDate,
    required this.checkUser,
    required this.checkDate,
    required this.startOperation,
    required this.signFunction,
    required this.checkFunction,
  });

  final String statuNo;
  final String startUser;
  final String startDate;
  final String signUser;
  final String signDate;
  final String checkUser;
  final String checkDate;
  final VoidCallback startOperation;
  final VoidCallback signFunction;
  final VoidCallback checkFunction;

  @override
  Widget build(BuildContext context) {
    return statuNo == "0"
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: ElevatedButton(
              onPressed: startOperation,
              style: ElevatedButton.styleFrom(
                fixedSize: Size(80, 50),
              ),
              child: Text("Belgeyi Talep Et"),
            ),
          )
        : Container(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TesSectionRow(
                    rowName: "Şubeye Gönderildi",
                    userName: startUser,
                    rowDate: startDate,
                    rowColor: statuNo == "1"
                        ? CustomThemeColors.customYellow.c100!
                        : Colors.white,
                    isCurrent: statuNo == "1",
                    sectionRowFunction: () {},
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: TesSectionRow(
                    rowName: "İmza Alındı",
                    userName: signUser,
                    rowDate: signDate,
                    rowColor: statuNo == "2"
                        ? CustomThemeColors.customYellow.c100!
                        : Colors.white,
                    isCurrent: statuNo == "2",
                    sectionRowFunction: signFunction,
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: TesSectionRow(
                    rowName: "Kontrol Edildi",
                    userName: checkUser,
                    rowDate: checkDate,
                    rowColor: Colors.white,
                    isCurrent: false,
                    sectionRowFunction: checkFunction,
                  ),
                ),
              ],
            ),
          );
  }
}
