import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';

class CompCompanyFilter extends StatelessWidget {
  const CompCompanyFilter({
    super.key,
    required this.saglamFunc,
    required this.elminaFunc,
    required this.saglamKiymetliFunc,
    required this.valueName,
  });

  final VoidCallback saglamFunc;
  final VoidCallback elminaFunc;
  final VoidCallback saglamKiymetliFunc;
  final String valueName;

  @override
  Widget build(BuildContext context) {
    final Size btnSize = Size(200, 30);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: valueName == "Sağlam"
                ? CustomThemeColors.customYellow.c500
                : Colors.transparent,
            minimumSize: btnSize,
          ),
          onPressed: saglamFunc,
          child: Text("Sağlam"),
        ),
        SizedBox(height: 8),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: valueName == "Elmina"
                ? CustomThemeColors.customYellow.c500
                : Colors.transparent,
            minimumSize: btnSize,
          ),
          onPressed: elminaFunc,
          child: Text("Elmina"),
        ),
        SizedBox(height: 8),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: valueName == "Sağlam Kıymetli"
                ? CustomThemeColors.customYellow.c500
                : Colors.transparent,
            minimumSize: btnSize,
          ),
          onPressed: saglamKiymetliFunc,
          child: Text("Sağlam Kıymetli"),
        ),
      ],
    );
  }
}
