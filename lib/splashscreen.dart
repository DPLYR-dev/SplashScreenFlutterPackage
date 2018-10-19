library splashscreen;

import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget title;
  final Color backgroundColor;
  final double photoSize;
  final dynamic onClick;
  final Color loaderColor;
  final Image image;
  final Widget loading;
  final ImageProvider backgroundImage;
  final Future<dynamic> navigateTo;

  SplashScreen({
    this.loaderColor,
    this.photoSize,
    this.onClick,
    this.title,
    this.backgroundColor = Colors.white,
    this.image,
    this.loading,
    this.backgroundImage,
    @required this.navigateTo,
  });

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    widget.navigateTo.then((to) {
      if (to is String) {
        // It's fairly safe to assume this is using the in-built material
        // named route component
        return Navigator.of(context).pushReplacementNamed(to);
      } else if (to is Widget) {
        return Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (BuildContext context) => to));
      } else {
        throw new ArgumentError(
            'widget.navigateAfterSeconds must either be a String or Widget');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: new InkWell(
        onTap: widget.onClick,
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Container(
              decoration: widget.backgroundImage != null
                  ? new BoxDecoration(
                      image: new DecorationImage(
                        image: widget.backgroundImage,
                        fit: BoxFit.cover,
                      ),
                    )
                  : BoxDecoration(color: widget.backgroundColor),
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
                          child: widget.image,
                        ),
                        radius: widget.photoSize,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                      widget.title ?? Container(),
                    ],
                  )),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            widget.loaderColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                      ),
                      widget.loading != null ? widget.loading : Container(),
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
