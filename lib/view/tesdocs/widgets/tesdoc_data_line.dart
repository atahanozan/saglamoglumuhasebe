import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/model/tesdoc_model.dart';
import 'package:saglamoglu_muhasebe/view/tesdocs/widgets/tesdoc_name_section.dart';
import 'package:saglamoglu_muhasebe/view/tesdocs/widgets/tesdoc_tes_section.dart';

class TesdocDataLine extends StatelessWidget {
  const TesdocDataLine({
    super.key,
    required this.model,
    required this.tesdocDelete,
    required this.startOperation,
    required this.tesSignFunc,
    required this.tesCheckFunc,
    required this.ikaSignFunc,
    required this.ikaCheckFunc,
  });

  final TesdocModel model;
  final VoidCallback tesdocDelete;
  final VoidCallback startOperation;
  final VoidCallback tesSignFunc;
  final VoidCallback tesCheckFunc;
  final VoidCallback ikaSignFunc;
  final VoidCallback ikaCheckFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      decoration: BoxDecoration(
        color: DateTime.now().difference(model.dateTime!.toDate()) >
                    const Duration(hours: 12) &&
                model.tesStatu == "1"
            ? Colors.red.shade100
            : Color(0xffE0E0E0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TesdocNameSection(
              model: model,
              tesdocDelete: tesdocDelete,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TesdocTesSection(
              statuNo: model.tesStatu.toString(),
              startUser: model.starterUser.toString(),
              startDate: model.finalDate(),
              signUser: model.signUser.toString(),
              signDate: model.finalsignDate(),
              checkUser: model.checkUser.toString(),
              checkDate: model.finalCheckDate(),
              startOperation: () {},
              signFunction: tesSignFunc,
              checkFunction: tesCheckFunc,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TesdocTesSection(
              statuNo: model.ikaStatu.toString(),
              startUser: model.ikaStarterUser.toString(),
              startDate: model.finalIkaDate(),
              signUser: model.ikaSignUser.toString(),
              signDate: model.finalIkaSignDate(),
              checkUser: model.ikaCheckUser.toString(),
              checkDate: model.finalIkaCheckDate(),
              startOperation: startOperation,
              signFunction: ikaSignFunc,
              checkFunction: ikaCheckFunc,
            ),
          ),
        ],
      ),
    );
  }
}
