import 'package:ChatProj/screens/chatBox.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chats')
                // .orderBy(
                //   'createdAt',
                //   descending: true,
                // )
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = chatSnapshot.data.documents;
              return ListView.builder(
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) => ChatBox(
                  chatDocs[index].get('username'),
                  chatDocs[index].get('userImage'),
                  chatDocs[index].id,
                ),
              );
            });
      },
    );
  }
}
