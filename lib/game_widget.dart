import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/intents.dart';
import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/nodes/main_game.dart';
import 'package:flutter_bird/widgets/play_button.dart';

class GameWidget extends StatefulWidget {

  GameWidget();

  State<GameWidget> createState() =>  _GameWidgetState();

}

class _GameWidgetState extends State<GameWidget> {

  // This must be initialized outside of the build method.
  final _mainNode = MainGameNode(endGame: Intents.endGame);

  void update() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    gameObservable.addListener(update);
  }

  @override
  void dispose() {
    gameObservable.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SpriteWidget(_mainNode),
        PlayButton(),
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
      ]
    );
  }

}
