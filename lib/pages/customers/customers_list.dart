import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/customer_list/data_info_band.dart';
import 'package:saglamoglu_muhasebe/pages/customers/add_customer.dart';

class CustomersList extends StatefulWidget {
  const CustomersList({super.key});

  @override
  State<CustomersList> createState() => _CustomersListState();
}

class _CustomersListState extends State<CustomersList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Müşteri Listesi",
                  style: GoogleFonts.raleway(fontSize: 25),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddCustomer(),
                      ),
                    );
                  },
                  child: const Text("Müşteri Ekle"),
                ),
              ],
            ),
            const Divider(),
            Flexible(
              child: StreamBuilder(
                stream: _firestore.collection("customers").snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? const CircularProgressIndicator()
                      : ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot docs = snapshot.data!.docs[index];

                            return DataInfoBand(
                              customerName: docs['name'],
                              customerType: docs['customertype'],
                              customerId: docs['id'],
                              phone: docs['phone'],
                              addDoc: () {},
                              sendMessage: () {},
                              donwload: () {},
                            );
                          },
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
