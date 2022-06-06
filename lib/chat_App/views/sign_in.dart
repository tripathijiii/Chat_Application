import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:project1/chat_App/services/auth.dart';
import 'package:project1/chat_App/services/database.dart';
import 'package:project1/chat_App/views/chat_room.dart';
import 'package:project1/chat_App/views/sign_up.dart';

import '../services/helperfunctions.dart';

class chat_app_sign_in extends StatefulWidget {
  const chat_app_sign_in({ Key? key }) : super(key: key);
  @override
  State<chat_app_sign_in> createState() => _chat_app_sign_inState();
}

class _chat_app_sign_inState extends State<chat_app_sign_in> {


  
  databaseMethods db = new databaseMethods();
  AuthMethods authMethods = new AuthMethods();
  bool isloading = false;
  final formkey = GlobalKey<FormState>();
  TextEditingController? password = TextEditingController();
  TextEditingController? Email = TextEditingController();
  QuerySnapshot? snapshot;
  signMEin(){
    if(formkey.currentState!.validate()){
      print(Email!.text);
      db.getUserByEmail(Email!.text).then((value){
        print(value.toString());
        snapshot=value;
        
      });
      setState(() {
        isloading = true;
      });
      authMethods.signInEmailAndPassword(Email!.text, password!.text).then((value){
        HelperFunctions.savinguserUserNameInToSharedPreference(snapshot?.docs[0]['name'] ?? "Unknown");
        HelperFunctions.savinguserEmailInToSharedPreference(Email!.text);
        HelperFunctions.savinguserLoggedInToSharedPreference(true);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context)=> chat_room())), (route) => false);

        
      });
    }
  }
  bool userIsloggedIN = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign IN !!!")),
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
            children: [
               Container(height: MediaQuery.of(context).size.height*0.37,
             decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1)),
             child: Image.asset("images/flag.png"),),
            Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)? null:"Please provice a valid Email";
                    },
                controller: Email,
                autofocus: false,decoration: InputDecoration(label: Text("Enter Email ID",style: TextStyle(color :Colors.black),)),),
              TextFormField(
                obscureText: true,
                validator: (val){
                  return val!.length>6 ? null:"Please provice a password 6+ character";
                },
                controller: password,
                autofocus: false,decoration: InputDecoration(label: Text("Enter Password",style: TextStyle(color :Colors.black),)),),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(alignment: Alignment.centerRight,
            child: TextButton(child: Text("Forgot Password ?",style: TextStyle(fontSize: 14,color: Colors.white),),onPressed: (){},),),
            SizedBox(height: 15,),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 400,
                decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(30)),
                child: Text("Sign IN"),
              ),
              onTap: (){
                signMEin();
              },
            ),
            SizedBox(height: 15,),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 400,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30)),
                child: Text("Sign IN with Google"),
              ),
              onTap: (){},
            ),
            SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Dont have an acount ? ",style: TextStyle(fontSize: 12),),
            TextButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: ((context) => sing_up_page())));
            }, child:Text("Register Now",style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 9, 38, 63),decoration: TextDecoration.underline) ))
            ],),
            SizedBox(height: 50,)
            ]),),
        ),
      ),
      );
  }
}