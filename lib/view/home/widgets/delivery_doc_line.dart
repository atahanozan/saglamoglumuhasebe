import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';

class DeliveryDocLine extends StatelessWidget {
  const DeliveryDocLine({
    super.key,
    required this.dataCount,
    required this.listLenght,
    required this.xData,
    required this.yData,
  });
  final String dataCount;
  final int listLenght;
  final List<int> xData;
  final List<int> yData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: CustomThemeColors.customBlack.c50,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Teslim Dosyası Günlük Tamamlanma",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 12),
          Flexible(
              child: BarChart(BarChartData(
            barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                    rod.toY.toString(),
                    TextStyle(
                      fontSize: 14,
                    ));
              },
              fitInsideVertically: true,
              direction: TooltipDirection.auto,
            )),
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            barGroups: List.generate(
              listLenght,
              (index) => BarChartGroupData(
                showingTooltipIndicators: [0, 1],
                x: xData[index],
                barRods: [
                  BarChartRodData(
                    width: 20,
                    fromY: 0,
                    toY: yData[index].toDouble(),
                  ),
                ],
              ),
            ),
          )))
        ],
      ),
    );
  }
}
