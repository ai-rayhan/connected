import 'package:flash_chat/components/roundedbutton.dart';
import 'package:flash_chat/constants/constants.dart';
import 'package:flash_chat/screens/chatscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class registrationScreeen extends StatefulWidget {
  static const String id = "Registrationscreen";

  @override
  State<registrationScreeen> createState() => _registrationScreeenState();
}

class _registrationScreeenState extends State<registrationScreeen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ModalProgressHUD(
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
                      inputDecoration.copyWith(hintText: "Enter your Email")),
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
              // TextField(
              //   onChanged: (value) {},
              //   decoration:inputDecoration.copyWith(hintText: "Enter your Re-type password"),
              // ),
              SizedBox(
                height: 14.0,
              ),
              RoundedButton(
                  title: "Register",
                  onpress: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, Chat_screen.id);
                       
                      }
                    } catch (e) {
                      print(e);
                    }
                     setState(() {
                          showSpinner = false;
                        });
                  },
                  colour: Colors.blueAccent),
            ],
          ),
        ),
      ),
    );
  }
}
