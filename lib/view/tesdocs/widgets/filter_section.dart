import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/view/tesdocs/model/tesdoc_view_model.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({super.key, required this.model});

  final TesdocViewModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
      ),
      child: Row(
        children: [
          SizedBox(width: 150, child: Text("KYC Filtreleri:")),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutlinedButton(
                  onPressed: () {
                    model.filterData("tesStatu", "1");
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: model.filterStatu.value == "tesStatu-1"
                        ? CustomThemeColors.customYellow.c700
                        : Colors.transparent,
                    fixedSize: Size(250, 40),
                  ),
                  child: Text("Şubeye Gönderildi"),
                ),
                OutlinedButton(
                  onPressed: () {
                    model.filterData("tesStatu", "2");
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: model.filterStatu.value == "tesStatu-2"
                        ? CustomThemeColors.customYellow.c700
                        : Colors.transparent,
                    fixedSize: Size(250, 40),
                  ),
                  child: Text("İmza Alındı"),
                ),
                OutlinedButton(
                  onPressed: () {
                    model.filterData("tesStatu", "3");
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: model.filterStatu.value == "tesStatu-3"
                        ? CustomThemeColors.customYellow.c700
                        : Colors.transparent,
                    fixedSize: Size(250, 40),
                  ),
                  child: Text("Kontrol Edildi"),
                ),
              ],
            ),
          ),
          SizedBox(width: 150, child: Text("İkamet Filtreleri:")),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutlinedButton(
                  onPressed: () {
                    model.filterData("ikaStatu", "1");
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: model.filterStatu.value == "ikaStatu-1"
                        ? CustomThemeColors.customYellow.c700
                        : Colors.transparent,
                    fixedSize: Size(250, 40),
                  ),
                  child: Text("Şubeye Gönderildi"),
                ),
                OutlinedButton(
                  onPressed: () {
                    model.filterData("ikaStatu", "2");
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: model.filterStatu.value == "ikaStatu-2"
                        ? CustomThemeColors.customYellow.c700
                        : Colors.transparent,
                    fixedSize: Size(250, 40),
                  ),
                  child: Text("İmza Alındı"),
                ),
                OutlinedButton(
                  onPressed: () {
                    model.filterData("ikaStatu", "3");
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: model.filterStatu.value == "ikaStatu-3"
                        ? CustomThemeColors.customYellow.c700
                        : Colors.transparent,
                    fixedSize: Size(250, 40),
                  ),
                  child: Text("Kontrol Edildi"),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              model.clearSearch();
            },
            child: Text("Temizle"),
          ),
        ],
      ),
    );
  }
}
