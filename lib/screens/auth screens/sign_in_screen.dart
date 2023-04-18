import 'package:doitnow/screens/auth%20screens/register_screen.dart';
import 'package:doitnow/screens/auth%20screens/reset_screen.dart';
import 'package:doitnow/screens/data%20screens/home_screen.dart';
import 'package:doitnow/styles/color_widgets.dart';
import 'package:doitnow/styles/textstyles_widget.dart';
import 'package:doitnow/widgets/buttons.dart';
import 'package:doitnow/widgets/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/screen_design.dart';
import 'Sign_in_with_phone_number.dart';
class sign_in extends StatefulWidget {
  const sign_in({Key? key}) : super(key: key);

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                // ScreenDesign(),
                SizedBox(height: 30,),
                Text("Welcome Back !",style: GoogleFonts.poppins(
                  textStyle: AppTextStyles.HEADING_TEXT
                ),),
                SizedBox(height: 25,),
                Container(
                  height: 151,
                  width: 229,
                  decoration:BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/login.jpg"),
                    )
                  ),
                ),
                SizedBox(height: 28,),
                emailtextfield(
                  title: "Enter Your Email",
                  Controller: _emailController,
                ),
                   SizedBox(height: 10,),
                  passwordfield(
                   Controller: _passwordController,
                  ),
                   SizedBox(height: 30,),
                   InkWell(
                     onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (_)=>reset_password()));
                     },
                     child: Text("Forget Password?",style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColor.APP_COLOR,
                      ),
                ),),
                   ),
                SizedBox(height: 10,),
                buttons(
                  onPressed: ()async{
                    if(_key.currentState!.validate()){
                      try{
                        setState(() {
                          isLoading=true;
                        });
                        await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                        if(_auth.currentUser!.emailVerified){
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>home_Screen()));
                        }
                        else{
                          Fluttertoast.showToast(msg: "Your Email is not verified yet");
                          _auth.currentUser!.sendEmailVerification();
                        };
                        setState(() {
                          isLoading=false;
                        });

                      }catch(e){
                        setState(() {
                          isLoading=false;
                        });

                      }
                    }else{
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("incorrect password try again")));
                    }



                    // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>home_Screen()));
                  },

                    width: 280,
                  title: "Sign in",
                  btnColor: AppColor.APP_COLOR,
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000).withOpacity(0.5),
                        )
                    ),),
                    SizedBox(width: 5,),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>register()));
                      },
                      child: Text("sign up",style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColor.APP_COLOR,
                          )
                      ),),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                buttons(
                    width: 280,
                  onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>signInWithPhoneNumber()));
                  },
                  title: "Sign in with Phone number",
                  btnColor: AppColor.APP_COLOR,
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
