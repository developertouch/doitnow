import 'dart:async';

import 'package:doitnow/screens/auth%20screens/sign_in_screen.dart';
import 'package:doitnow/screens/data%20screens/home_screen.dart';
import 'package:doitnow/screens/onboarding%20scrreen/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class splashServices{

  void isSignIn(BuildContext context){
    final auth =FirebaseAuth.instance;
    final user=auth.currentUser;
    if(user != null){
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>home_Screen()));
      });
    }else{
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>onboarding()));
    });


  }
}
}