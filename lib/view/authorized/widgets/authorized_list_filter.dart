import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/extensions/uppercase_text_formatter.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/core/widgets/search_field.dart';
import 'package:saglamoglu_muhasebe/view/authorized/model/authorized_view_model.dart';

class AuthorizedListFilter extends StatelessWidget {
  const AuthorizedListFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthorizedViewModel model = AuthorizedViewModel.init;
    return SearchField(
      padding: const EdgeInsets.only(
        left: 20,
        right: 90,
        top: 20,
        bottom: 20,
      ),
      controller: model.searchController,
      onSearchComplete: () {
        model.updateAuthorizedDataFilter();
      },
      cleanFilter: () {
        model.cleanFilter();
      },
      formatters: [
        UppercaseTextFormatter(),
      ],
      backColor: CustomThemeColors.customBlack.c800 ?? Colors.transparent,
    );
  }
}
