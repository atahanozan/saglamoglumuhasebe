import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/extensions/money_text_formatter.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/core/widgets/search_field.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/compdeliverydocs/widgets/comp_company_filter.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/compdeliverydocs/widgets/comp_date_filter.dart';

class CompAllFilters extends StatelessWidget {
  const CompAllFilters({
    super.key,
    required this.datePickFunc,
    required this.btnDate,
    required this.saglamFunc,
    required this.elminaFunc,
    required this.saglamKiymetliFunc,
    required this.valueName,
    required this.controller,
    required this.clearFilter,
    required this.openfilterTab,
    required this.filterTabStatu,
    required this.priceFilterFunc,
  });

  final VoidCallback datePickFunc;
  final String btnDate;
  final VoidCallback saglamFunc;
  final VoidCallback elminaFunc;
  final VoidCallback saglamKiymetliFunc;
  final VoidCallback clearFilter;
  final VoidCallback openfilterTab;
  final VoidCallback priceFilterFunc;
  final String valueName;
  final TextEditingController controller;
  final bool filterTabStatu;

  @override
  Widget build(BuildContext context) {
    final TextTheme pageTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        AnimatedContainer(
          padding: const EdgeInsets.only(left: 16, right: 58),
          height: filterTabStatu ? 310 : 0,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: CustomThemeColors.customBlack.c800,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      margin: EdgeInsets.only(bottom: 22),
                      width: 450,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade200,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Tarih  :",
                              style: pageTheme.titleLarge,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: CompDateFilter(
                              datePickFunc: datePickFunc,
                              btnDate: btnDate,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.all(18),
                      margin: EdgeInsets.only(bottom: 22),
                      width: 450,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade200,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Firma  :",
                              style: pageTheme.titleLarge,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: CompCompanyFilter(
                              saglamFunc: saglamFunc,
                              elminaFunc: elminaFunc,
                              saglamKiymetliFunc: saglamKiymetliFunc,
                              valueName: valueName,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      margin: EdgeInsets.only(),
                      width: 450,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade200,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Tutar  :",
                              style: pageTheme.titleLarge,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: SearchField(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 60,
                                top: 12,
                                bottom: 12,
                              ),
                              controller: controller,
                              onSearchComplete: priceFilterFunc,
                              cleanFilter: () {},
                              formatters: [MoneyTextFormatter()],
                              backColor: Colors.transparent,
                              hintText: "Tutar ile ara ...",
                              cleanBtnVisibility: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: clearFilter,
                      child: Text("Temizle"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: CustomThemeColors.customBlack.c800,
          ),
          child: IconButton(
            onPressed: openfilterTab,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: CustomThemeColors.customWhite,
            ),
          ),
        ),
        SizedBox(height: 22),
      ],
    );
  }
}
