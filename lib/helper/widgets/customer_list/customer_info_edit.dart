import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomerInfoEdit extends StatefulWidget {
  const CustomerInfoEdit({
    super.key,
    required this.collection,
    required this.docId,
    required this.fbKey,
    required this.valueString,
    required this.changeName,
  });

  final String collection;
  final String? docId;
  final String fbKey;
  final bool valueString;
  final String changeName;

  @override
  State<CustomerInfoEdit> createState() => _CustomerInfoEditState();
}

class _CustomerInfoEditState extends State<CustomerInfoEdit> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
              labelText: widget.changeName,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              )),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Kapat"),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                if (widget.valueString) {
                  _firestore
                      .collection(widget.collection)
                      .doc(widget.docId)
                      .update({
                    widget.fbKey: _controller.text,
                  });
                } else {
                  _firestore
                      .collection(widget.collection)
                      .doc(widget.docId)
                      .update({
                    widget.fbKey: int.parse(_controller.text),
                  });
                }
              },
              child: const Text("Düzenle"),
            ),
          ],
        ),
      ],
    );
  }
}
