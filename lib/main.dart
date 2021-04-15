import './screens/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './widgets/chats/FinalChatScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData.dark(),
      home: 
      StreamBuilder(
         stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {

           // if (userSnapshot.connectionState == ConnectionState.waiting) {
             // return SplashScreen();
            //}
           if (userSnapshot.hasData) {
             return FinalChatScreen();
           }
            return AuthScreen();
          }),
    );
  }
}
