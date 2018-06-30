# Splash Screen

* A small Splash Screen used for an intro for any flutter application easily using

## For iOS And Android 

* It 's Now Very Simple And Easy To Use 
* Coming Soon Will Add A Greater Functions 
* For Any information Send Message To Me On => monkey4gamesmmm@gmail.com


### ScreenShot
<img src="screenshot.png" height="300et">

## Usage

[Example](https://github.com/KarimMohamed2005/SplashScreenFlutterPackage/blob/master/example/example.dart)

To use this package :

* add the dependency to your [pubspec.yaml](https://github.com/KarimMohamed2005/SplashScreenFlutterPackage/blob/master/pubspec.yaml) file.

```yaml
  dependencies:
    flutter:
      sdk: flutter
    splashscreen:
```

### How to use


``` dart
      new SplashScreen(
      timer: Timer(Duration(seconds: 12),(){Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new AfterLogin()),);}),
      title: new Text('Welcome In SplashScreen'),
      imageNetwork: 'https://i.imgur.com/TyCSG9A.png',
      loaderColor: Colors.blue,
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle()
    );
```

## Example
```dart

import 'dart:async';
import 'package:flutter/material.dart';
void main(){
  runApp(new MaterialApp(
    home: MyApp(),
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
      timer: Timer(Duration(seconds: 12), (){
      Navigator.of(context).push(
      new MaterialPageRoute(
      builder: (BuildContext context) => new AfterLogin()),
      );
      }
    ),
      title: new Text('Welcome In SplashScreen'),
      imageNetwork: 'https://i.imgur.com/TyCSG9A.png',

    );
  }
}

class AfterLogin extends StatelessWidget {
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

```
