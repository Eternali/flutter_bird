import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/widgets/final_score.dart';
import 'package:flutter_bird/widgets/play_button.dart';

class GameOverlay extends StatefulWidget {

  State<GameOverlay> createState() => _GameOverlayState();

}

class _GameOverlayState extends State<GameOverlay> {

  StreamController<GameStatus> _statusController = StreamController.broadcast();

  int _oldStatus; // use index so it's copied by value, not reference
  int _oldScore;

  void updateState() {
    if (gs.status.index != _oldStatus) {
      _statusController.add(gs.status);
      _oldStatus = gs.status.index;
    }
    if (gs.score != _oldScore) {
      setState(() {
        _oldScore = gs.score;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    gameObservable.addListener(updateState);
  }

  @override
  void dispose() {
    gameObservable.removeListener(updateState);
    _statusController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
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
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FinalScore(statusStream: _statusController.stream.asBroadcastStream()),
                PlayButton(statusStream: _statusController.stream.asBroadcastStream()),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
