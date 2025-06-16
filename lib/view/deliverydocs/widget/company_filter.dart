import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/enums/delivery_doc_stream_filter_enums.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/delivery_docs_view_model.dart';

class CompanyFilter extends StatelessWidget {
  const CompanyFilter({
    super.key,
    required this.companyPickFunc,
    required this.filterEnum,
  });

  final VoidCallback companyPickFunc;
  final DeliveryDocStreamFilterEnums filterEnum;

  @override
  Widget build(BuildContext context) {
    final DeliveryDocsViewModel model = DeliveryDocsViewModel.init;
    return Obx(() => Row(
          children: [
            Text("Sağlam"),
            InkWell(
                onTap: () {
                  model.updateCompanyFilter("Sağlam");
                },
                child: Icon(
                  model.companyFilterGeneral.value == "Sağlam"
                      ? Icons.circle
                      : Icons.circle_outlined,
                )),
            SizedBox(width: 8),
            Text("Elmina"),
            InkWell(
              onTap: () {
                model.updateCompanyFilter("Elmina");
              },
              child: Icon(
                model.companyFilterGeneral.value == "Elmina"
                    ? Icons.circle
                    : Icons.circle_outlined,
              ),
            ),
          ],
        ));
  }
}
