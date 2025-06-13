import 'package:flutter/material.dart';

class DataInfoCard extends StatelessWidget {
  const DataInfoCard({
    super.key,
    required this.waitingData,
    required this.completedData,
    required this.totalData,
  });

  final String waitingData;
  final String completedData;
  final String totalData;

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Bekleyen Teslim Dosyası:  ",
                style: pageStyle.titleMedium,
              ),
              Text(
                waitingData,
                style: pageStyle.headlineSmall,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Tamamlanan Teslim Dosyası:  ",
                style: pageStyle.titleMedium,
              ),
              Text(
                completedData,
                style: pageStyle.headlineSmall,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Toplam Teslim Dosyası:  ",
                style: pageStyle.titleMedium,
              ),
              Text(
                totalData,
                style: pageStyle.headlineSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
