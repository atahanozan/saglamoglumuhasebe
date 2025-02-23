import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideBarButtons extends StatelessWidget {
  const SideBarButtons({
    super.key,
    required this.btnColor,
    required this.childColor,
    required this.btnName,
    required this.btnIcon,
    required this.btnFunc,
  });

  final Color btnColor;
  final Color childColor;
  final String btnName;
  final IconData btnIcon;
  final VoidCallback btnFunc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: btnFunc,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: btnColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              btnIcon,
              color: childColor,
            ),
            const SizedBox(width: 30),
            Text(
              btnName,
              style: GoogleFonts.raleway(color: childColor),
            ),
          ],
        ),
      ),
    );
  }
}
