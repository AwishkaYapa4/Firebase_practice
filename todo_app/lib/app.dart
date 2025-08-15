import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/firebase_db.dart';
import 'package:todo_app/models/student.dart';

class onetimeHomepage extends StatefulWidget {
  const onetimeHomepage({super.key});

  @override
  State<onetimeHomepage> createState() => _onetimeHomepageState();
}

class _onetimeHomepageState extends State<onetimeHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
