import 'package:doitnow/screens/auth%20screens/sign_in_screen.dart';
import 'package:doitnow/styles/color_widgets.dart';
import 'package:doitnow/styles/textstyles_widget.dart';
import 'package:doitnow/widgets/buttons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
class onboarding extends StatelessWidget {
  const onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BG_COLOR,
      body:SafeArea(
        child: Column(
           children: [
             SizedBox(height: 100,),
             Center(
               child: Container(
                 height: 230,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     image: AssetImage("images/onboarding2.jpg")
                   )
                 ),
               ),
             ),
              SizedBox(height: 24,),
              Text("Lets get things done...",style: GoogleFonts.poppins(
               textStyle: AppTextStyles.HEADING_TEXT
             ),),
               SizedBox(height: 10,),
               Text("             Welcome to our DoItNow app! \n        We are thrilled to have you onboard. \n Let's get started with a quick tour of the app.",style: GoogleFonts.poppins(
               textStyle: AppTextStyles.DESCRIPTION_TEXT,
             ),),
               SizedBox(height: 86,),
               buttons(
               onPressed: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (_)=>sign_in()));
               },
               width:280,
               title: "Get Started",
               btnColor: AppColor.APP_COLOR,


             )


           ],
          ),
      ),

    );
  }
}
