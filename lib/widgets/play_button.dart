import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/data/intents.dart';

class PlayButton extends StatefulWidget {

  PlayButton({ this.statusStream });

  final Stream<GameStatus> statusStream;

  @override
  State<PlayButton> createState() => _PlayButtonState();

}

class _PlayButtonState extends State<PlayButton> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation _exitAnim;

  void updateVisibility(status) {
    if (
      status == GameStatus.PLAYING &&
      [ AnimationStatus.dismissed, AnimationStatus.reverse ].contains(_controller.status)
    ) {
      _controller.forward();
    } else if (
      [ GameStatus.OVER, GameStatus.START ].contains(status) &&
      [ AnimationStatus.completed, AnimationStatus.forward ].contains(_controller.status)
    ) {
      _controller.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    _exitAnim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.statusStream,
      builder: (BuildContext context, AsyncSnapshot<GameStatus> status) {
        updateVisibility(status.data);
        return AnimatedBuilder(
          animation: _exitAnim,
          builder: (BuildContext context, Widget child) => Container(
            transform: Matrix4.translation(Vector3(0, _exitAnim.value * MediaQuery.of(context).size.height, 0)),
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
        );
      }
    );
  }

}
