import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saglamoglu_muhasebe/core/model/authorized_model.dart';

class AuthorizedController {
  final String _basePath = "authorizedcustomers";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createAuthorizedDocument(AuthorizedModel dataModel) async {
    await _firestore.collection(_basePath).add({
      'firstdate': dataModel.firstdate,
      'seconddate': dataModel.seconddate,
      'customertckn': dataModel.customertckn,
      'customername': dataModel.customername,
      'authorizedtckn': dataModel.authorizedtckn,
      'authorizedname': dataModel.authorizedname,
      'doctype': dataModel.doctype,
    });
  }

  Future<void> deleteDocument(String? docId) async {
    await _firestore.collection(_basePath).doc(docId).delete();
  }

  Future<void> updateDocument(
      String? docId, Map<String, dynamic> newData) async {
    await _firestore.collection(_basePath).doc(docId).update(newData);
  }

  Future<List<AuthorizedModel>> getAllData() async {
    var res = await _firestore.collection(_basePath).get();

    var result = List.generate(
        res.docs.length,
        (index) => AuthorizedModel(
              firstdate: res.docs.elementAt(index).data()["firstdate"],
              seconddate: res.docs.elementAt(index).data()["seconddate"],
              customertckn: res.docs.elementAt(index).data()["customertckn"],
              customername: res.docs.elementAt(index).data()["customername"],
              authorizedtckn:
                  res.docs.elementAt(index).data()["authorizedtckn"],
              authorizedname:
                  res.docs.elementAt(index).data()["authorizedname"],
              doctype: res.docs.elementAt(index).data()["doctype"],
            ));

    return result;
  }

  AuthorizedModel getSingleAuthorizedData(Map<String, dynamic> snapshotData) {
    var result = AuthorizedModel(
      firstdate: snapshotData["firstdate"] ?? "",
      seconddate: snapshotData["seconddate"] ?? "",
      customertckn: snapshotData["customertckn"] ?? "",
      customername: snapshotData["customername"] ?? "",
      authorizedtckn: snapshotData["authorizedtckn"] ?? "",
      authorizedname: snapshotData["authorizedname"] ?? "",
      doctype: snapshotData["doctype"] ?? "",
    );

    return result;
  }
}
