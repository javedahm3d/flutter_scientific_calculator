import 'package:calculator/gloabl.dart';
import 'package:calculator/homepage.dart';
import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final String buttonText;
  final double textsize;
  final buttonsTapped;
  const MyButtons(
      {super.key,
      required this.buttonText,
      this.textsize = 26,
      this.buttonsTapped});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttonsTapped,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          child: Center(
              child: Text(
            buttonText,
            style: TextStyle(
                color: Colors.white,
                fontSize: textsize,
                fontWeight: FontWeight.w400),
          )),
        ),
      ),
    );
  }
}
