import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doitnow/screens/auth%20screens/sign_in_screen.dart';
import 'package:doitnow/styles/textstyles_widget.dart';
import 'package:doitnow/widgets/buttons.dart';
import 'package:doitnow/widgets/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../styles/color_widgets.dart';
import '../../widgets/screen_design.dart';
class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();


  // function for to pick image for gallery
  File? _selectedImage;
  ImagePicker _picker=ImagePicker();
  getImage() async{
    XFile? newImage=await _picker!.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage=File(newImage!.path);
    });
  }



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
                SizedBox(height: 50,),
                Text("Welcome Onboard !",style: GoogleFonts.poppins(
                  textStyle: AppTextStyles.HEADING_TEXT
                ),),
                SizedBox(height: 10,),
                Text("Let me help you to do your task.",style: GoogleFonts.poppins(
                  textStyle: AppTextStyles.DESCRIPTION_TEXT
                ),),
                SizedBox(height: 10,),

                //circleAvatar to pick image for gallery

                _selectedImage==null ?CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColor.APP_COLOR,
                  child: InkWell(
                    onTap: (){
                      getImage();
                    },
                      child: Icon(Icons.image)),
                ):InkWell(
                  onTap:() async {
                      getImage();
                    },
                  child: CircleAvatar(
                    backgroundImage: FileImage(File(_selectedImage!.path)),
                     radius: 50,
                   ),

                //  end here

                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      controller: _nameController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Name must be filled";
                          };
                        },
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    fillColor: Color(0xffEEEEEE),
                    filled: true,
                    hintText: "Enter your full name",
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


              ),),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: _usernameController,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Username must be filled";
                        };
                      },
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                        fillColor: Color(0xffEEEEEE),
                        filled: true,
                        hintText: "Enter your username",
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


                  ),),
                SizedBox(height: 10,),
                emailtextfield(
                  title: "Enter Your Email",
                  Controller: _emailController,
                ),
                SizedBox(height: 10,),
                passwordfield(
                  Controller: _passwordController,
                ),
                SizedBox(height: 100,),
                buttons(
                  onPressed: () async{

                    if(_key.currentState!.validate()){
                      try{
                        setState(() {
                          isLoading=true;
                        });

                        //instance for to upload image into firebase Storage

                        FirebaseStorage fs = FirebaseStorage.instance;
                        Reference ref = await fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
                        await ref.putFile(File(_selectedImage!.path));
                        String imageUrl = await ref.getDownloadURL();

                        //done here

                        await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                        //this is instance is used for uid, email, username,name, and also used for image to upload the data to firebaseFirestore
                        FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.email).set({

                          //now here the image is will upload to firestore
                          "image":imageUrl,
                          //and done here
                          "uid":FirebaseAuth.instance.currentUser!.uid,
                          "email": FirebaseAuth.instance.currentUser!.email,
                          "username":_usernameController.text,
                          "name":_nameController.text,
                        });

                        setState(() {
                          isLoading=false;
                        });
                        _auth.currentUser!.sendEmailVerification();
                        Fluttertoast.showToast(msg: "please verify your email");
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>sign_in()));

                      }catch(e){
                        setState(() {
                          isLoading=false;
                        });
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                      }

                    }else{
                      print("error");
                    }

                  },
                  
                  width:280,

                  title: "Register",
                  btnColor: AppColor.APP_COLOR,
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account ?",style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff000000).withOpacity(0.5),
                      )
                    ),),
                    SizedBox(width: 5,),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>sign_in()));
                      },
                      child: Text("Sign in",style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColor.APP_COLOR
                          )
                      ),),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
