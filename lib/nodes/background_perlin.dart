import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/util.dart';
import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/noise/perlin2.dart';

class BackgroundPerlinNode extends Node {

  BackgroundPerlinNode({ this.color = Colors.blueGrey, this.parallax = 0.75, this.min = -1, this.max = 1 }) {
    perlin = Perlin2(randomInt(100000));
    points.addAll([
      Offset(1, -1),
      Offset(-1, -1),
      Offset(-1, remap(perlin.noise(0, perlinPos), -1, 1, min, max))
    ]);
    generatePoint((2 / pointInterval).ceil());
  }

  double min, max;
  Color color;
  Perlin2 perlin;
  double perlinPos = 0;
  double parallax;
  final pointInterval = 0.01;
  final slope = 0.008;
  List<Offset> points = [];

  void generatePoint([ int numPoints = 1 ]) {
    for (var n = 0; n < numPoints; n++) {
      perlinPos += slope;
      points.add(Offset(points.last.dx + pointInterval, remap(perlin.noise(0, perlinPos), -1, 1, min, max)));
    }
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
      for (var p = 2; p < points.length; p++) points[p] = points[p].translate(-gs.speed * parallax, 0);
      points.removeWhere((point) => point.dx < -1 - pointInterval);
      if (points.last.dx < 1) generatePoint();
    }
  }

}
