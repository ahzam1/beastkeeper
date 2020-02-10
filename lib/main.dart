import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeastKeeper Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyBeasts(title: 'My Beasts'),
    );
  }
}

class MyBeasts extends StatefulWidget {
  MyBeasts({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyBeastsState createState() => _MyBeastsState();
}

class _MyBeastsState extends State<MyBeasts> {
  //to be used to hold all expanded animals.
  var expanded = [];
  //to be used for the carousel counter
  var counter = [0,1,2];
  var beasts = ["Ruff", "Meowth", "Spark"];
  var ages = ["4", "11", "9"];
  var lipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris dignissim, magna vitae consectetur convallis, ipsum arcu egestas ante, ac semper nisl erat in dolor. Sed facilisis molestie odio, vitae laoreet lorem aliquet quis.";
  var images = [new AssetImage("assets/dog.jpg"), new AssetImage("assets/cat.jpg"),new AssetImage("assets/golden.jpg")];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(
      //safe area to avoid rendering below status bars as some phones have notches.
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[
          
          Text("My Beasts", style:TextStyle(color: Colors.black, fontSize: 30)),
          const SizedBox(height:15),
          //carousel slider to implemenet the scrolling cards, external package.
          CarouselSlider(
          height: MediaQuery.of(context).size.height *.85,
          items: counter.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal:7.5),
                  child:Stack(
                  //stack to create the layout of the cards
                  children: <Widget>[

                  new ShaderMask( 
                    // helps to create the slight vignette effect at the bottom. 
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image(
                          //image of the pet.
                          height: MediaQuery.of(context).size.height,
                          image: images[i],
                          fit: BoxFit.cover,
                        ),
                    ),
                          
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin:Alignment.topCenter,
                        end:Alignment.bottomCenter,
                        colors: [Colors.white.withOpacity(0), Colors.black.withOpacity(0.9)],
                        stops:[0.8,1], //start basically just a bit off the bottom and end at the bottom.
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                  ),

                  new AnimatedPositioned(
                    //animated for interaction, didn't want popups/new screens.
                    duration: Duration(milliseconds:400),
                    bottom:expanded.contains(i) ? 0 :-291,
                    left:0,
                    child: Container(
                      height: 290,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.black.withOpacity(.8)),
                      child:Stack(
                        children: <Widget>[
                        Positioned(
                          //animal details
                          left: 15,
                          top: 50,
                          width:MediaQuery.of(context).size.width *.66,
                          child: Text(lipsum, style:TextStyle(color: Colors.white, fontSize: 20),),
                        ),
                        Positioned(
                          //interaction buttons
                          bottom: 10,
                          right:110,
                          child:Row(
                            //used a row to put them alll in a nice neat row.
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            //gesture detectors because I initialyl wanted to be able to add longpress functions, but didn't have time to.
                            GestureDetector(
                              onTap: () => _openMaps(),
                              child: Image(image: AssetImage('assets/doctor.png'), height:35),
                            ),
                            const SizedBox(width:13),
                            GestureDetector(
                              onTap: () => _openCamera(i),
                              child: Image(image: AssetImage('assets/camera.png'), height:35),
                            ),
                            const SizedBox(width:13),
                            GestureDetector(
                              onTap: () => _editAnimal(i),
                              child: Image(image: AssetImage('assets/edit.png'), height:35),
                            ),
                        ] ,)
                        ,)
                      ],)
                    )
                  ),
                  new AnimatedPositioned(
                    duration: Duration(milliseconds: 400),
                    bottom:expanded.contains(i) ? 250 :8.0,
                    right:8,
                    child:GestureDetector(
                        onTap: () => _expandDetails(i),
                        child: AnimatedCrossFade(
                          //cross fade to alternate between the i and the x icon.
                          duration: Duration(milliseconds: 400),
                          firstChild:Image(
                                height: 36,
                                image: new AssetImage("assets/info.png"),
                              ),
                          secondChild: Image(
                                height: 36,
                                image: new AssetImage("assets/exit.png"),
                              ),
                          crossFadeState: expanded.contains(i) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                        )
                      ),
                  ),
                  new AnimatedPositioned(
                    //name and age at the bottom
                    duration: Duration(milliseconds: 400),
                    bottom: expanded.contains(i) ? 250 :8.0, 
                    left: 12.0,
                    child: RichText(
                      //using rich text for styling the age differently.
                      text:TextSpan(
                        text:beasts[i] + ', ',
                        style: TextStyle(fontSize:32.0),
                        children: <TextSpan>[
                          TextSpan(text: ages[i], style: TextStyle(fontSize: 20, color: Colors.white70)),
                        ]
                      )
                    ,)
                  ),
                  ],
                ),
                );
              },
            );
          }).toList(),
        )],
      )
    ),
    );
  }

  void _expandDetails(int id){
    //need to set state here to expand id'th animal details section.
    // this works since build is recalled whenever state is updated.
    if(expanded.contains(id)){
      //remove it from the list
      setState(() {
        expanded.remove(id);
      });
    } else{
      // expand it.
      setState(() {
        expanded.add(id);
      });
    } 
  }
  void _openMaps() async{
    //function to open google maps with the search query 'vets near me'
    const url = 'https://www.google.com/maps/search/?api=1&query=vets+near+me';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch maps.';
    }
  }
  void _openCamera(int id){
    // stub function for now due to time restrictions
    debugPrint("Take a picture for animal id: " + id.toString());
  }
  void _editAnimal(int id){
    // stub function for now due to time restrictions
    debugPrint("Edit details for animal id: " + id.toString());
  }
}
