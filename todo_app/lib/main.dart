import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/firebase_db.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/student.dart';

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

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Firestore Example')),
        body: FutureBuilder(
          future: FirebaseDb.getStudent(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                Student student = snapshot.data[index].data();

                return ListTile(
                  title: Text(student.name),
                  subtitle: Text(student.city),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
