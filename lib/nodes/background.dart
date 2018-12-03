import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/game_state.dart';

class BackgroundNode extends Node {

  BackgroundNode({ this.color = Colors.blueGrey });

  Color color;
  List<Offset> points = [];

  @override
  void paint(Canvas canvas) {
    canvas.drawArc(
      Rect.fromLTRB(0, gs.windowSize.height / 2, gs.windowSize.width, gs.windowSize.height),
      0, pi, true, Paint()..color = color);
  }

  @override
  void update(double dt) {
    super.update(dt);

    
  }

}
