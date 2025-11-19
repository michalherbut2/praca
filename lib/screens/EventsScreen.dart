import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:most_app/screens/CreateEventScreen.dart';
import 'package:most_app/helper/AuthService.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
          final authService = context.read<AuthService>();
          final uid = FirebaseAuth.instance.currentUser?.uid;


          return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final events = snapshot.data!.docs;

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              final data = event.data() as Map<String, dynamic>;
              final participants = List<String>.from(data['participants'] ?? []);
              final isJoined = participants.contains(uid);

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(data['title'] ?? 'Bez tytułu'),
                  subtitle: Text("Uczestnicy: ${participants.length}"),
                  trailing: ElevatedButton(
                    onPressed: () {
                      if (uid == null) return;

                      if (isJoined) {
                        // 👇 WYPISANIE
                        FirebaseFirestore.instance
                            .collection('events')
                            .doc(event.id)
                            .update({
                          'participants': FieldValue.arrayRemove([uid]),
                        });
                      } else {
                        // 👇 ZAPISANIE
                        FirebaseFirestore.instance
                            .collection('events')
                            .doc(event.id)
                            .update({
                          'participants': FieldValue.arrayUnion([uid]),
                        });
                      }
                    },
                    child: Text(isJoined ? 'Wypisz się' : 'Zapisz się'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
