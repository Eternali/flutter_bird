import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/nodes/main_game.dart';

class GameWidget extends StatefulWidget {

  GameWidget();

  State<GameWidget> createState() =>  _GameWidgetState();

}

class _GameWidgetState extends State<GameWidget> {

  // MainGameNode _mainNode;

  @override
  void initState() {
    super.initState();
    gameObservable.addListener(() => setState(() {}));
    // _mainNode = MainGameNode(size: widget.size);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SpriteWidget(MainGameNode(endGame: () => GameState().status = GameStatus.OVER)),
        GameState().status == GameStatus.PLAYING ? Container() : Center(
          child: RaisedButton(
            padding: EdgeInsets.all(8.0),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              gameObservable.value = GameState.copyWith(status: GameStatus.PLAYING);
            },
            child: Text(
              'Play Game',
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 32.0),
            ),
          ),
        ),
      ]
    );
  }

}
