import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/game_state.dart';

class PipeNode extends Node {

  PipeNode({ @required this.height, this.width = 20.0, this.color = Colors.green }) {
    top = Rect.fromLTWH(gameObservable.value.regularize(x), gameObservable.value.regularize(1.0), width, gameObservable.value.regularize(height))
  }

  double height;
  double width;
  Color color;
  double x = 1.0;

  Rect top;
  Rect bottom;

  bool hasCollided(Offset pos) {

  }

  @override
  void paint(Canvas canvas) {
    canvas.drawRect(top, Paint()..color = color);
    canvas.drawRect(bottom, Paint()..color = color);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

}
