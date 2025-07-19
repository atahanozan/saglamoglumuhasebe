import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/extensions/money_text_formatter.dart';
import 'package:saglamoglu_muhasebe/core/widgets/search_field.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/widgets/company_filter.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/widgets/date_filter.dart';

class AllFiltersWidget extends StatelessWidget {
  const AllFiltersWidget({
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
          height: filterTabStatu ? 320 : 0,
          padding: const EdgeInsets.all(18),
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      margin: EdgeInsets.only(right: 22, bottom: 12),
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
                            child: DateFilter(
                              datePickFunc: datePickFunc,
                              btnDate: btnDate,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(18),
                      margin: EdgeInsets.only(right: 22, bottom: 12),
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
                            child: CompanyFilter(
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
                      margin: EdgeInsets.only(right: 22, bottom: 12),
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
                              horizontalPadding: 0,
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
            color: Colors.grey.shade100,
          ),
          child: IconButton(
            onPressed: openfilterTab,
            icon: Icon(Icons.keyboard_arrow_down_rounded),
          ),
        ),
        SizedBox(height: 22),
      ],
    );
  }
}
