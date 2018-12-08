import 'package:flutter/material.dart';

import 'package:flutter_bird/data/game_state.dart';

class FinalScore extends StatefulWidget {

  FinalScore({ this.statusStream });

  final Stream<GameStatus> statusStream;

  State<FinalScore> createState() => _FinalScoreState();

}

class _FinalScoreState extends State<FinalScore> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  CurvedAnimation _exitAnim;

  void updateVisibility(status) {
    if (
      status == GameStatus.PLAYING &&
      [ AnimationStatus.completed, AnimationStatus.forward ].contains(_controller.status)
    ) {
      _controller.reverse();
    } else if (
      [ GameStatus.OVER, GameStatus.START ].contains(status) &&
      [ AnimationStatus.dismissed, AnimationStatus.reverse ].contains(_controller.status)
    ) {
      _controller.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _exitAnim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
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
          builder: (BuildContext context, Widget child) => Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Text(
                  getHighScore(),
                ),
              ),
              Opacity(
                opacity: _exitAnim.value,
                child: Container(
                  padding: EdgeInsets.only(bottom: 32.0),
                  child: Text(
                    '${gs.score}',
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
