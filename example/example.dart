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

  loadWidget() async{
    return await new Future<Widget>.delayed(
      Duration(
        seconds: 1
      ),() => AfterSplash()
    ) ;
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      title: new Text('Welcome In SplashScreen',
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0
        ),
      ),
      loadingData: loadWidget,
      image: new Image.network('https://flutter.io/images/catalog-widget-placeholder.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.red,
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcome In SplashScreen Package"),
        automaticallyImplyLeading: false,
        ),
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
