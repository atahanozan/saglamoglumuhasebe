import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/helper/ui/custom_colors.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/customer_choice.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/customer_list/add_person.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  List<Widget> pages = [
    const AddPerson(),
  ];

  Color btn1Color = CustomColors.customYellow;
  Color btn2Color = CustomColors.customGrey;
  Color btn3Color = CustomColors.customGrey;
  Color btn4Color = CustomColors.customGrey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Müşteri Ekle"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalDivider(),
                  Expanded(
                    child: CustomerChoice(
                      bnt1Fun: () {
                        setState(() {
                          btn1Color = CustomColors.customYellow;
                          btn2Color = CustomColors.customGrey;
                          btn3Color = CustomColors.customGrey;
                          btn4Color = CustomColors.customGrey;
                        });
                      },
                      bnt2Fun: () {
                        setState(() {
                          btn1Color = CustomColors.customGrey;
                          btn2Color = CustomColors.customYellow;
                          btn3Color = CustomColors.customGrey;
                          btn4Color = CustomColors.customGrey;
                        });
                      },
                      btn1Color: btn1Color,
                      btn2Color: btn2Color,
                      bnt3Fun: () {
                        setState(() {
                          btn1Color = CustomColors.customGrey;
                          btn2Color = CustomColors.customGrey;
                          btn3Color = CustomColors.customYellow;
                          btn4Color = CustomColors.customGrey;
                        });
                      },
                      bnt4Fun: () {
                        setState(() {
                          btn1Color = CustomColors.customGrey;
                          btn2Color = CustomColors.customGrey;
                          btn3Color = CustomColors.customGrey;
                          btn4Color = CustomColors.customYellow;
                        });
                      },
                      btn3Color: btn3Color,
                      btn4Color: btn4Color,
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(child: pages[0]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
