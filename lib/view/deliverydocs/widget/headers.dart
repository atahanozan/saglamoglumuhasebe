import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/enums/delivery_doc_stream_filter_enums.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/widget/company_filter.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/widget/date_filter.dart';

class Headers extends StatelessWidget {
  const Headers({
    super.key,
    required this.datePickFunc,
    required this.companyPickFunc,
    required this.filterEnum,
  });

  final VoidCallback datePickFunc;
  final VoidCallback companyPickFunc;
  final DeliveryDocStreamFilterEnums filterEnum;

  @override
  Widget build(BuildContext context) {
    final TextStyle? pageStyle =
        Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            );
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(width: 26),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Tarih",
              style: pageStyle,
            ),
            DateFilter(
              datePickFunc: datePickFunc,
              filterEnum: filterEnum,
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Müşteri",
              style: pageStyle,
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "ilgilenen",
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        )),
        const SizedBox(width: 5),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Firma",
              textAlign: TextAlign.left,
              style: pageStyle,
            ),
            CompanyFilter(
                companyPickFunc: companyPickFunc, filterEnum: filterEnum)
          ],
        ),
        const SizedBox(width: 5),
        Expanded(
            child: Text(
          "Tutar",
          textAlign: TextAlign.right,
          style: pageStyle,
        )),
        const SizedBox(width: 30),
        Text(
          "İşlemler",
          style: pageStyle,
        ),
        const SizedBox(width: 26),
      ],
    );
  }
}
