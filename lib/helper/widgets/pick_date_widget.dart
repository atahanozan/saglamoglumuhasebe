import 'package:flutter/material.dart';

class PickDateWidget extends StatelessWidget {
  const PickDateWidget({
    super.key,
    required this.picakedDate,
    required this.pickDateFunc,
  });

  final String picakedDate;
  final VoidCallback pickDateFunc;

  @override
  Widget build(BuildContext context) {
    const double customHeight = 40;
    const double customPadding = 10;
    const double customRadius = 15;
    Color borderColor = Colors.grey.shade400;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          height: customHeight,
          padding: const EdgeInsets.symmetric(horizontal: customPadding),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: borderColor),
              left: BorderSide(color: borderColor),
              bottom: BorderSide(color: borderColor),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(customRadius),
              bottomLeft: Radius.circular(customRadius),
            ),
          ),
          child: Text(picakedDate == "" ? "                  " : picakedDate),
        ),
        InkWell(
          onTap: pickDateFunc,
          child: Container(
            alignment: Alignment.center,
            height: customHeight,
            padding: const EdgeInsets.symmetric(horizontal: customPadding),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: borderColor),
                right: BorderSide(color: borderColor),
                bottom: BorderSide(color: borderColor),
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(customRadius),
                bottomRight: Radius.circular(customRadius),
              ),
              color: borderColor,
            ),
            child: Icon(Icons.calendar_month_rounded),
          ),
        )
      ],
    );
  }
}
