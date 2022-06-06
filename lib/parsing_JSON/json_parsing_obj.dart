import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project1/model/Post.dart';

class Jason_parsing_obj extends StatefulWidget {
  const Jason_parsing_obj({ Key? key }) : super(key: key);

  @override
  State<Jason_parsing_obj> createState() => _Jason_parsing_objState();
}

class _Jason_parsing_objState extends State<Jason_parsing_obj> {
  Future<PostList>? data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Json parsing object")),
      body: Center(child: Container(child: FutureBuilder(future: getdata(),
      builder: (context,AsyncSnapshot<PostList> snapshot){
        if(snapshot.hasData){
          return createListView(snapshot.data!,context);
        }
        else{
          return CircularProgressIndicator();
        }
      },
      ),)),
    );
  }
  Future<PostList> getdata() async{
    var data ;
    String url = "https://jsonplaceholder.typicode.com/posts";
    Network network = Network(url);
    data = network.fetchData();
    return data;
  }

  Widget createListView(PostList data, BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: data.posts!.length,
        itemBuilder: (context,index){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(height: 10,),
              ListTile(
                title: Text(data.posts![index].title!),
                subtitle: Text(data.posts![index].userId!.toString()),
                leading: CircleAvatar(
                  radius: 23,
                  backgroundColor: Colors.black,
                  child: Text(data.posts![index].id.toString(),style: TextStyle(color: Colors.white),) ,
                ),

            )],
          );
        }),
    );
  }
}

class Network{
  final String? url;
  Network(this.url);

  Future<PostList> fetchData() async{
    Response response = await get(Uri.parse(url!));
    if(response.statusCode==200){
      return PostList.fromJson(json.decode(response.body));
    }
    else{
      throw Exception(response.statusCode);
    }
  }
}