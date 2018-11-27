import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/nodes/bird.dart';
import 'package:flutter_bird/nodes/pipe.dart';

class MainGameNode extends  NodeWithSize {

  MainGameNode({ Size size, VoidCallback endGame }): super(size ?? gs.windowSize) {
    userInteractionEnabled = true; // enable touch events
    player = BirdNode(
      size: 15.0,
      color: Color(0xff009999),
      pos: gs.globalOffset(Offset(-0.5, 0.5)),
      jumpSpeed: 5.0,
      posEvent: (Offset pos) {
        if (pos.dy <= 0 || pos.dy >= gs.windowSize.height) {
          endGame();
        }
      },
    );
    pipes.add(PipeNode(
      middle: 0.0,
      height: 0.5
    ));

    addChild(player);
    addChild(pipes[0]);
  }

  BirdNode player;
  List<PipeNode> pipes = [];

  @override
  bool handleEvent(SpriteBoxEvent event) {
    if (event.type == PointerDownEvent) {
      player.jump();
    }

    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

}