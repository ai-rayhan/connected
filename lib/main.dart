import 'package:flash_chat/screens/chatscreen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'screens/registation_screen.dart';
import 'screens/login_screen.dart';

import 'copy.dart';

import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.black54,
        ),
      )),
      home: WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        registrationScreeen.id: (context) => registrationScreeen(),
        Chat_screen.id: (context) => Chat_screen(),
        // ChatScreen.id:(context)=>ChatScreen(),
      },
    );
  }
}
