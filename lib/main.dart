import 'package:flutter/material.dart';
import 'package:project1/Accessing%20camera/camera_access.dart';
import 'package:project1/boardApp/util/board_app.dart';
import 'package:project1/chat_App/views/sign_in.dart';
import 'package:project1/parsing_JSON/json_parsing.dart';
import 'package:project1/parsing_JSON/json_parsing_obj.dart';
import 'package:project1/textrecognition/textrecofnition.dart';
import 'package:project1/ui/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



final ThemeData _appTheme = buildAppTheme();

ThemeData buildAppTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    brightness: Brightness.dark,
    accentColor: Colors.amber,
    primaryColor: Colors.green,
    backgroundColor: Colors.amber,
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: Colors.black,
        fontSize: 17,
      )
    )
  );
}
TextTheme _appTextTheme(TextTheme base){
  return base.copyWith().apply(
    fontFamily: "Lobster"
  );
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //runApp(const scaffold());
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: _appTheme,
    // theme: ThemeData(
    //   brightness: Brightness.dark,
    //   primaryColor: Colors.lightBlue[800],
    //   textTheme: TextTheme(
    //     headline1: TextStyle(fontSize: 34,fontWeight: FontWeight.bold),
    //     bodyText2: TextStyle(
    //       fontSize: 16.9,
    //       color: Colors.white
    //     ) 
    //   )
    // ),
    home: chat_app_sign_in(),
  ));
}


