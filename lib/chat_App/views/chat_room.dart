import 'package:flutter/material.dart';
import 'package:project1/chat_App/services/auth.dart';
import 'package:project1/chat_App/services/constants.dart';
import 'package:project1/chat_App/services/database.dart';
import 'package:project1/chat_App/services/helperfunctions.dart';
import 'package:project1/chat_App/views/conversation_screen.dart';
import 'package:project1/chat_App/views/search.dart';
import 'package:project1/chat_App/views/sign_in.dart';
import 'package:project1/chat_App/views/sign_up.dart';
import 'package:project1/ui/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class chat_room extends StatefulWidget {
  const chat_room({ Key? key }) : super(key: key);

  @override
  State<chat_room> createState() => _chat_roomState();
}

class _chat_roomState extends State<chat_room> {
  AuthMethods authMethods = new AuthMethods();
  databaseMethods db = new databaseMethods();
  Stream<QuerySnapshot>? chatroomStream;

  Widget chatRoomList(){
    return StreamBuilder<QuerySnapshot>(
      stream: chatroomStream,
      builder: (context,snapshot){
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context,index){
            return chatRoomTile(usernam: snapshot.data!.docs[index]["chatRoomId"].toString().replaceAll("_", "").replaceAll(Constants.myName!, ""),);
          }):Container(child: Text("${Constants.myName}"),);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  getUserInfo() async{
    Constants.myName = await HelperFunctions.getuserUserNameInToSharedPreference();
    Constants.myEmail = await HelperFunctions.getuserUserEmailInToSharedPreference();
    db.getChatRooms(Constants.myName!).then((value){
      setState(() {
        chatroomStream=value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat Room"),
          actions: [
            GestureDetector(
              onTap: () {
                authMethods.signOut();
                HelperFunctions.savinguserLoggedInToSharedPreference(false);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context)=> homie())),(route)=>false);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app),
              ),
            )
          ],
    ),
    backgroundColor: Colors.grey,
    floatingActionButton: FloatingActionButton(child: Icon(Icons.search),onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: ((context)=> search_prople())));
    },),
    body: Container(child: chatRoomList()),
    );
  }
}

class chatRoomTile extends StatelessWidget {
  final String? usernam;
  const chatRoomTile({ Key? key,this.usernam }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => conversation_room(username: usernam,),));
      },
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 3)),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              height: 60,width: 60,
              child: CircleAvatar(child: Text(usernam![0].toUpperCase(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),backgroundColor: Colors.blue,),
            ),
            SizedBox(width: 20,),
            Text(" $usernam".toUpperCase())
          ],
        ),
      ),
    );
  }
}