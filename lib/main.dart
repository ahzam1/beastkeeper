import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
      home: MyBeasts(title: 'Flutter Demo Home Page'),
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
  //to be used for the carousel counter
  var counter = [0,1,2];
  var beasts = ["Ruff", "Meowth", "Spark"];
  var ages = ["4", "11", "9"];
  var images = [new AssetImage("assets/dog.jpg"), new AssetImage("assets/cat.jpg"),new AssetImage("assets/golden.jpg")];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[CarouselSlider(
          height: MediaQuery.of(context).size.height *.90,
          items: counter.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal:7.5),
                  decoration: BoxDecoration(
                    
                  ),
                  child:Stack(
                  
                  children: <Widget>[

                    new ShaderMask(
                          
                          child: Image(
                            height: MediaQuery.of(context).size.height,
                            image: images[i],
                            fit: BoxFit.cover,
                          ),
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              begin:Alignment.topCenter,
                              end:Alignment.bottomCenter,
                              colors: [Colors.white.withOpacity(0), Colors.black.withOpacity(0.9)],
                              stops: [
                                0.8,
                                1,
                              ],
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.srcATop,
                        ),

                  
                  new Positioned(
                    bottom: 4.0, 
                    left: 10.0,
                    child: RichText(
                      text:TextSpan(
                        text:beasts[i] + ', ',
                        style: TextStyle(fontSize:32.0),
                        children: <TextSpan>[
                          TextSpan(text: ages[i], style: TextStyle(fontSize: 20, color: Colors.white70)),
                        ]
                      )
                    ,)
                  ),],
                )
                );
              },
            );
          }).toList(),
        )],
      )
    ),
    );
  }
}
