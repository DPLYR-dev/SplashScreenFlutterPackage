library splashscreen;
import 'dart:async';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  final int seconds;
  final String imageNetwork;
  final Text title;
  final Color backgroundColor;
  final TextStyle styleTextUnderTheLoader;
  final Widget navigateAfterSeconds;
  final double photoSize;
  final dynamic onClick;
  SplashScreen(
      {
        @required this.seconds,
        this.photoSize,
        this.onClick,
        this.navigateAfterSeconds,
        this.imageNetwork,
        this.title = const Text('Welcome In Our App'),
        this.backgroundColor = Colors.white,
        this.styleTextUnderTheLoader = const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
      }
      );


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: widget.seconds), ()=>Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> widget.navigateAfterSeconds)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: new InkWell(
        onTap: widget.onClick,
        child:new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Container(
              decoration: BoxDecoration(color: widget.backgroundColor),
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
                              child: new Image.network(
                                widget.imageNetwork,
                                height: 110.0,
                                width: 110.0,
                              ),
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
      ),
    );
  }
}
