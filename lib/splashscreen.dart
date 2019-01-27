library splashscreen;
import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final int seconds;
  final Text title;
  final Color backgroundColor;
  final TextStyle styleTextUnderTheLoader;
  final dynamic navigateAfterSeconds;
  final double photoSize;
  final dynamic onClick;
  final Color loaderColor;
  final Image image;
  final Text loadingText;
  final ImageProvider imageBackground;
  final Gradient gradientBackground;
  SplashScreen(
      {
        this.loaderColor,
        @required this.seconds,
        this.photoSize,
        this.onClick,
        this.navigateAfterSeconds,
        this.title = const Text(''),
        this.backgroundColor = Colors.white,
        this.styleTextUnderTheLoader = const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
        this.image,
        this.loadingText  = const Text(""),
        this.imageBackground,
      	this.gradientBackground
      }
      );


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: widget.seconds),
            () {
          if (widget.navigateAfterSeconds is String) {
            // It's fairly safe to assume this is using the in-built material
            // named route component
            Navigator.of(context).pushReplacementNamed(widget.navigateAfterSeconds);
          } else if (widget.navigateAfterSeconds is Widget) {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => widget.navigateAfterSeconds));
          } else {
            throw new ArgumentError(
                'widget.navigateAfterSeconds must either be a String or Widget'
            );
          }
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new InkWell(
        onTap: widget.onClick,
        child:new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: widget.imageBackground == null
                    ? null
                    : new DecorationImage(
                        fit: BoxFit.cover,
                        image: widget.imageBackground,
                      ),
                gradient: widget.gradientBackground,
                color: widget.backgroundColor,
              ),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  flex: 2,
                  child: new Container(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: new Container(
                                child: widget.image
                            ),
                            radius: widget.photoSize,
                          ),
                          new Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                          ),
                          widget.title
                        ],
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(widget.loaderColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                      ),
                      widget.loadingText
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
