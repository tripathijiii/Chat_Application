import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/chat_App/services/constants.dart';
import 'package:project1/chat_App/services/database.dart';

class conversation_room extends StatefulWidget {
  final String? username;
  const conversation_room({ Key? key,this.username }) : super(key: key);

  @override
  State<conversation_room> createState() => _conversation_roomState(username!);
}

class _conversation_roomState extends State<conversation_room> {
  TextEditingController sender = TextEditingController();
  String? username; 
  databaseMethods db = new databaseMethods();
  Stream<QuerySnapshot>? chatmessageStream;

  Widget chatmessageList(){
    return StreamBuilder<QuerySnapshot>(
      stream: chatmessageStream,
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Container();
        }
        return ListView.builder(
          reverse: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index){
            return  MessageTile(message: snapshot.data!.docs[index]["message"],username: snapshot.data!.docs[index]["sendBy"]==Constants.myName ,);
          });
      });
  }

  sendMessage() {
    String chatRoomID = getchatRoomId(username!, Constants.myName!);
    if(sender.text.isNotEmpty){
      db.setConversationMessages(chatRoomID, {"message" : sender.text,
        "sendBy" : Constants.myName,
        "timestamp" : new DateTime.now()
      });
    }
  }

  _conversation_roomState(this.username);
  @override
  void initState() {
    // TODO: implement initState
    db.getConversationMessages(getchatRoomId(username!, Constants.myName!)).then((value){
      setState(() {
        chatmessageStream=value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${username}"),),
      backgroundColor: Colors.grey,
      body: Container(
        child: Stack(

          children: [
            Container(
              padding: EdgeInsets.only(bottom: 80),
              child: chatmessageList()),
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal :16.0,vertical: 30),
                child: Row(
                  children: [
                    Expanded(child: TextField(
                      controller: sender,
                      decoration: InputDecoration(label: Text("Message",style: TextStyle(color: Colors.black),),),
                    )),
                    InkWell(onTap: () {
                      sendMessage();
                      sender.clear();
                    },child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      child: Icon(Icons.send,size: 30,)))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
getchatRoomId(String? a, String? b){
  if(a!.substring(0,1).codeUnitAt(0)> b!.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }else{
    return "$a\_$b";
  }
}

class MessageTile extends StatelessWidget {
  final String? message;
  final bool? username;
  const MessageTile({ Key? key,this.message,this.username }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 8),
      width: MediaQuery.of(context).size.width,
      alignment: username!? Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        decoration: BoxDecoration(color: username!? Colors.green.shade100:Colors.grey.shade300,
        borderRadius: username! ? BorderRadius.only(
          topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
          bottomLeft: Radius.circular(23)
          ): BorderRadius.only(
            topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
          bottomRight: Radius.circular(23)
          )
          ),
        child: Text(message!),
      ),
    );
  }
}