import 'package:country_picker/country_picker.dart';
import 'package:doitnow/screens/auth%20screens/verify_phone_code.dart';
import 'package:doitnow/styles/color_widgets.dart';
import 'package:doitnow/styles/textstyles_widget.dart';
import 'package:doitnow/widgets/buttons.dart';
import 'package:doitnow/widgets/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/screen_design.dart';
class signInWithPhoneNumber extends StatefulWidget {
  const signInWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<signInWithPhoneNumber> createState() => _signInWithPhoneNumberState();
}

class _signInWithPhoneNumberState extends State<signInWithPhoneNumber> {

  bool loading=  false;
  TextEditingController _phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;


  Country selectedCountry= Country(
      phoneCode: "92",
      countryCode: "PK",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Pakistan",
      example: "Pakistan",
      displayName: "Pakistan",
      displayNameNoCountryCode: "PK",
      e164Key: "",
  );


  @override
  Widget build(BuildContext context) {
    _phoneNumberController.selection=TextSelection.fromPosition(
      TextPosition(offset: _phoneNumberController.text.length),
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

              Container(
                height: 200,
                width: 229,
                decoration:BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/signup.jpg"),
                    )
                ),
              ),
              SizedBox(height: 50,),
              Text("Phone verification",style: GoogleFonts.poppins(
                textStyle: AppTextStyles.HEADING_TEXT
              ),),
              SizedBox(height: 10,),
              Text("            We need to register your \n phone number getting started !",style: GoogleFonts.poppins(
                textStyle: AppTextStyles.DESCRIPTION_TEXT
              ),),
              SizedBox(height: 40,),

              Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return "please enter your phone number";
                  };
                },
                onChanged: (value){
                  setState(() {
                    _phoneNumberController.text = value;
                  });
                },
                keyboardType: TextInputType.phone,
                controller:_phoneNumberController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  // labelText: "Phone Number",
                  labelStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                        color: Color(0xff000000).withOpacity(0.5)
                    )
                  ),
                  fillColor: Color(0xffEEEEEE),
                  filled: true,
                  hintText: "0000000000",
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
                  prefixIcon: Container(
                    padding: EdgeInsets.all(15),
                    child: InkWell(
                      onTap: (){
                        showCountryPicker(context: context,
                            countryListTheme: CountryListThemeData(
                              bottomSheetHeight: 600,
                            ),
                            onSelect: (value){
                          setState(() {
                            selectedCountry=value;
                          });
                        });

                      },
                      child:Text("${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}") ,
                    ),
                  ),
                  suffixIcon: _phoneNumberController.text.length > 9 ?  Container(
                    margin: EdgeInsets.all(10),
                    height: 05,
                    width: 10,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:AppColor.APP_COLOR
                    ),
                    child: Icon(Icons.done,color: Colors.white,size: 18,),
                  ) : null,
                )
            ),
          ),
              SizedBox(height: 20,),
              buttons(
                  width: 150,

                onPressed: (){
                    setState(() {
                      loading=true;
                    });
                    auth.verifyPhoneNumber(
                      phoneNumber:_phoneNumberController.text,
                        verificationCompleted: (_){
                        setState(() {
                          loading=false;
                        });
                        },
                        verificationFailed: (e){
                          setState(() {
                            loading=false;
                          });
                        Fluttertoast.showToast(msg: (e.toString()));
                        },
                        codeSent: (String verificationId , int? token){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>verifyPhoneCode(verificationId: verificationId,)));
                  setState(() {
                    loading=false;
                  });

                  },
                        codeAutoRetrievalTimeout: (e){
                        Fluttertoast.showToast(msg: (e.toString()));
                        setState(() {
                          loading=false;
                        });

                   });

                },
                title:   "SignIn",
                btnColor: AppColor.APP_COLOR,
              )
            ],
          ),
        ),
      ),
    );

  }
}
