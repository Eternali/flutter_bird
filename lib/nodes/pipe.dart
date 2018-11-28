import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/game_state.dart';

class PipeNode extends Node {

  PipeNode({ @required this.middle, @required this.height, this.width = 0.1, this.color = Colors.green });

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
      Rect.fromLTRB(gs.bx(x), gs.by(1.0), gs.bx(x + width), gs.by(middle + height / 2)),
      Paint()..color = color
    );
    canvas.drawRect(
      Rect.fromLTRB(gs.bx(x), gs.by(middle - height / 2), gs.bx(x + width), gs.by(-1.0)),
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
