library splashscreen;
import 'dart:async';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  final int seconds;
  final String imageNetwork;
  final Text title;
  final Color backgroundColor;
  final TextStyle styleTextUnderTheLoader;
  final Color loaderColor;
  final Widget navigate;
  SplashScreen(
      {
        @required this.seconds,
        this.navigate,
        this.imageNetwork,
        this.title = const Text('Welcome In Our App'),
        this.backgroundColor = Colors.white,
        this.styleTextUnderTheLoader = const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
        this.loaderColor = Colors.blue
      }
      );
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: widget.seconds), ()=>Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> widget.navigate)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: new Container(
                            child: new Image.network(
                              widget.imageNetwork,
                              width: 110.0,
                              height: 110.0,
                            ),
                          ),
                          radius: 60.0,
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
                      backgroundColor: widget.loaderColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    Text("Loading",style: widget.styleTextUnderTheLoader
                    ),
                    new Center(
                      child: Text("Now",style: widget.styleTextUnderTheLoader
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
