import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeliveryDocsStatu extends StatefulWidget {
  const DeliveryDocsStatu({super.key});

  @override
  State<DeliveryDocsStatu> createState() => _DeliveryDocsStatuState();
}

class _DeliveryDocsStatuState extends State<DeliveryDocsStatu> {
  final FirebaseFirestore firebase = FirebaseFirestore.instance;
  int statuFalseLenght = 0;
  int statuTrueLenght = 0;
  String btnName = "";

  Future<void> getDocStatu() async {
    await FirebaseFirestore.instance
        .collection("deliverydocs")
        .where("statu", isEqualTo: false)
        .count()
        .get()
        .then((value) {
      setState(() {
        statuFalseLenght = value.count!;
      });
    });
    await FirebaseFirestore.instance
        .collection("deliverydocs")
        .where("statu", isEqualTo: true)
        .count()
        .get()
        .then((value) {
      setState(() {
        statuTrueLenght = value.count!;
      });
    });
  }

  Future<void> pickDate(BuildContext myContext) async {
    final DateTime? pickedDate = await showDatePicker(
      context: myContext,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      await FirebaseFirestore.instance
          .collection("deliverydocs")
          .where("date", isEqualTo: pickedDate.toString().split(" ")[0])
          .where("statu", isEqualTo: false)
          .count()
          .get()
          .then((value) {
        setState(() {
          statuFalseLenght = value.count!;
        });
      });
      await FirebaseFirestore.instance
          .collection("deliverydocs")
          .where("date", isEqualTo: pickedDate.toString().split(" ")[0])
          .where("statu", isEqualTo: true)
          .count()
          .get()
          .then((value) {
        setState(() {
          statuTrueLenght = value.count!;
        });
      });
      setState(() {
        btnName = pickedDate.toString().split(" ")[0];
      });
    }
  }

  @override
  void initState() {
    getDocStatu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                "Teslim Dosya Durumu",
              ),
            ),
            FittedBox(
              child: ElevatedButton(
                onPressed: () {
                  pickDate(context);
                },
                child:
                    btnName == "" ? Icon(Icons.calendar_month) : Text(btnName),
              ),
            ),
          ],
        ),
        Divider(),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Geldi"),
                  Text(
                    "$statuTrueLenght",
                    style: pageStyle.headlineSmall
                        ?.copyWith(color: Colors.green.shade800),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Bekleniyor"),
                  Text(
                    "$statuFalseLenght",
                    style: pageStyle.headlineSmall
                        ?.copyWith(color: Colors.red.shade800),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(),
        Text("${statuFalseLenght + statuTrueLenght}",
            style: pageStyle.headlineMedium),
      ],
    );
  }
}
