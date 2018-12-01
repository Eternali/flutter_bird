import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/game_state.dart';

class PipeNode extends Node {

  PipeNode({ @required this.middle, @required this.height, this.width = 0.25, this.color = Colors.green }) {
    x = 1.0;
    lastX = x;
  }

  double middle;
  double height;
  double width;
  Color color;
  double x;
  double lastX;

  bool collidesWith(Offset pos, double rad) =>
    x < pos.dx + rad && x + width > pos.dx - rad && (
      pos.dy + rad >= middle + height / 2 ||
      pos.dy - rad <= middle - height / 2
    );

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
      lastX = x;
      x -= gs.speed;
    }
  }

}
