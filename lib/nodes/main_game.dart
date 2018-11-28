import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/nodes/bird.dart';
import 'package:flutter_bird/nodes/pipe.dart';

class MainGameNode extends  NodeWithSize {

  MainGameNode({ Size size, VoidCallback endGame }): super(size ?? gs.windowSize) {
    userInteractionEnabled = true; // enable touch events
    player = BirdNode(
      size: 0.04,
      color: Color(0xff009999),
      pos: Offset(-0.5, 0.5),
      jumpSpeed: 0.05,
      posEvent: (Offset pos) {
        if (pos.dy <= -1.0 || pos.dy >= 1.0) {
          endGame();
        }
        if (pipes.any((pipe) => pipe.collidesWith(pos, 15.0))) {
          endGame();
        }
      },
    );
    addChild(player);

    spawnPipe();
  }

  BirdNode player;
  double counter = 0;
  List<PipeNode> pipes = [];

  void spawnPipe() {
    pipes.add(PipeNode(
      middle: (randomDouble() - 0.5) * 1.5,
      height: randomDouble() * 0.5 + 0.25
    ));
    addChild(pipes.last);
  }

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

    if (gs.status == GameStatus.PLAYING) {
      pipes.removeWhere((pipe) {
        final remove = pipe.x + pipe.width <= -1;
        if (remove) removeChild(pipe);
        return remove;
      });

      counter += dt;
      if(counter >= gs.pipeFreq) {
        spawnPipe();
        counter = 0;
      }
    }
  }

}