# Splash Screen

* A small splash screen package used to easily add an intro to any Flutter application.

## For iOS And Android 

* It is now Very Simple and Easy to Use 
* Coming Soon: Will add better functionality 
* Any questions regarding the plugin to monkey4gamesmmm@gmail.com


### Screenshot
![Screenshot](screenshot.png)

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
    );
```

## Example
```dart

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
void main(){
  runApp(MaterialApp(
    home: MyApp(),
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
      imageNetwork: 'https://i.imgur.com/TyCSG9A.png',
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
    return Scaffold(
      appBar: AppBar(
      title: Text("Welcome In SplashScreen Package")
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
