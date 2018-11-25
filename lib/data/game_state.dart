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
  });

  void copyWith({
    Size windowSize,
    double gravity,
    GameStatus status
  }) {
    var newState = GameState(
      windowSize: windowSize ?? _instance.windowSize,
      gravity: gravity ?? _instance.gravity,
      status: status ?? _instance.status
    );

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

class GameStateObservable {

  static ValueNotifier<GameState> _observable;
  static ValueNotifier<GameState> get observable => _observable;
  static set observable(dynamic newVal) {
    if (newVal is ValueNotifier<GameState> && _observable == null) {
      _observable = newVal;
    } else if (newVal is GameState && _observable != null) {
      _observable.value = newVal;
    }
  }

}
