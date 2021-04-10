import 'chatScreen.dart';
import 'package:flutter/material.dart';

class ChatBox extends StatelessWidget {
  ChatBox(
    this.userName,
    this.userImage,
    this.documentId,
  );

  final String userName;
  final String userImage;
  final String documentId;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ChatScreen(documentId))),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(userImage),
        radius: 26.0,
      ),
      title: Text(
        userName,
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
      ),
    );
  }
}
