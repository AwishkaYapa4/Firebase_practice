import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/student.dart';

class FirebaseDb {
  static FirebaseFirestore instance = FirebaseFirestore.instance;

  static Future<List<QueryDocumentSnapshot>> getStudent() async {
    var student =
        await instance
            .collection('student')
            .withConverter(
              fromFirestore:
                  (snapshot, _) => Student.fromJson(snapshot.data()!),
              toFirestore: (student, _) => student.toJson(),
            )
            .get();
    return student.docs;
  }

  static getStudentStream() {
    return instance
        .collection('student')
        .withConverter(
          fromFirestore: (snapshot, _) => Student.fromJson(snapshot.data()!),
          toFirestore: (student, _) => student.toJson(),
        )
        .snapshots();
  }
}
