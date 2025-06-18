import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/extensions/money_text_formatter.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/delivery_docs_view_model.dart';

class PriceFilter extends StatelessWidget {
  const PriceFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final DeliveryDocsViewModel model = DeliveryDocsViewModel.init;
    return TextField(
      controller: model.priceController,
      onEditingComplete: () {
        model.updateDataFilterWithPrice(model.priceController.text);
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
