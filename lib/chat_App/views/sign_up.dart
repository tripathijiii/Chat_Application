import 'package:flutter/material.dart';
import 'package:project1/chat_App/services/auth.dart';
import 'package:project1/chat_App/services/helperfunctions.dart';
import 'package:project1/chat_App/views/chat_room.dart';
import 'package:project1/chat_App/services/database.dart';

class sing_up_page extends StatefulWidget {
  const sing_up_page({ Key? key }) : super(key: key);

  @override
  State<sing_up_page> createState() => _sing_up_pageState();
}

class _sing_up_pageState extends State<sing_up_page> {

  AuthMethods authMethods= new AuthMethods();
  databaseMethods dbmethods = new databaseMethods();
  bool isloading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController? username = TextEditingController();
  TextEditingController? password = TextEditingController();
  TextEditingController? Email = TextEditingController();
  signMeUp(){
    if(formKey.currentState!.validate()){
      setState(() {
        isloading = true;
      });
      authMethods.signUpwithEmailAndPassword(Email!.text,  password!.text).then((value){
        //print("${value.uid}");
        HelperFunctions.savinguserEmailInToSharedPreference(Email!.text);
        HelperFunctions.savinguserUserNameInToSharedPreference(username!.text);
        HelperFunctions.savinguserLoggedInToSharedPreference(true);
        dbmethods.uploadUserInfo(username!.text,Email!.text);

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context)=> chat_room())),(route)=>false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign UP")),
      backgroundColor: Colors.blueGrey,
      body: isloading? Container(child: Center(child: CircularProgressIndicator()),): SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
            children: [
               Container(height: MediaQuery.of(context).size.height*0.2,
             decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1)),
             child: Image.asset("images/flag.png"),),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (val){
                  return val!.isEmpty || val.length<3 ?  "This wont work":null;
                },
                controller: username,
                autofocus: false,decoration: InputDecoration(label: Text("Enter UserName",style: TextStyle(color :Colors.black),)),),
              TextFormField(
                validator: (val){
                  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!)? null:"Please provice a valid Email";
                },
                controller: Email,
                autofocus: false,decoration: InputDecoration(label: Text("Enter Email",style: TextStyle(color :Colors.black),)),),
              TextFormField(
                validator: (val){
                  return val!.length>6 ? null:"Please provice a password 6+ character";
                },
                obscureText: true,
                controller: password,
                autofocus: false,decoration: InputDecoration(label: Text("Enter Password",style: TextStyle(color :Colors.black),),),),
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
                child: Text("Sign UP"),
              ),
              onTap: (){
                signMeUp();
              },
            ),
            SizedBox(height: 15,),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 400,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30)),
                child: Text("Sign UP with Google"),
              ),
              onTap: (){},
            ),
            SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Already a user ? ",style: TextStyle(fontSize: 12),),
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child:Text("Sign IN",style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 9, 38, 63),decoration: TextDecoration.underline) ))
            ],),
            SizedBox(height: 50,)
            ]),),
        ),
      ),
    );
  }
}