# Splash Screen

* A small splash screen package used to easily add an intro to any Flutter application.

## For iOS And Android 

* It is now Very Simple and Easy to Use 
* Coming Soon: Will add better functionality 
* Any questions regarding the plugin to monkey4gamesmmm@gmail.com


<<<<<<< HEAD
### ScreenShot
![screenshot description (alt)](screenshot.png)
=======
### Screenshot
![Screenshot](screenshot.png)
>>>>>>> 99e44d4c09a0f400e260e68f7c20ba16af00f2c7

## Usage

[Example](https://github.com/KarimMohamed2005/SplashScreenFlutterPackage/blob/master/example/example.dart)

To use this package:

* add the `splashscreen` dependency to your [pubspec.yaml](https://github.com/KarimMohamed2005/SplashScreenFlutterPackage/blob/master/pubspec.yaml) file.

```yaml
  dependencies:
    flutter:
      sdk: flutter
      
    splashscreen: ^0.0.6
```

### How to use


<<<<<<< HEAD
``` dart
      new SplashScreen(
      seconds: 14,
      navigateAfterSeconds: new AfterSplash(),
      title: new Text('Welcome In SplashScreen'),
      image: new Image.asset('screenshot.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.red
=======
```dart
      SplashScreen(
        seconds: 14,
        navigateAfterSeconds: AfterSplash(),
        title: Text('Welcome In SplashScreen'),
        imageNetwork: 'https://i.imgur.com/TyCSG9A.png',
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.red,
>>>>>>> 99e44d4c09a0f400e260e68f7c20ba16af00f2c7
    );
```

## Example
``` dart

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
void main(){
<<<<<<< HEAD
  runApp(
    new MaterialApp(
    home: new MyApp(),
=======
  runApp(MaterialApp(
    home: MyApp(),
>>>>>>> 99e44d4c09a0f400e260e68f7c20ba16af00f2c7
  ));
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 14,
      navigateAfterSeconds: AfterSplash(),
      title: Text('Welcome In SplashScreen',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0
      ),),
      image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.red
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return new Scaffold(
      appBar: new AppBar(
      title: new Text("Welcome In SplashScreen Package"),
      automaticallyImplyLeading: false
=======
    return Scaffold(
      appBar: AppBar(
      title: Text("Welcome In SplashScreen Package")
>>>>>>> 99e44d4c09a0f400e260e68f7c20ba16af00f2c7
      ),
      body: Center(
        child: Text("Succeeded!",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0
        ),),

      ),
    );
  }
}
```
