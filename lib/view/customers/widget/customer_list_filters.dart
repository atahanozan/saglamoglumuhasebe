import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/extensions/uppercase_text_formatter.dart';
import 'package:saglamoglu_muhasebe/core/widget/search_field.dart';
import 'package:saglamoglu_muhasebe/view/customers/customers_view_model.dart';

class CustomerListFilters extends StatelessWidget {
  const CustomerListFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomersViewModel model = CustomersViewModel.init;
    return SearchField(
      controller: model.searchController,
      onSearchComplete: () {
        model.updateFilterWithSearch(model.searchController.text);
      },
      formatters: [
        UppercaseTextFormatter(),
      ],
      cleanFilter: () {
        model.cleanilter();
      },
    );
  }
}
