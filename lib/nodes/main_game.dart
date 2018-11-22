import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/nodes/bird.dart';

class MainGameNode extends  NodeWithSize {

  MainGameNode({ Size size, PositionCallback posEvent }): super(size ?? GameState().windowSize) {
    player = BirdNode(
      size: 15.0,
      color: Color(0xff009999),
      pos: GameState().globalOffset(Offset(-0.5, 0.5))
    );
    addChild(player);
  }

  BirdNode player;

  @override
  void update(double dt) {
    super.update(dt);
  }

}