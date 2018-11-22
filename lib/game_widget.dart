import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/nodes/main_game.dart';

class GameWidget extends StatefulWidget {

  GameWidget();

  State<GameWidget> createState() =>  _GameWidgetState();

}

class _GameWidgetState extends State<GameWidget> {

  // MainGameNode _mainNode;

  // @override
  // void initState() {
  //   super.initState();
  //   _mainNode = MainGameNode(size: widget.size);
  // }

  @override
  Widget build(BuildContext context) {
    return SpriteWidget(MainGameNode());
  }

}
