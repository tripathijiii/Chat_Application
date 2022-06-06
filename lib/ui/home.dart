

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project1/Accessing%20camera/camera_access.dart';
import 'package:project1/boardApp/util/board_app.dart';
import 'package:project1/chat_App/views/chat_room.dart';
import 'package:project1/chat_App/views/sign_in.dart';
import 'package:project1/model/movie.dart';
import 'package:project1/model/question.dart';
import 'package:project1/ui/movie_ui/movie_ui.dart';

import '../chat_App/services/helperfunctions.dart';

class scaffold extends StatelessWidget {
  const scaffold({Key? key}) : super(key: key);
  _tapButton() {
    debugPrint("THe button was tapped from a function");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scaffold Test"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: () => debugPrint("Email tapped"),
              icon: Icon(Icons.email)),
          IconButton(onPressed: () => _tapButton, icon: Icon(Icons.alarm))
        ],
      ),
      backgroundColor: Colors.amberAccent,
      body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(),
              // use Inkwell for just a tap or something
              // InkWell(
              //   child: Text("Tap me!!!",style: TextStyle(fontSize: 24.5,
              //   fontWeight: FontWeight.w500),),
              //   onTap: ()=>debugPrint("Tapped"),
              // )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => debugPrint("this button was pressed")),
        backgroundColor: Colors.lightGreen,
        child: Icon(Icons.missed_video_call),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Yo mama"),
          BottomNavigationBarItem(icon: Icon(Icons.cancel), label: "SUPER HOT")
        ],
        onTap: (int index) => debugPrint("tapped item = $index"),
      ),
    );
  }
}

// Custom Button
class CustomButton extends StatelessWidget {
  const CustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(content: Text("HEY THERE !!!"));
        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 197, 41, 20),
            borderRadius: BorderRadius.circular(8.0)),
        child: Text("Press ME !!!"),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.deepOrangeAccent,
      child: Center(
          child: Text(
        "this is another one",
        textDirection: TextDirection.ltr,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 23.4,
            fontStyle: FontStyle.italic),
      )),
    );

    // return Center(
    //   child: Text("Hello world !!!",textDirection: TextDirection.ltr,),
    // );
  }
}

class BizCard extends StatelessWidget {
  const BizCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BizCard"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
          _getcard(),
          _getavatar(),
          ],
        ),
      ),
    );
  }

  Container _getcard() {
    return Container(
      width: 350,
      height: 200,
      margin: EdgeInsets.all(50),
      decoration: BoxDecoration(color: Colors.pink,borderRadius: BorderRadius.circular(4.5)),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Shashwatesh Tripathi",style: TextStyle(fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold
          ),),
          Text("Shashwatesht@gmail.com"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person),
              Text("stripathi1_be19@thapar.edu")
            ],
          )
        ],
      ),
    );
  }

  Container _getavatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(color: Colors.redAccent,width: 1.2),
        image: DecorationImage(image: NetworkImage("https://picsum.photos/300/300"),
        fit: BoxFit.cover)
      ),
    );
  }
}

class Wisdom extends StatefulWidget {
  const Wisdom({ Key? key }) : super(key: key);

  @override
  State<Wisdom> createState() => _WisdomState();
}

class _WisdomState extends State<Wisdom> {
  int _index=0;
  List quotes=[" halla bol !!!","goliyon ki raas leela raam leela","epidemic hai bhaisahab","lol ho gya bhaijaan"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(quotes[_index%quotes.length],style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
            Padding(padding: EdgeInsets.all(100)),
            TextButton.icon(onPressed: _showQuote, 
            icon: Icon(Icons.wb_sunny,color: Colors.black,), label: Text("inspire ME!",style: TextStyle(backgroundColor: Colors.amber,color: Colors.lightGreen,fontSize: 24,fontWeight: FontWeight.bold),),),

          ],
        ),
      ),
    );
  }

  void _showQuote() {
    setState(() {
      _index++;  
    });
    
  }
}

class tipCalc extends StatefulWidget {
  const tipCalc({ Key? key }) : super(key: key);

  @override
  State<tipCalc> createState() => _tipCalcState();
}

