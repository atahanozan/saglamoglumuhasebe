import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/extensions/uppercase_text_formatter.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/core/widgets/search_field.dart';
import 'package:saglamoglu_muhasebe/view/compdeliverydocs/model/comp_delivery_docs_view_model.dart';

class CompListFilters extends StatelessWidget {
  const CompListFilters({
    super.key,
    required this.onFilterComplete,
    required this.filterClean,
  });

  final VoidCallback onFilterComplete;
  final VoidCallback filterClean;

  @override
  Widget build(BuildContext context) {
    final CompDeliveryDocsViewModel model = CompDeliveryDocsViewModel.instance;
    return SearchField(
      controller: model.searchController,
      onSearchComplete: onFilterComplete,
      formatters: [
        UppercaseTextFormatter(),
      ],
      cleanFilter: filterClean,
      backColor: CustomThemeColors.customBlack.c800 ?? Colors.transparent,
    );
  }
}
