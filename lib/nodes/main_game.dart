import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/nodes/bird.dart';

class MainGameNode extends  NodeWithSize {

  final state = gameObservable.value;

  MainGameNode({ Size size, VoidCallback endGame }): super(size ?? gameObservable.value.windowSize) {
    player = BirdNode(
      size: 15.0,
      color: Color(0xff009999),
      pos: state.globalOffset(Offset(-0.5, 0.5)),
      posEvent: (Offset pos) {
        if (pos.dy <= 0 || pos.dy >= state.windowSize.height) {
          // vel = Offset(0.0, 0.0);
          endGame();
        }
      },
    );
    addChild(player);
  }

  BirdNode player;

  @override
  void update(double dt) {
    super.update(dt);
  }

}