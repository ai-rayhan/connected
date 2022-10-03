import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chatscreen.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);
  static String id = "Loading";
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  final _auth = FirebaseAuth.instance;
  late User loggedinuser;
  @override
  void initState() {
    super.initState();
    getcurrentuser();
  
  }

  void getcurrentuser() async {
     Navigator.pushNamed(context, Chat_screen.id);
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinuser = user;
      }
    } catch (e) {
      print(e);
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(Icons.local_fire_department),
      ),
    );
  }
}
