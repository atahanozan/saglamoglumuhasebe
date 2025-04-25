import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/helper/ui/custom_colors.dart';

class FavoriteButtons extends StatelessWidget {
  const FavoriteButtons({super.key, required this.childs, required this.admin});

  final Widget childs;
  final bool admin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColors.customWhite,
      ),
      child:
          admin ? childs : Text("En çok kullanılan sekmeler burada listelenir"),
    );
  }
}
