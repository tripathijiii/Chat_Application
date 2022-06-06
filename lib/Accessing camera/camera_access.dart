import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class Camera_access extends StatefulWidget {
  const Camera_access({ Key? key }) : super(key: key);

  @override
  State<Camera_access> createState() => _Camera_accessState();
}

class _Camera_accessState extends State<Camera_access> {
  File? _image;
  Future getimage(bool access) async{
    PickedFile? image;
    if(access){
      try{
        ImagePicker picker = ImagePicker();
        image = await picker.getImage(source: ImageSource.camera);
      }catch(exception){
        return;
      }
    }else{
       ImagePicker picker = ImagePicker();
        image = await picker.getImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = File(image!.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Camera Access")),
      body: Row(
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: (){
              getimage(false);
            }, icon: Icon(Icons.image_search)),
            SizedBox(height: 20,),
            IconButton(onPressed: (){
              getimage(true);
            }, icon: Icon(Icons.camera))
          ],),
          _image==null?Container(width: MediaQuery.of(context).size.width-100,height: 500,):Container(width: MediaQuery.of(context).size.width-100,decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: FileImage(_image!))),),
        ],
      ),
    );
  }
}


