import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/game_state.dart';

typedef PositionCallback = Future Function(Offset pos);

class BirdNode extends Node {

  BirdNode({ this.size, this.color, this.pos, this.posEvent });

  double size;
  Color color;
  Offset pos;
  Offset vel = Offset(0.0, 0.0);
  PositionCallback posEvent;

  @override
  void paint(Canvas canvas) {
    canvas.drawCircle(pos, size, Paint()..color = color);
  }

  @override
  void update(double dt) {
    super.update(dt);
    vel = vel.translate(0.0, GameState().regularize(GameState().gravity, Axis.vertical));
    pos = pos.translate(vel.dx, vel.dy);
    if (pos.dx <= 0 || pos.dx >= GameState().windowSize.width) {
      vel = Offset(0.0, 0.0);
      endGame(pos);
    }
  }

}
