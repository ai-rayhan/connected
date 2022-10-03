import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key,
      required this.title,
      required this.onpress,
      required this.colour})
      : super(key: key);
  final String title;
  final Color colour;
  final Function onpress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          onPressed: () {
            onpress();
          },
          minWidth: 300.0,
          height: 42.0,
          child: Text(title),
        ),
      ),
    );
  }
}
