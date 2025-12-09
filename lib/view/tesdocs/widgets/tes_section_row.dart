import 'package:flutter/material.dart';

class TesSectionRow extends StatelessWidget {
  const TesSectionRow({
    super.key,
    required this.rowName,
    required this.userName,
    required this.rowDate,
    required this.rowColor,
    required this.isCurrent,
    required this.sectionRowFunction,
  });

  final String rowName;
  final String userName;
  final String rowDate;
  final Color rowColor;
  final bool isCurrent;
  final VoidCallback sectionRowFunction;

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: sectionRowFunction,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: rowColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Text(
              rowName,
              style: pageStyle.titleSmall?.copyWith(
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              ),
            )),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  userName,
                  style: pageStyle.bodySmall,
                ),
                Text(
                  rowDate,
                  style: pageStyle.bodySmall,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
