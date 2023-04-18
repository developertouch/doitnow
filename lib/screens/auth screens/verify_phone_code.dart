import 'package:doitnow/screens/data%20screens/home_screen.dart';
import 'package:doitnow/styles/color_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../styles/textstyles_widget.dart';
import '../../widgets/buttons.dart';
import '../../widgets/screen_design.dart';
import '../../widgets/textfields.dart';
class verifyPhoneCode extends StatefulWidget {
 final  String verificationId;
  const verifyPhoneCode({Key? key,required this.verificationId}) : super(key: key);

  @override
  State<verifyPhoneCode> createState() => _verifyPhoneCodeState();
}

class _verifyPhoneCodeState extends State<verifyPhoneCode> {


  bool loading=  false;
  TextEditingController _verificationCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );


    return Scaffold(
      backgroundColor: AppColor.BG_COLOR,
      appBar: AppBar(
        backgroundColor: AppColor.APP_COLOR,

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ScreenDesign(),
              SizedBox(height: 20,),
              Container(
                height: 200,
                width: 329,
                decoration:BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/otp.webp"),
                    )
                ),
              ),
              SizedBox(height: 50,),
              Text("Enter the verification code",style: GoogleFonts.poppins(
                  textStyle: AppTextStyles.HEADING_TEXT
              ),),
              SizedBox(height: 10,),
              Text("we sent verification code",style: GoogleFonts.poppins(
                  textStyle: AppTextStyles.DESCRIPTION_TEXT
              ),),
              SizedBox(height: 40,),
              Pinput(
            androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
            controller: _verificationCodeController,
            length: 6,
            defaultPinTheme: PinTheme(
              height: 55,
              width: 45,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.APP_COLOR,width: 2),
                borderRadius: BorderRadius.circular(12),
                color: Color(0xffEEEEEE),
              )
            ),




            showCursor: true,
            onCompleted: (pin) => print(pin),
          ),
              SizedBox(height: 20,),
              buttons(
                width: 150,

                onPressed: () async{
                  setState(() {
                    loading=true;
                  });
                  final crendital =PhoneAuthProvider.credential(

                      verificationId: widget.verificationId,
                      smsCode: _verificationCodeController.text.toString()

                  );
                  try{
                    await auth.signInWithCredential(crendital);
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>home_Screen()));


                  }catch(e){
                    setState(() {
                      loading=false;
                    });
                    Fluttertoast.showToast(msg: (e.toString()));
                  }
                },
                title: "Verify",
                btnColor: AppColor.APP_COLOR,
              )
            ],
          ),
        ),
      ),
    );
  }
}