class _tipCalcState extends State<tipCalc> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tip Calculator"),
      centerTitle: true,
      backgroundColor: Colors.black,
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(20.5),
        children: [
          Container(
            width:200,
            height: 200,
            decoration: BoxDecoration(color: Colors.purpleAccent.shade100,borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Total per Person",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("\$  ${calculateTotalPerPerson(calculateTotalTip(_billAmount,_personCounter,_tipPercentage),_billAmount,_personCounter)}",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
                      ),
                    ],
                  )
                ]),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(color: Color.fromARGB(255, 245, 181, 158),borderRadius: BorderRadius.circular(8),border: Border.all(color: Colors.black,style: BorderStyle.solid)),
            child: Column(
              children: [
                TextField(keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(prefixText: "Bill Amount : ",prefixIcon: Icon(Icons.attach_money,)),
                onChanged: (String value){
                  try{
                    setState(() {
                      _billAmount=double.parse(value);  
                    });
                    
                  }catch(exception){
                    setState(() {
                      _billAmount=0.0;  
                    });
                    
                  }
                }
                ,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Split"),
                    Row(
                      children: [
                        InkWell(
                          onTap:(){
                            setState(() {
                              if(_personCounter>1){
                                _personCounter--;
                              }
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(color: Colors.purpleAccent,borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Center(child: Text("-",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),)),
                          ),
                        ),
                        Text("$_personCounter",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25) ,),
                        InkWell(
                          onTap:(){
                            setState(() {
                              _personCounter++;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(color: Colors.purpleAccent,borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Center(child: Text("+",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                  children: [
                    Text("Tip"),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Center(child: Text("\$${calculateTotalTip(_billAmount,_personCounter,_tipPercentage).toStringAsFixed(2)}",style: TextStyle(color: Colors.purpleAccent,fontSize: 27,fontWeight: FontWeight.bold),)))
                  ],
                ),
                Column(
                  children: [
                    Text("$_tipPercentage%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.purpleAccent),),
                    Slider( value: _tipPercentage.toDouble(),min: 0,max: 100,activeColor: Colors.purpleAccent, inactiveColor: Colors.grey,divisions: 10,  onChanged: (double value){
                      setState(() {
                        _tipPercentage=value.round();
                      });
                    })

                  ],
                )
              ],
            ),

          )
        ],
      ),
      ),
    );
  }
  calculateTotalPerPerson(double TotalTip,double billAmount,int splitBy){
    var totalPerPerson = (TotalTip + billAmount)/splitBy;
    return totalPerPerson.toStringAsFixed(2);

  }
  calculateTotalTip(double billAmount,int splitBy ,int tipPercentage){
    double totalTip =0.0;
    if(billAmount<0 || billAmount.toString().isEmpty || billAmount==null){
      return 0.0;
    }
    else{
      totalTip = (billAmount*tipPercentage)/100;

    }
    return totalTip;
  }
}

class quizApp extends StatefulWidget {
  const quizApp({ Key? key }) : super(key: key);

  @override
  State<quizApp> createState() => _quizAppState();
}

class _quizAppState extends State<quizApp> {
  
  List questionBank=[
    Question.name("Did india Recieve its independence is 1947 ?", true),
    Question.name("Did india Recieve its independence is 1948 ?", false),
    Question.name("Did india Recieve its independence is 1949 ?", false),
    Question.name("Did india Recieve its independence is 1950 ?", false),
  ];
  int _index=0;
  bool answer=false;
  bool answergiven =true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz APP"),
      centerTitle: true,
      //backgroundColor: Colors.blueGrey,
      ),
      //backgroundColor: Colors.blueGrey,
      body: Builder(// we here use a builder to use a context that is a descendent of scaffold or else scaffold.of will return null
        builder:(BuildContext context)=> Container(
          alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset("images/flag.png",width: 300,height: 200,),
          Container(
          alignment: Alignment.center,  
          height: 120,
          child: Text(questionBank[_index].questionText,
          //style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: ()=>_prev() , child: Text("<-",style: TextStyle(color: Colors.white),)),
                ElevatedButton(onPressed: ()=>_checkAnswer(true,context) , child: Text("TRUE",style: TextStyle(color: Colors.white))),
                ElevatedButton(onPressed: ()=>_checkAnswer(false,context) , child: Text("FALSE",style: TextStyle(color: Colors.white))),
                ElevatedButton(onPressed: ()=>_next() , child: Text("->",style: TextStyle(color: Colors.white),)),
              
              ],),
          ),
          Spacer(),
          ]
          ),
        ),
      ),
    );
  }

  _checkAnswer(bool answer,BuildContext context) {
    if(answer == questionBank[_index].iscorrect){
      
      final snackbar = SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 500),
        content: Text("Correct",textAlign: TextAlign.center,));
      Scaffold.of(context).showSnackBar(snackbar);      
      debugPrint("correct");
      setState(() {
         _index=(_index+1)%questionBank.length;
      });
    }
    else{
      final snackbar = SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(milliseconds: 500),
        content: Text("InCorrect",textAlign: TextAlign.center,));
      Scaffold.of(context).showSnackBar(snackbar);
      debugPrint("Incorrect");
    }
  }

  _next() {
    setState(() {
      _index=(_index+1)%questionBank.length;
    });
  }

  _prev() {
    setState(() {
      _index=(_index-1)%questionBank.length;
    });
  }
}

