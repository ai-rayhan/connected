import 'package:flash_chat/components/roundedbutton.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registation_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = "Welcomescreen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.withOpacity(controller.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset('assets/logo.png'),
                    height: 80,
                  ),
                ),
                
                 AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle: const TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                      speed: const Duration(milliseconds: 500),
                     
                    ),
                  ],
                  pause: Duration(seconds: 1),
                ),
              ],
            ),
            SizedBox(
              height: 48,
            ),
            RoundedButton(
                title: "Login",
                onpress: () => Navigator.pushNamed(context, LoginScreen.id),
                colour: Colors.lightBlueAccent),
            RoundedButton(
                title: "Register",
                onpress: () =>
                    Navigator.pushNamed(context, registrationScreeen.id),
                colour: Colors.blueAccent),
          ],
        ),
      ),
    );
  }
}
