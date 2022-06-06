import 'package:flutter/material.dart';
import 'package:project1/model/movie.dart';



class movieDetailsThumbnail extends StatelessWidget {
  final String? thumbnail;
  const movieDetailsThumbnail({ Key? key,this.thumbnail }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height:250,
            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(thumbnail ?? "https://picsum.photos/300/300" ),fit: BoxFit.cover)),
          ),
          Icon(Icons.play_circle_outline,size: 100,color:Colors.white,),
        ],
        ),
        Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0x00f5f5f5),Color(0xfff5f5f5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
            )
          ),
        )
      ],
    );
  }
}

class MovieDetailsHeaderwithPoster extends StatelessWidget {
  final movie? first;
  const MovieDetailsHeaderwithPoster({ Key? key,this.first }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:16.0),
      child: Row(
        children: [
          MoviePoster(poster: first!.images[0].toString()),
          SizedBox(width: 20,),
          Expanded(child: MovieDetailHeader(first: first))
        ],
        
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String? poster;
  const MoviePoster({ Key? key,this.poster }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(borderRadius: borderRadius,
      child: Container(
        width: MediaQuery.of(context).size.width/4,
        height: 160,
        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(poster!),fit: BoxFit.cover)),

      ),
      ),


    );
  }
}
class MovieDetailHeader extends StatelessWidget {
  final movie? first;
  const MovieDetailHeader({ Key? key,this.first }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${first!.year} . ${first!.genre}".toUpperCase(),style: TextStyle(fontWeight: FontWeight.w400,color: Colors.indigoAccent),),
        Text(first!.title.toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        Text.rich(TextSpan(style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300),
        children: <TextSpan>[
          TextSpan(text: first!.plot),
          TextSpan(text: "More...",style: TextStyle(color: Colors.indigo))
        ]
        ))
      ],
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  final movie? first;
  const MovieDetailsCast({ Key? key,this.first }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MovieField(field:"Cast",value:first!.actors),
          MovieField(field:"Directors",value:first!.director),
          MovieField(field: "Awards",value: first!.awards,)
        ],
      ),
    );
  }
}
class MovieField extends StatelessWidget {
  final String? field;
  final String? value;
  const MovieField({ Key? key,this.field,this.value }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Text("$field :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),),
        Flexible(child: Text(value!,style: TextStyle(fontSize: 15),))
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
      child: Container(
        height:0.5,
        color: Colors.grey,
      ),
    );
  }
}

class MovieExtraPoster extends StatelessWidget {
  final List<String>? posters;
  const MovieExtraPoster({ Key? key,this.posters }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text("More movie Images",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,),),
        ),
        Container(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index)=>ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.width/4,
                height: 160,
                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(posters![index]),fit: BoxFit.cover)),
              ),
            ), separatorBuilder: (context,index)=> SizedBox(width:8), itemCount: posters!.length),
        )
      ],
    );
  }
}