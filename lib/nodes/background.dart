import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/game_state.dart';

class BackgroundNode extends Node {

  BackgroundNode({ this.color = Colors.blueGrey }) {
    points.addAll([
      Offset(1, -1),
      Offset(-1, -1),
      Offset(-1, randomSignedDouble() * 0.5)
    ]);
    generatePoint(40);
    print(points);
  }

  Color color;
  final pointInterval = 0.05;
  final slope = 0.05;
  List<Offset> points = [];

  void generatePoint(int numPoints) {
    for (var n = 0; n < numPoints; n++) {
      points.add(Offset(points.last.dx + pointInterval, points.last.dy + randomSignedDouble() * slope));
    }
    final before = points.length;
    points.removeWhere((point) => point.dx < -1);
    final removed = before - points.length;
    points.forEach((point) {
      point.translate(-removed * pointInterval, 0);
    });
  }

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(
      Path()..addPolygon(points.map((p) => Offset(gs.bx(p.dx), gs.by(p.dy))).toList(), true),
      Paint()
        ..style = PaintingStyle.fill
        ..color = color
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gs.status == GameStatus.PLAYING) {
      points.forEach((point) {
        point.translate(-gs.speed, 0);
      });
    }
  }

}
