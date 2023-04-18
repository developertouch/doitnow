
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


//Email textformfield
class emailtextfield extends StatefulWidget {
  final String? title;
  final Controller;

  const emailtextfield({ this.Controller, this.title});

  @override
  State<emailtextfield> createState() => _emailtextfieldState();
}

class _emailtextfieldState extends State<emailtextfield> {
  TextEditingController _emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (value){
          if(value!.isEmpty){
            return "Email must be filled";
          };
        },
          keyboardType: TextInputType.emailAddress,
          controller:widget.Controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            fillColor: Color(0xffEEEEEE),
            filled: true,
            hintText: widget.title,
            hintStyle: GoogleFonts.poppins(
              textStyle:TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000000).withOpacity(0.5)
              ),

            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none
            ),
          )


      ),);
  }
}



















//password textformfield


class passwordfield extends StatefulWidget {
  final Controller;
  const passwordfield({ this.Controller});

  @override
  State<passwordfield> createState() => _passwordfieldState();
}

class _passwordfieldState extends State<passwordfield> {

  TextEditingController _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
          validator: (value) {
            if(value!.isEmpty){
              return "password must be filled";
            }else if(value.length <6){
              return "password must be greater then 6 digit";
            }
          },
          keyboardType: TextInputType.number,
          controller:widget.Controller,
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            fillColor: Color(0xffEEEEEE),
            filled: true,
            hintText: "Enter Password",
            hintStyle: GoogleFonts.poppins(
              textStyle:TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000000).withOpacity(0.5)
              ),

            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none
            ),
          )


      ),
    );
  }
}