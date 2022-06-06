

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class board_App extends StatefulWidget {
  const board_App({ Key? key }) : super(key: key);

  @override
  State<board_App> createState() => _board_AppState();
}

class _board_AppState extends State<board_App> {
  var firestoreDb = FirebaseFirestore.instance.collection("board").orderBy("timestamp",descending: true).snapshots();
  TextEditingController? nameInputController;
  TextEditingController? titleInputController;
  TextEditingController? descriptionInputController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameInputController = TextEditingController();
    titleInputController = TextEditingController();
    descriptionInputController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Community Board")),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _showDialog(context);
      },
      child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreDb,
        builder: (context, snapshot) {
        if(!snapshot.hasData) return CircularProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [Container(height: 100,
            child: Card(
              elevation: 9.0,
              child: ListTile(
                title: Text(snapshot.data!.docs[index]['title']),
                leading: CircleAvatar(radius: 20,child: Text(snapshot.data!.docs[index]['title'][0]),),
                subtitle: Text(snapshot.data!.docs[index]['description'].toString().length > 22 ? snapshot.data!.docs[index]['description'].toString().substring(0,22)+"..." : snapshot.data!.docs[index]['description'].toString(),overflow: TextOverflow.fade,),
                trailing: Container(
                  height: 100,
                  child:
                  IconButton(onPressed: ()async{
                    await FirebaseFirestore.instance.collection("board").doc(snapshot.data!.docs[index].id).delete();
                  }, icon: Icon(Icons.delete)),
                ),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: ((context) => board2_inside(doc: snapshot.data!.docs[index],)) ));
                },
              ),
            ),
            )],
            );
          //return Text(snapshot.data!.docs[index]['title']);
        },);
      })
      );
  }
  _showDialog(BuildContext context) async{
    await showDialog(context: context, builder: (_)=> new AlertDialog(
      contentPadding: EdgeInsets.all(10),
      content: Column(children: [
        Text("please Fill out the form,"),
        Expanded(child: TextField(autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(labelText: "your name"),
        controller: nameInputController,
        )),
        Expanded(child: TextField(autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(labelText: "title"),
        controller: titleInputController,
        )),
        Expanded(child: TextField(autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(labelText: "description"),
        controller: descriptionInputController,
        ))
      ]),
      actions: [
        TextButton(onPressed: (){
          if(titleInputController!.text.isNotEmpty && descriptionInputController!.text.isNotEmpty && nameInputController!.text.isNotEmpty){
            FirebaseFirestore.instance.collection("board").add({
              "name" : nameInputController!.text,
              "title" : titleInputController!.text,
              "description" : descriptionInputController!.text,
              "timestamp" : new DateTime.now()
            }).then((response){
              print(response.id);
              Navigator.pop(context);
              nameInputController!.clear();
              titleInputController!.clear();
              descriptionInputController!.clear();
              
            }).catchError((onError)=> print("error"));
          }
        }, child: Text("Done")),
        TextButton(onPressed: (){
          nameInputController!.clear();
          titleInputController!.clear();
          descriptionInputController!.clear();
          Navigator.pop(context);
        }, child: Text("Cancel"))
      ],
    ));
  }

  void board_whats_written(BuildContext context, QueryDocumentSnapshot<Object?> doc) {}

}

class board2_inside extends StatelessWidget {
  final QueryDocumentSnapshot<Object?>? doc;
  const board2_inside({ Key? key,this.doc }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${doc!["name"]+" "+doc!["title"]}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(alignment: Alignment.center,
        height: MediaQuery.of(context).size.height*0.7,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2),color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Name :",style: TextStyle(fontSize: 20),),
              Text("${doc!["name"]+" "+doc!["title"]}".toUpperCase())],),
            ),
            SizedBox(height: 60,),
            Text("Description : ${doc!["description"]}"),
            SizedBox(height: 60,),
            Text("Date and TIme: ${doc!["timestamp"].toDate()}")
            
          ],
          ),
        )
        ,),
      ),
    );
  }
}