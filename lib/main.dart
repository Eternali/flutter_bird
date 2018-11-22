import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bird/data/fb_state.dart';
import 'package:flutter_bird/data/provider.dart';
import 'package:flutter_bird/screens/HomeScreen.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(FlutterBird());
}

final routes = {
  '/': (context) => HomeScreen()
};

class FlutterBird extends StatefulWidget {

  FlutterBird() {
    state = FBStateObservable(FBState());
  }

   FBStateObservable state;

  @override
  State<FlutterBird> createState() => _FlutterBirdState();

}

class _FlutterBirdState extends State<FlutterBird> {

  @override
  Widget build(BuildContext context) {
    return Provider(
      state: widget.state,
      child: MaterialApp(
        title: 'Flutter bird',
        routes: routes,
      ),
    );
  }

}
