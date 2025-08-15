import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDb {
  static FirebaseFirestore instance = FirebaseFirestore.instance;

  static Future<List<QueryDocumentSnapshot>> getStudent() async {
    var student = await instance.collection('student').get();
    return student.docs;
  }
}
