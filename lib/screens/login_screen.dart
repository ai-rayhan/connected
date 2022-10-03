import 'package:flash_chat/components/roundedbutton.dart';
import 'package:flash_chat/copy.dart';
import 'package:flash_chat/screens/chatscreen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = "Loginscreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: Container(
                    height: 150,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 28,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    inputDecoration.copyWith(hintText: "Enter your Email"),
              ),
              SizedBox(
                height: 14,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration:
                    inputDecoration.copyWith(hintText: "Enter your Password"),
              ),
              SizedBox(
                height: 14.0,
              ),
              RoundedButton(
                  title: "Login",
                  onpress: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final signinUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (signinUser != null) {
                        Navigator.pushNamed(context, Chat_screen.id);
                      }
                    } catch (e) {
                      // print(e);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  },
                  colour: Colors.lightBlueAccent),
            ],
          ),
        ),
      ),
    );
  }
}
