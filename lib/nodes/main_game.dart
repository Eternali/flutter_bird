import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/data/intents.dart';
import 'package:flutter_bird/nodes/bird.dart';
import 'package:flutter_bird/nodes/pipe.dart';
import 'package:flutter_bird/nodes/background.dart';
import 'package:flutter_bird/nodes/background_perlin.dart';

class MainGameNode extends  NodeWithSize {

  MainGameNode({ Size size, VoidCallback endGame }): super(size ?? gs.windowSize) {
    userInteractionEnabled = true; // enable touch events
    this.endGame = () {
      pipes.forEach((pipe) { removeChild(pipe); });
      pipes.clear();
      counter = gs.pipeFreq;
      endGame();
    };
    farBackground = BackgroundPerlinNode(color: Colors.blueGrey.withAlpha(150), parallax: 0.25, min: 0);
    background = BackgroundPerlinNode(max: 0.5);
    player = BirdNode(
      size: 0.04,
      color: Colors.amber, // Color(0xff009999),
      pos: Offset(-0.5, 0.5),
      jumpSpeed: 0.02,
      posEvent: (Offset pos, double rad) {
        if (pos.dy <= -1.0 || pos.dy >= 1.0) {
          this.endGame();
        }
        if (pipes.any((pipe) => pipe.collidesWith(pos, rad))) {
          this.endGame();
        }

        for (var pipe in pipes) {
          // if we just passed a pipe increment the score
          if (pipe.x + pipe.width < pos.dx - rad && pipe.lastX + pipe.width >= pos.dx - rad) {
            Intents.incScore();
            break;
          }
        }
      },
    );

    addChild(farBackground);
    addChild(background);
    addChild(player);
    spawnPipe();
  }

  BackgroundPerlinNode farBackground;
  BackgroundPerlinNode background;
  BirdNode player;
  double counter = 0;
  List<PipeNode> pipes = [];
  VoidCallback endGame;

  void spawnPipe() {
    pipes.add(PipeNode(
      middle: randomSignedDouble() * 0.75,
      height: randomDouble() * 0.25 + 0.35
    ));
    addChild(pipes.last);
  }

  @override
  bool handleEvent(SpriteBoxEvent event) {
    if (event.type == PointerDownEvent) {
      // print('jumping');
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