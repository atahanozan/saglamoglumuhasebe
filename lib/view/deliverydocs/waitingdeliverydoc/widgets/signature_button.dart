import 'package:flutter/material.dart';

class SignatureButton extends StatelessWidget {
  const SignatureButton({
    super.key,
    required this.waitinFunction,
    required this.doneFunction,
    required this.sendFunction,
    required this.buttonName,
    required this.menuController,
  });

  final VoidCallback waitinFunction;
  final VoidCallback doneFunction;
  final VoidCallback sendFunction;
  final String buttonName;
  final MenuController menuController;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      consumeOutsideTap: true,
      builder: (context, controller, child) {
        return InkWell(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: Container(
            height: 30,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue.shade800,
                ),
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue.shade50),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.blue.shade800,
                  size: 18,
                ),
                SizedBox(width: 8),
                Text(buttonName),
              ],
            ),
          ),
        );
      },
      menuChildren: [
        TextButton(
          onPressed: waitinFunction,
          child: Text("İmza Bekliyor"),
        ),
        TextButton(
          onPressed: doneFunction,
          child: Text("İmzalandı"),
        ),
        TextButton(
          onPressed: sendFunction,
          child: Text("Merkeze Gönderildi"),
        ),
      ],
    );
  }
}
