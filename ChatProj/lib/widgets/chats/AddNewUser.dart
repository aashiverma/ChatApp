import 'dart:io';
import 'package:flutter/material.dart';
import '../pickers/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AddNewUser extends StatefulWidget {
  @override
  _AddNewUserState createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  final _formKey = GlobalKey<FormState>();
  var _userName = '';
  File _userImageFile;
  String imagepath;

  void _pickedImage(File image) {
    _userImageFile = image;
    imagepath = basename(_userImageFile.path);
  }

  finallyupload() {
    final ref = FirebaseStorage.instance.ref().child(imagepath);
    final url = ref.getDownloadURL();

    var data = {
      "userImage": url,
      "username": _userName,
    };

    FirebaseFirestore.instance.collection("chats").doc().set(data);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UserImagePicker(_pickedImage),
                TextFormField(
                  key: ValueKey('username'),
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  enableSuggestions: false,
                  validator: (value) {
                    if (value != null) {
                      return 'please enter an authenticated username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'UserName',
                  ),
                  onSaved: (value) {
                    _userName = value;
                  },
                ),
                RaisedButton(
                  onPressed: () => finallyupload(),
                  child: Text("Add User"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
