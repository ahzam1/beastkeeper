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
  var counter = [1,2,3];
  var beasts = ["Ruff", "Tabitha", "Spark"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[CarouselSlider(
          height: MediaQuery.of(context).size.height *.9,
          items: counter.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.amber
                  ),
                  child: Text('text $i', style: TextStyle(fontSize: 16.0),)
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
