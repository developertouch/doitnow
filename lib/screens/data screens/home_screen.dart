import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doitnow/screens/auth%20screens/sign_in_screen.dart';
import 'package:doitnow/screens/onboarding%20scrreen/onboarding_screen.dart';
import 'package:doitnow/styles/color_widgets.dart';
import 'package:doitnow/styles/textstyles_widget.dart';
import 'package:doitnow/widgets/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';

class home_Screen extends StatefulWidget {
  const home_Screen({Key? key}) : super(key: key);

  @override
  State<home_Screen> createState() => _home_ScreenState();
}

class _home_ScreenState extends State<home_Screen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _reminderController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  TextEditingController _profileUsernameController= TextEditingController();
  TextEditingController _profileEmailController= TextEditingController();
  TextEditingController _profileNameController=TextEditingController();
    final currentuser = FirebaseAuth.instance;

    void showAlert(QuickAlertType quickAlertType){
      QuickAlert.show(
       width: 100,

        showCancelBtn: true,
        text: 'Do you want to logout',
          context: context, type:
      QuickAlertType.confirm,
          onConfirmBtnTap: () async{
        var _auth=await FirebaseAuth.instance;
        try{
          await _auth.signOut();
          Fluttertoast.showToast(msg: "you are now logout so login again");
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>onboarding()));

        }catch(e){
          print(e.toString());

        }
      },
        onCancelBtnTap: (){
          Navigator.of(context).pop();

        },
        confirmBtnColor: AppColor.APP_COLOR,
        customAsset: 'images/backgound1.png',

      );

    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: StreamBuilder<QuerySnapshot>(

              stream: FirebaseFirestore.instance.collection("users").where("email", isEqualTo: currentuser.currentUser!.email).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          child: Card(
                            color: Colors.white,
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(snapshot.data!.docs[index]['image']),
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text("Name:",style: GoogleFonts.poppins(
                                        textStyle: AppTextStyles.HEADING_TEXT
                                      ),),
                                      SizedBox(width: 5,),
                                      Text(snapshot.data!.docs[index]['name'],
                                        style: GoogleFonts.poppins(
                                            textStyle: AppTextStyles
                                                .DESCRIPTION_TEXT
                                        ),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Username:",style: GoogleFonts.poppins(
                                        textStyle: AppTextStyles.HEADING_TEXT,
                                      ),),
                                      SizedBox(width: 5,),
                                      Text(snapshot.data!.docs[index]['username'],
                                        style: GoogleFonts.poppins(
                                            textStyle: AppTextStyles
                                                .DESCRIPTION_TEXT
                                        ),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Email:",style: GoogleFonts.poppins(
                                        textStyle: AppTextStyles.HEADING_TEXT,
                                      ),),
                                      SizedBox(width: 5,),
                                      Text(snapshot.data!.docs[index]['email'],style: GoogleFonts.poppins(
                                        textStyle: AppTextStyles.DESCRIPTION_TEXT,
                                      ),),
                                    ],
                                  ),


                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
          backgroundColor: AppColor.BG_COLOR,
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () async{
                showAlert(QuickAlertType.confirm);
                 // var _auth=await FirebaseAuth.instance;
                 // try{
                 //   await _auth.signOut();
                 //   Fluttertoast.showToast(msg: "you are now logout so login again");
                 //   Navigator.of(context).push(MaterialPageRoute(builder: (_)=>onboarding()));
                 //
                 // }catch(e){
                 //   print(e.toString());
                 //
                 // }

              }, icon:Icon(Icons.logout_rounded)),
            ],
            backgroundColor: AppColor.APP_COLOR,
            title: Text("DoItNow"),
          ),


          // Save data in firebase firestore
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColor.APP_COLOR,
            onPressed: () {
              showModalBottomSheet(context: context, builder: (_) {
                return Container(
                  height: 500,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                              hintText: "Title"
                          ),
                        ),
                        TextField(
                          maxLines: 1,
                          controller: _reminderController,
                          decoration: InputDecoration(
                              hintText: "What to reminder"
                          ),
                        ),
                        SizedBox(height: 20,),
                        buttons(
                          onPressed: () {
                            FirebaseFirestore.instance.collection("Notes").add({
                              "uid": FirebaseAuth.instance.currentUser!.uid,
                              "title": _titleController.text,
                              "Reminder": _reminderController.text,
                            });
                            Navigator.of(context).pop();
                          },
                          width: 100,
                          title: "Save",
                          btnColor: AppColor.APP_COLOR,

                        ),
                      ],
                    ),
                  ),
                );
              });
            },
            child: Icon(Icons.add),
          ),


          // get data form firebase irestore
          body: Column(
            children: [
              Expanded(child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Notes").where(
                    "uid", isEqualTo: currentuser.currentUser!.uid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 20, left: 10, right: 10),
                            child: Slidable(
                              startActionPane: ActionPane(
                                motion: StretchMotion(),
                                children: [
                                  //DATA DELETION FORM FIREBASE
                                  SlidableAction(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12)),
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,
                                    label: "Delete",
                                    onPressed: (context) {
                                      setState(() {
                                        FirebaseFirestore.instance.collection(
                                            "Notes")
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();
                                        Fluttertoast.showToast
                                          (msg: "this is data has been delete");
                                      });
                                    },

                                  )
                                ],
                              ),

                              // DATA UPDATE FORM FIREBASE
                              endActionPane: ActionPane(
                                motion: BehindMotion(),
                                children: [
                                  SlidableAction(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12)),
                                    backgroundColor: Colors.greenAccent,
                                    icon: Icons.edit,
                                    label: "Edit",
                                    onPressed: (context) {
                                      _nameController.text = snapshot.data!.docs[index]['title'];
                                      _messageController.text = snapshot.data!.docs[index]['Reminder'];
                                      showModalBottomSheet(
                                          context: context, builder: (_) {
                                        return Container(
                                          height: 500,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              children: [
                                                TextField(
                                                  controller: _nameController,
                                                ),
                                                TextField(
                                                  controller: _messageController,
                                                ),
                                                SizedBox(height: 20,),
                                                buttons(
                                                  title: "update",
                                                  width: 150,
                                                  btnColor: AppColor.APP_COLOR,
                                                  onPressed: () {
                                                    FirebaseFirestore.instance.collection("Notes").doc(snapshot.data!.docs[index].id).update({"title": _nameController.text, "Reminder": _messageController.text,});
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => sign_in()));},

                                                ),

                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  )
                                ],
                              ),

                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white10,
                                  border: Border.all(color: AppColor.APP_COLOR,width: 2)
                                ),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index]['title'],
                                        style: GoogleFonts.poppins(
                                            textStyle: AppTextStyles
                                                .DATA_LIST_HEADING
                                        ),),
                                      Divider(),
                                      SizedBox(height: 10),
                                      Text(snapshot.data!
                                          .docs[index]['Reminder'],
                                        style: GoogleFonts.poppins(
                                            textStyle: AppTextStyles
                                                .DATA_LIST_DESCRIPTION
                                        ),),


                                    ],
                                  ),
                                ),
                              ),

                            ),
                          );
                        });
                  }
                },
              ))

            ],
          )
      );
    }
  }

