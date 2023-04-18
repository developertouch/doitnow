import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class buttons extends StatefulWidget {

  final String? title;
  final Color? btnColor;
  final VoidCallback? onPressed;
  final double? width;


  const buttons({ this.title, this.btnColor, this.onPressed, required this.width});

  @override
  State<buttons> createState() => _buttonsState();
}

class _buttonsState extends State<buttons> {

  @override
  Widget build(BuildContext context) {
    return MaterialButton(

      onPressed: widget.onPressed,
      height: 48,
      child:Text(widget.title!,style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        )
      ),),
      minWidth: widget.width,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      color: widget.btnColor,
    );
  }
}