class MovieListView extends StatelessWidget {
  const MovieListView({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    final List<movie> movieList = movie.getMovies();
    
    final List movies = [
    "Titanic",
    "Blade Runner",
    "Rambo",
    "The Avengers",
    "Avatar",
    "I Am Legend",
    "300",
    "The Wolf of Wall Street",
    "Interstellar",
    "Game of Thrones",
    "Vikings",
    "Vikings",
    "Vikings",
    "LIONKING"
  ];
    return Scaffold(
      appBar: AppBar(title: Text("Movie List"),centerTitle: true,backgroundColor: Colors.blueGrey.shade900,),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: ((context, index) {
          return Stack(
            children: [
              Positioned( 
                child: movieCard(movieList[index], context)),
              Positioned(
                top: 10,

                child: movieImage(movieList[index].images[0])),
              
            ],
            );
        // return Card(
        //   elevation: 4.5,
        //   color: Colors.white,
        //   child: ListTile(
        //     title: Text(movieList[index].title),
        //     subtitle: Text(movieList[index].awards),
        //     leading: CircleAvatar(backgroundColor: Colors.amber,child: Container(
        //       width: 200,
        //       height: 200,
        //       decoration: BoxDecoration(
        //         image: DecorationImage(image: NetworkImage(movieList[index].images[0]),fit: BoxFit.cover),
        //         borderRadius: BorderRadius.circular(14)),
        //       )),
        //       trailing: Text("..."),
        //       onTap: (){
        //         Navigator.push(context, MaterialPageRoute(builder: (context)=> MovieListViewDetails(movieName: movieList[index].title,first: movieList[index],)));
        //       },
        //       //onTap: ()=>debugPrint("MOvie name = ${movies[index]}"),
        //   ),
        // );
      })),
      
    );
  }
  Widget movieCard(movie first,BuildContext context){
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left:60),
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 54),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Flexible(child: Text(first.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),)),
                  Text("Rating : ${first.imdbRating}/10",style: mainstyle() ,)],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Released : ${first.released}",style: mainstyle(),),
                      Text(first.runtime,style: mainstyle(),),
                      Text(first.rated,style: mainstyle(),)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieListViewDetails(movieName: first.title,first: first,)));
      },
    );
  }
  TextStyle mainstyle(){
    return TextStyle(fontSize: 10,color: Colors.white);
  }
  Widget movieImage(String movieimageurl){
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: NetworkImage(movieimageurl  ),fit: BoxFit.cover)
      ),
    );
  }

}
//New route
class MovieListViewDetails extends StatelessWidget {
  final String movieName;
  final movie? first; 
  const MovieListViewDetails({ Key? key,this.movieName=" ",this.first}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${this.movieName}"),
      backgroundColor: Colors.blueGrey,),
      body: ListView(
        children: [
          movieDetailsThumbnail(thumbnail: first!.images[1],),
          MovieDetailsHeaderwithPoster(first: first,),
          HorizontalLine(),
          MovieDetailsCast(first: first,),
          HorizontalLine(),
          MovieExtraPoster(posters: first!.images,)

        ],
      ),
      // body: Center(
      //   child: Container(
      //     child: ElevatedButton(onPressed: (){
      //       Navigator.pop(context);
      //     }, child: Text("go back")),
      //   ),
      // ),
    );
  }
}

class homie extends StatefulWidget {
  const homie({ Key? key }) : super(key: key);

  @override
  State<homie> createState() => _homieState();
}

class _homieState extends State<homie> {
  bool userIsloggedIN = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserLoggedIN();
  }
  getuserLoggedIN()async{
    await HelperFunctions.getuserLoggedInToSharedPreference().then((value){
      setState(() {
        userIsloggedIN = value!;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text("All apps")
      ),
      body : SingleChildScrollView(
        child: Container(alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              TextButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: ((context) => board_App())));
              }, child: Text("Comunity Board"),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),),
              SizedBox(height: 50,),
              TextButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: ((context) => Camera_access())));
              }, child: Text("Camera access"),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),),
              SizedBox(height: 50,),
              TextButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: ((context) => MovieListView())));
              }, child: Text("Movie List"),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),),
              SizedBox(height: 50,),
              TextButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: ((context) => tipCalc())));
              }, child: Text("Tip calculator"),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),),
              SizedBox(height: 50,),
              TextButton(onPressed: (){
                if(userIsloggedIN){
                  Navigator.push(context,MaterialPageRoute(builder: ((context) => chat_room())));
                }
                else{
                  Navigator.push(context,MaterialPageRoute(builder: ((context) => chat_app_sign_in())));
                }
              }, child: Text("Chat app"),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),),
              
            ],),
          ),
        ),
      )
      
    );
  }
}
