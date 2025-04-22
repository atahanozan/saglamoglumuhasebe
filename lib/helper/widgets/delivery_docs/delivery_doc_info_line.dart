import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/pdf/customer_delivery_doc.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/pdf/print_deliver_docs.dart';

class DeliveryDocInfoLine extends StatelessWidget {
  const DeliveryDocInfoLine({
    super.key,
    required this.date,
    required this.name,
    required this.company,
    required this.price,
    required this.tcknvkn,
    required this.deleteDoc,
    required this.statu,
    required this.statuChange,
    required this.statuIcon,
  });

  final String date;
  final String name;
  final String company;
  final String price;
  final String tcknvkn;
  final VoidCallback deleteDoc;
  final VoidCallback statuChange;
  final bool statu;
  final Icon statuIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        color: statu ? Colors.green.shade100 : Colors.red.shade100,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: Text(date)),
          const SizedBox(width: 20),
          Expanded(child: Text(name)),
          const SizedBox(width: 20),
          Expanded(child: Text(company)),
          const SizedBox(width: 20),
          Expanded(child: Text(price)),
          const SizedBox(width: 20),
          Expanded(
            child: FittedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      CustomerDeliveryDoc().downloadCustomerDeliveryDoc(
                        name,
                        tcknvkn,
                        company,
                        price,
                        context,
                        DateTime.parse(date),
                      );
                    },
                    child: const Icon(Icons.save),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      PrintDeliverDocs().printDeliveryDocs(
                        name,
                        tcknvkn,
                        company,
                        price,
                        context,
                        DateTime.parse(date),
                      );
                    },
                    child: const Icon(Icons.print),
                  ),
                  IconButton(onPressed: deleteDoc, icon: Icon(Icons.delete)),
                  IconButton(onPressed: statuChange, icon: statuIcon),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
