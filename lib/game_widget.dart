import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/intents.dart';
import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/nodes/main_game.dart';
import 'package:flutter_bird/widgets/game_overlay.dart';

class GameWidget extends StatefulWidget {

  State<GameWidget> createState() =>  _GameWidgetState();

}

class _GameWidgetState extends State<GameWidget> {

  // This must be initialized outside of the build method.
  final _mainNode = MainGameNode(endGame: Intents.endGame);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SpriteWidget(_mainNode),
        GameOverlay(),
      ]
    );
  }

}
