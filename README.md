# [Splash Screen](https://pub.dev/packages/splashscreen)

* A splashscreen package to be used for an intro for any flutter application easily with a lot of customization

## Currently Supported by awesome [DPLYR](https://dplyr.dev)

![image (alt)](https://i.imgur.com/D1WG1Bo.png&s=50)

* [DPLYR](https://dplyr.dev) is a new generation of cloud platforms and aims to help developers in their road with open source contributions, and at the end we can say thanks.

## Screenshots

![screenshot description (alt)](screenshot.png)

## Usage

[Example](https://github.com/KarimMohamed2005/SplashScreenFlutterPackage/blob/master/example/example.dart)

To use this package :

* add the dependency to your [pubspec.yaml](https://github.com/KarimMohamed2005/SplashScreenFlutterPackage/blob/master/pubspec.yaml) file.

```yaml
  dependencies:
    flutter:
      sdk: flutter
    splashscreen: ^1.3.5
```

### How to use

``` dart
new SplashScreen.timer(
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

As time based...

``` dart
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen.timer(
      seconds: 14,
      navigateAfterSeconds: AfterSplash(),
      title: Text(
        'Welcome In SplashScreen',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image.network(
        'https://flutter.io/images/catalog-widget-placeholder.png',
      ),
      backgroundColor: Colors.white,
      loaderColor: Colors.red,
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome In SplashScreen Package'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text(
          'Succeeded!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
      ),
    );
  }
}
```

As future based...

``` dart
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

Future<Widget> loadFromFuture() async {
  // <fetch data from server. ex. login>
  return AfterSplash();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen.future(
      navigateAfterFuture: loadFromFuture(),
      navigateAfterSeconds: AfterSplash(),
      title: Text(
        'Welcome In SplashScreen',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image.network(
        'https://flutter.io/images/catalog-widget-placeholder.png',
      ),
      backgroundColor: Colors.white,
      loaderColor: Colors.red,
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome In SplashScreen Package'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text(
          'Succeeded!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
      ),
    );
  }
}
```

### Animate the main image with the hero animation

The main image has this tag attached to it `splashscreenImage`. Add it to whatever page you'll navigate to. This will animate the main Image to the same image you put in another page

### Adding a custom page tranistion

You can use the `pageRoute` to do just this. Here's an example

```dart
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AfterSplash(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen.timer(
      seconds: 14,
      navigateAfterSeconds: AfterSplash(),
      title: Text(
        'Welcome In SplashScreen',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image.network(
        'https://flutter.io/images/catalog-widget-placeholder.png',
      ),
      backgroundColor: Colors.white,
      loaderColor: Colors.red,
      pageRoute: _createRoute(),
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome In SplashScreen Package'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text(
          'Succeeded!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
      ),
    );
  }
}
```

### All Supported Projects by [DPLYR](https://dplyr.dev)

* [Splash Screen - Flutter](https://github.com/DPLYR-dev/SplashScreenFlutterPackage)
  <br> a flutter package created to show simple splashscreen

* [In App Call Alert - Flutter](https://github.com/DPLYR-dev/InAppCallAlert)
  <br> a flutter package created to show call alert with sound

* [File Manager](https://github.com/DPLYR-dev/file-manager)
  <br> a php project created to manage machines/servers through ftp servers
  
* [Countries Js](https://github.com/DPLYR-dev/file-manager)
  <br> a javascript project created for retrieving country details with flexibility.
  
* [Block temp mails](https://github.com/DPLYR-dev/block-temp-emails)
  <br> a javascript api to prevent temporary emails from signing up on your website. Super easy to use
  
* [Disposable Emails List](https://github.com/DPLYR-dev/disposable-emails-list-domains-spam)
  <br> a python script to generate the temporary and spam doamins to prevent them and you can block them through this API [Block temp mails](https://github.com/DPLYR-dev/block-temp-emails)

* [Basic CRM](https://github.com/DPLYR-dev/basic-crm)
  <br> A crm that is developed with Node Js for entreprenurs who need a basic CRM with text replacment feature
  
* [Basic Finance](https://github.com/DPLYR-dev/basic-finance)
  <br> A finance that is developed with Node Js

### About DPLYR

[DPLYR](https://www.dplyr.dev) is a SaaS tool that helps developers just like you to deploy their web apps more easily. It supports deploying Node.js apps with MongoDB, MySQL or PostgreSQL databases all for free. Go now  to [www.dplyr.dev](https://www.dplyr.dev) and create a free account.

### Created by [Karim Mohamed](https://github.com/KarimMohamed20)
