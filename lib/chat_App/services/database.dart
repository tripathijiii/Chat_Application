import 'package:cloud_firestore/cloud_firestore.dart';

class databaseMethods{
  getUserByUsername(String username)async{
    return await FirebaseFirestore.instance.collection("users").where("name", isEqualTo: username).get();
  }
  getUserByEmail(String Email)async{
    return await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: Email).get();
  }

  uploadUserInfo(String username,String email )async{
    FirebaseFirestore.instance.collection("users").add({"name" :username, "email":email });
  }
  createChatRoom(String chatRoomID, chatRoomMap){
    FirebaseFirestore.instance.collection("chatRoom").doc(chatRoomID).set(chatRoomMap).catchError((e){
      print(e.to_String());
    });
  }
  setConversationMessages(String chatRoomID, messageMap){
    FirebaseFirestore.instance.collection("chatRoom").doc(chatRoomID).collection("chats").add(messageMap).catchError((e){
      print(e.toString());
    });
  }
  getConversationMessages(String chatRoomID) async {
    return await FirebaseFirestore.instance.collection("chatRoom").doc(chatRoomID).collection("chats").orderBy("timestamp",descending: true).snapshots();
  }
  getChatRooms(String username) async {
    return await FirebaseFirestore.instance.collection("chatRoom").where("users",arrayContains: username).snapshots();
  }

}