import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/game_state.dart';

class PipeNode extends Node {

  PipeNode({ @required this.middle, @required this.height, this.width = 20.0, this.color = Colors.green });

  double middle;
  double height;
  double width;
  Color color;
  double x = 1.0;

  bool hasCollided(Offset pos) {

  }

  @override
  void paint(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(gs.r(x), gs.r(1.0), width, gs.r(middle + height / 2)),
      Paint()..color = color
    );
    canvas.drawRect(
      Rect.fromLTWH(gs.r(x), gs.r(middle - height / 2), width, gs.r(-1.0)),
      Paint()..color = color
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gs.status == GameStatus.PLAYING) {
      x -= gs.speed;
    }
  }

}
