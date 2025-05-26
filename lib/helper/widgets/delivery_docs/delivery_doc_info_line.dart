import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    required this.editDoc,
    required this.statu,
    required this.statuChange,
    required this.statuIcon,
    required this.proccesStatuChange,
    required this.proccesStatu,
    required this.agent,
    required this.currency,
    this.admin = false,
  });

  final String date;
  final String name;
  final String company;
  final String price;
  final String tcknvkn;
  final String agent;
  final String currency;
  final VoidCallback deleteDoc;
  final VoidCallback editDoc;
  final VoidCallback statuChange;
  final bool statu;
  final bool proccesStatu;
  final Icon statuIcon;
  final bool admin;
  final VoidCallback proccesStatuChange;

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;
    const double iconSize = 22;
    const Color darkRed = Color(0xff871903);
    const Color lightRed = Color(0xffefd9d5);
    const Color darkYellow = Color(0xffda8504);
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                ),
                left: BorderSide(
                  width: iconSize + 6,
                  color: proccesStatu ? Colors.black12 : darkRed,
                )),
            color: proccesStatu ? Colors.transparent : lightRed,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(date),
              const SizedBox(width: 30),
              Expanded(
                  child: Text(
                name,
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
              const SizedBox(width: 20),
              Text(
                company,
                textAlign: TextAlign.left,
                style: pageStyle.titleMedium?.copyWith(
                  color:
                      company == "Sağlam" ? darkYellow : Colors.indigo.shade900,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  agent,
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: Text(
                "$price $currency",
                textAlign: TextAlign.right,
                style: GoogleFonts.lexendGiga(),
              )),
              const SizedBox(width: 30),
              SizedBox(
                width: 200,
                child: FittedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
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
                        icon: const Icon(Icons.save),
                      ),
                      IconButton(
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
                        icon: const Icon(Icons.print),
                      ),
                      // IconButton(
                      //   onPressed: editDoc,
                      //   icon: Icon(Icons.edit_rounded),
                      // ),

                      Visibility(
                        visible: admin,
                        child: IconButton(
                          onPressed: deleteDoc,
                          icon: Icon(Icons.delete_rounded),
                        ),
                      ),
                      Visibility(
                        visible: admin,
                        child: IconButton(
                          onPressed: statuChange,
                          icon: statu
                              ? Icon(Icons.content_paste_off_rounded)
                              : Icon(Icons.note_add_rounded),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: !statu,
          child: InkWell(
            onTap: proccesStatuChange,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Icon(
                proccesStatu
                    ? Icons.check_circle_rounded
                    : Icons.circle_outlined,
                color: proccesStatu ? Colors.green.shade800 : lightRed,
                size: iconSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
