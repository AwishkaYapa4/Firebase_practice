import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/app2.dart';
import 'package:todo_app/firebase_db.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/student.dart';
import 'package:todo_app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );
    var instance = FirebaseFirestore.instance;
    print('Firestore instance: ${instance}');

    return MaterialApp(home: RealtimeHomepage());
  }
}
