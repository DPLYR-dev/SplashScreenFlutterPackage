# Splash Screen
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors)

* A small Splash Screen used for an intro for any flutter application easily using

## For iOS And Android 

* It 's Now Very Simple And Easy To Use 
* Coming Soon Will Add A Greater Functions 
* For Any information Send Message To Me On => karimmohamed200510@gmail.com


### ScreenShot
![screenshot description (alt)](screenshot.png)

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
      seconds: 14,
      navigateAfterSeconds: new AfterSplash(),
      title: new Text('Welcome In SplashScreen'),
      image: new Image.asset('screenshot.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.red
    );
```

## Example
``` dart

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
      navigateAfterSeconds: new AfterSplash(),
      title: new Text('Welcome In SplashScreen',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0
      ),),
      image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.red
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
      title: new Text("Welcome In SplashScreen Package"),
      automaticallyImplyLeading: false
      ),
      body: new Center(
        child: new Text("Done!",
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0
        ),),

      ),
    );
  }
}
```

## Contributors

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<table><tr><td align="center"><a href="https://github.com/ahmedmgh67"><img src="https://avatars2.githubusercontent.com/u/37451499?v=4" width="100px;" alt="Ahmed Gamal"/><br /><sub><b>Ahmed Gamal</b></sub></a><br /><a href="#infra-ahmedmgh67" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="https://github.com/KarimMohamed2005/SplashScreenFlutterPackage/commits?author=ahmedmgh67" title="Tests">⚠️</a> <a href="https://github.com/KarimMohamed2005/SplashScreenFlutterPackage/commits?author=ahmedmgh67" title="Code">💻</a></td></tr></table>

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!