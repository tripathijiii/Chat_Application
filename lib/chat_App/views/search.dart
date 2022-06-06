

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/chat_App/services/constants.dart';
import 'package:project1/chat_App/services/database.dart';
import 'package:project1/chat_App/views/conversation_screen.dart';
import 'package:project1/ui/home.dart';

class search_prople extends StatefulWidget {
  const search_prople({ Key? key }) : super(key: key);

  @override
  State<search_prople> createState() => _search_propleState();
}

class _search_propleState extends State<search_prople> {
  QuerySnapshot? search2;
  databaseMethods db = new databaseMethods();
  TextEditingController? search = TextEditingController();
  Widget searchList(){
    return search2 != null ? ListView.builder(
      shrinkWrap: true,
      itemCount: search2!.docs.length,
      itemBuilder: ((context, index){
      return searchTile(userEmail: search2!.docs[index]["email"],username: search2!.docs[index]["name"],);
    })):Container();
  }
  inititeSearch(){
    db.getUserByUsername(search!.text).then((val){
      print(val.toString());
      setState(() {
        search2 = val;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("search "+Constants.myName!+" "+Constants.myEmail!)),
      backgroundColor: Colors.grey,
      body: Container(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal :16.0),
                child: Row(
                  children: [
                    Expanded(child: TextField(
                      controller: search,
                      decoration: InputDecoration(label: Text("search username",style: TextStyle(color: Colors.black),),),
                    )),
                    InkWell(onTap: () {
                      inititeSearch();
                    },child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      child: Icon(Icons.search,size: 30,)))
                  ],
                ),
              ),
            ),
            searchList(),
          ]),
      ),
      
    );
  }
}

class searchTile extends StatelessWidget {
  final String? username;
  final String? userEmail;
  final databaseMethods db = new databaseMethods();
  searchTile({ Key? key,this.username,this.userEmail }) : super(key: key);
  @override
  

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(username!),
            Text(userEmail!)
          ],
        ),
        GestureDetector(
          onTap: (){
            // create chatroom , send user to conversation screen.,push replacement.
            createChatRoomAndStartConversation(context);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            height: 40,
            decoration: BoxDecoration(color: Colors.blue.shade400,borderRadius: BorderRadius.circular(30)),
          child: Center(child: Text("Message")),),
        )
      ]),
    );
  }

  void createChatRoomAndStartConversation(BuildContext context) {
    if(username! != Constants.myName){
      List<String> users = [username!,Constants.myName!];
      String chatRoomID = getchatRoomId(username!, Constants.myName!);
      Map<String,dynamic> chatRoomMap = {
        "users" : users,
        "chatRoomId" : chatRoomID
      };

      db.createChatRoom(chatRoomID, chatRoomMap);
      Navigator.pushReplacement( context, MaterialPageRoute(builder: ((context) => conversation_room(username: username, ))));
    }else{
      print("You cannot send message to yourself");
    }
  }

  
}

getchatRoomId(String a, String b){
  if(a.substring(0,1).codeUnitAt(0)> b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }else{
    return "$a\_$b";
  }
}