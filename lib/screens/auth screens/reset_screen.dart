import 'package:doitnow/screens/auth%20screens/sign_in_screen.dart';
import 'package:doitnow/styles/color_widgets.dart';
import 'package:doitnow/styles/textstyles_widget.dart';
import 'package:doitnow/widgets/buttons.dart';
import 'package:doitnow/widgets/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/screen_design.dart';
class reset_password extends StatefulWidget {
  const reset_password({Key? key}) : super(key: key);

  @override
  State<reset_password> createState() => _reset_passwordState();
}

class _reset_passwordState extends State<reset_password> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GlobalKey<FormState> _key=GlobalKey();
  bool isLoading =false;

  var _auth=FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BG_COLOR,
      appBar: AppBar(
        backgroundColor: AppColor.APP_COLOR,
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                // ScreenDesign(),
                SizedBox(height: 100,),
                Container(
                  height: 151,
                  width: 229,
                  decoration:BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/images.jpeg"),
                      )
                  ),
                ),
                SizedBox(height: 40,),
                Text("Oops! Forget Your PassWord",style: GoogleFonts.poppins(textStyle: AppTextStyles.HEADING_TEXT),),
                SizedBox(height: 10,),
                Text("Don't worry just enter your email ",style: GoogleFonts.poppins(
                  textStyle: AppTextStyles.DESCRIPTION_TEXT
                ),),
                SizedBox(height: 20,),
                emailtextfield(
                  title: "Enter Your Email",
                  Controller: _emailController,
                ),
                SizedBox(height: 20,),
                buttons(
                  onPressed: ()async{
                    if(_key.currentState!.validate()){
                      try{
                        setState(() {
                          isLoading=true;
                        });
                        await _auth.sendPasswordResetEmail(email: _emailController.text);
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>sign_in()));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email has been sent to you")));
                        setState(() {
                          isLoading=false;
                        });

                      }catch(e){
                        setState(() {
                          isLoading=false;
                        });

                      }
                    }else{
                      print("error");
                    }


                  },
                    width: 150,
                  title: "Reset password",
                  btnColor: AppColor.APP_COLOR,

                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
