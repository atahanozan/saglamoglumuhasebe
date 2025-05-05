import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DocsTestPage extends StatefulWidget {
  const DocsTestPage({super.key});

  @override
  State<DocsTestPage> createState() => _DocsTestPageState();
}

class _DocsTestPageState extends State<DocsTestPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: firestore.collection("deliverydocs").snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    int dataLengt = snapshot.data!.docs[index].data().length;
                    return ListTile(
                      title: Text("$dataLengt"),
                      onTap: () {
                        firestore
                            .collection("deliverydocs")
                            .doc(data.id)
                            .update({"proccesstatu": false});
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
