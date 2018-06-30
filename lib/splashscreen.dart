library splashscreen;
import 'dart:async';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  final Timer timer;
  final String imageNetwork;
  final Text title;
  final Color backgroundColor;
  final TextStyle styleTextUnderTheLoader;
  SplashScreen(
      {
        @required this.timer,
        this.imageNetwork,
        this.title = const Text('Welcome In Our App'),
        this.backgroundColor = Colors.white,
        this.styleTextUnderTheLoader = const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black
        )
      }
      );
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    widget.timer;
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
                      children: <Widget>[//              currentAccountPicture: new Image.network("https://scontent.faly2-1.fna.fbcdn.net/v/t1.0-9/33992593_219597895500862_5208963592451260416_n.jpg?_nc_cat=0&oh=8441e4efe43eb170b9f543d86e177724&oe=5BB96764"),
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
                    CircularProgressIndicator(),
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
