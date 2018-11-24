import 'package:flutter/material.dart';

enum GameStatus {
  PLAYING,
  OVER,
  START
}

class GameState {

  factory GameState({
    Size windowSize = const Size(1.0, 1.0),
    double gravity = -0.1,
    GameStatus status,
  }) {
    _instance ??= GameState._internal(windowSize: windowSize, gravity: gravity, status: status);
    return _instance;
  }

  GameState._internal({
    this.windowSize = const Size(1.0, 1.0),
    this.gravity = -0.1,
    this.status = GameStatus.START
  }) {

  }

  static GameState _instance;

  Size windowSize;
  double gravity;
  GameStatus status;

  Offset globalOffset(Offset pos) =>
    balancedOffset(pos, Offset(windowSize.width, windowSize.height));

  Offset balancedOffset(Offset pos, Offset parent) {
    assert(pos.dx.abs() <= 1.0);
    assert(pos.dy.abs() <= 1.0);
    return Offset(
      (parent.dx / 2 * pos.dx) + (parent.dx / 2),
      (parent.dy / 2 * -pos.dy) + (parent.dy / 2)
    );
  }

  double regularize(double value, Axis axis) =>
    axis == Axis.horizontal
      ? value
      : value * -1;

}

ValueNotifier<GameState> gameObservable = ValueNotifier(GameState());
