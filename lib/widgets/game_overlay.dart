import 'package:flutter/material.dart';

import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/data/intents.dart';

class GameOverlay extends StatefulWidget {

  @override
  State<GameOverlay> createState() => _GameOverlayState();

}

class _GameOverlayState extends State<GameOverlay> {

  @override
  void initState() {
    super.initState();
    gameObservable.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        gs.status == GameStatus.PLAYING ? Container() : Center(
          child: RaisedButton(
            padding: EdgeInsets.all(8.0),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Intents.startGame();
            },
            child: Text(
              'Play Game',
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 32.0),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            padding: const EdgeInsets.only(top: 4, left: 8),
            child: Text(
              gs.score.toString(),
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 28.0),
            ),
          ),
        ),
      ],
    );
  }

}
