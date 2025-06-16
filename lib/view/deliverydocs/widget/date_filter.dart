import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/enums/delivery_doc_stream_filter_enums.dart';

class DateFilter extends StatelessWidget {
  const DateFilter({
    super.key,
    required this.datePickFunc,
    required this.filterEnum,
  });

  final VoidCallback datePickFunc;
  final DeliveryDocStreamFilterEnums filterEnum;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: datePickFunc,
      child: filterEnum == DeliveryDocStreamFilterEnums.date
          ? Icon(
              Icons.filter_alt_rounded,
            )
          : Icon(
              Icons.filter_alt_outlined,
            ),
    );
  }
}
