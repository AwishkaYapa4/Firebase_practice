import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/firebase_db.dart';
import 'package:todo_app/models/student.dart';

class RealtimeHomepage extends StatefulWidget {
  const RealtimeHomepage({super.key});

  @override
  State<RealtimeHomepage> createState() => _RealtimeHomepageState();
}

class _RealtimeHomepageState extends State<RealtimeHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firestore Example')),
      body: StreamBuilder(
        stream: FirebaseDb.getStudentStream(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Student student = snapshot.data!.docs[index].data();

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
