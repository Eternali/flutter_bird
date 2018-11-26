import 'package:flutter/material.dart';

enum GameStatus {
  PLAYING,
  OVER,
  START
}

class GameState {

  GameState({
    this.windowSize = const Size(1.0, 1.0),
    this.gravity = -0.1,
    this.status = GameStatus.START,
  });

  GameState copyWith({
    Size windowSize,
    double gravity,
    GameStatus status
  }) => GameState(
    windowSize: windowSize ?? this.windowSize,
    gravity: gravity ?? this.gravity,
    status: status ?? this.status,
  );

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

ValueNotifier<GameState> _gameObservable;
ValueNotifier<GameState> get gameObservable => _gameObservable;
set gameObservable(dynamic newVal) {
  if (newVal is ValueNotifier<GameState> && _gameObservable == null) {
    _gameObservable = newVal;
  } else if (newVal is GameState && _gameObservable != null) {
    _gameObservable.value = newVal;
  }
}
