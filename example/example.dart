import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
void main(){
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 14,
      navigate: new AfterSplash(),
      title: new Text('Welcome In SplashScreen',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0
      ),),
      imageNetwork: 'https://i.imgur.com/TyCSG9A.png',
      photoHeight: 110.0,
      photoWidth: 110.0,
      loaderColor: Colors.blue,
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoRadius: 60.0,
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Welcome In SplashScreen Package")),
      body: new Center(
        child: new Text("Succeeded!",
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0
        ),),

      ),
    );
  }
}
