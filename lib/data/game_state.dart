import 'package:flutter/material.dart';

enum GameStatus {
  PLAYING,
  OVER,
  START
}

class GameState {

  GameState({
    this.windowSize = const Size(1.0, 1.0),
    this.gravity = -0.15,
    this.status = GameStatus.START,
    this.speed = 2.0,
  });

  GameState copyWith({
    Size windowSize,
    double gravity,
    GameStatus status,
    double speed,
  }) => GameState(
    windowSize: windowSize ?? this.windowSize,
    gravity: gravity ?? this.gravity,
    status: status ?? this.status,
    speed: speed ?? this.speed,
  );

  Size windowSize;
  double gravity;
  GameStatus status;
  double speed;

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

  double regularize(double value, [ Axis axis = Axis.horizontal ]) =>
    axis == Axis.horizontal
      ? value
      : value * -1;
  
  // alias for shorter invocation.
  double r(double v, [ Axis a = Axis.horizontal ]) => regularize(v, a);

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

GameState get gs => gameObservable?.value;
