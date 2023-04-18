import 'package:flutter/material.dart';
class ScreenDesign extends StatelessWidget {
  const ScreenDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: 135,
        width: 230,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/Shape circle.png"),fit: BoxFit.cover
            )
        ),
      ),
    );
  }
}
