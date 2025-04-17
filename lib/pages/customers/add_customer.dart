import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/helper/ui/custom_colors.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/customer_choice.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/customer_list/add_new_customer.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  List<Widget> pages = [
    const AddNewCustomer(),
    const AddNewCustomer(),
    const AddNewCustomer(),
    const AddNewCustomer(),
  ];

  int pageNumber = 3;

  Color btn1Color = CustomColors.customYellow;
  Color btn2Color = CustomColors.customGrey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(30),
              child: Text(
                "Müşteri Ekle",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalDivider(),
                  Expanded(
                    child: CustomerChoice(
                      bnt1Fun: () {
                        setState(() {
                          pageNumber = 0;
                        });
                      },
                      bnt2Fun: () {
                        setState(() {
                          pageNumber = 1;
                        });
                      },
                      btn1Color: pageNumber == 0 ? btn1Color : btn2Color,
                      btn2Color: pageNumber == 1 ? btn1Color : btn2Color,
                      bnt3Fun: () {
                        setState(() {
                          pageNumber = 2;
                        });
                      },
                      bnt4Fun: () {
                        setState(() {
                          pageNumber = 3;
                        });
                      },
                      btn3Color: pageNumber == 2 ? btn1Color : btn2Color,
                      btn4Color: pageNumber == 3 ? btn1Color : btn2Color,
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(child: pages[pageNumber]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
