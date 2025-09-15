import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/enums/delivery_doc_stream_filter_enums.dart';
import 'package:saglamoglu_muhasebe/core/extensions/money_text_formatter.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/model/delivery_docs_view_model.dart';

class PriceFilter extends StatelessWidget {
  const PriceFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final DeliveryDocsViewModel model = DeliveryDocsViewModel.instance;
    return TextField(
      controller: model.priceController,
      onEditingComplete: () {
        model.setDeliveryDocStream(
            filterEnum: DeliveryDocStreamFilterEnums.price,
            newPriceFilter: model.priceController.text);
      },
      inputFormatters: [
        MoneyTextFormatter(),
      ],
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.money_rounded),
      ),
    );
  }
}
