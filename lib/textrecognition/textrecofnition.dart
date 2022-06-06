import 'dart:io';

import 'package:flutter/material.dart';

class textRecognition extends StatefulWidget {
  const textRecognition({ Key? key }) : super(key: key);

  @override
  State<textRecognition> createState() => _textRecognitionState();
}

class _textRecognitionState extends State<textRecognition> {

  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Text Recognition")),
      body: Column(children: [
        SizedBox(height: 25,),
        image !=null ? Image.file(image!):Icon(Icons.photo,size: 50,),
      ]),
    );
  }
}